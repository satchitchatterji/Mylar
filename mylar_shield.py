import csv, random
from problog.program import PrologString
from probfoil.data import DataFile
import time
from probfoil.probfoil import ProbFOIL, ProbFOIL2
import re
from typing import Dict, List, Tuple, Any
import numpy as np

class MylarShield:
    def __init__(self, actions=list(), sensors=list(), normalization_fn=None):
        self.actions = actions
        self.sensors = sensors
        self.normalization_fn = normalization_fn
        self.NEG_KEEP_PROB = 0.2 # probability to keep zero-cost examples
        self.SENSOR_THRESHOLD = 0.3 # threshold to consider sensor "active"

    def _extract_actions_and_sensors_from_shield(self, old_shield):
        """
        Extract:
        - actions  (names in action/1)
        - sensors  (names in sensor/1)
        - preamble: the part of the shield before '% KB:' (kept verbatim)

        Expected action/sensor declarations like:

            action(0)::action(left);
            action(1)::action(right);
            ...
            sensor_value(0)::sensor(hazard_front).
            sensor_value(1)::sensor(hazard_right).
            ...

        Everything up to the first line starting with '% KB:' is considered
        the declaration preamble; any existing KB is ignored/replaced.
        """
        lines = old_shield.splitlines()

        # Cut off at "% KB:" (we'll replace KB with newly learned rules)
        cut = len(lines)
        for i, ln in enumerate(lines):
            if re.search(r"^\s*%\s*KB\s*:", ln):
                cut = i
                break
        decl_block = "\n".join(lines[:cut])

        # Extract action/sensor names from declaration block
        actions = re.findall(
            r"\baction\s*\(\s*\d+\s*\)\s*::\s*action\s*\(\s*([a-zA-Z_]\w*)\s*\)",
            decl_block,
        )
        sensors = re.findall(
            r"\bsensor_value\s*\(\s*\d+\s*\)\s*::\s*sensor\s*\(\s*([a-zA-Z_]\w*)\s*\)",
            decl_block,
        )

        # De-dup while preserving order
        def _dedup(seq):
            seen = set()
            out = []
            for x in seq:
                if x not in seen:
                    seen.add(x)
                    out.append(x)
            return out

        actions = _dedup(actions)
        sensors = _dedup(sensors)

        preamble = decl_block.rstrip() + "\n"
        return actions, sensors, preamble

    def convert_str_log_to_pl(
        self,
        sensors: List[str],
        actions: List[str],
        log_dict: Dict[Any, Dict[str, Any]],
    ) -> str:
        """
        Convert log_dict into a ProbFOIL program (settings + data) using unary
        predicates per direction/action:

            act_<dir>(E).          % chosen action direction at example E
            hazard_<dir>(E).       % hazard lidar active in direction <dir> at E
            vase_<dir>(E).         % vase lidar active in direction <dir> at E
            unsafe_next(E).        % probabilistic label from safety cost

        Expected log_dict format:
            log_dict[time_step] = {
                "sensor_values": <list of floats/ints aligned with `sensors`>,
                "actions": <int index into `actions` OR action name string>,
                "safety cost": <float>,  # will be normalized to [0,1] if needed
            }

        `sensors` is the list of sensor names from the shield, e.g.:
            ["hazard_front","hazard_right","hazard_back","hazard_left",
            "vase_front","vase_right","vase_back","vase_left"]
        """

        # Identify which sensor indices correspond to hazard_* and vase_* predicates
        hazard_sensors: List[Tuple[int, str]] = []  # (idx, 'hazard_front')
        vase_sensors: List[Tuple[int, str]] = []    # (idx, 'vase_left')

        for idx, name in enumerate(sensors):
            if re.match(r"^hazard_\w+$", name):
                hazard_sensors.append((idx, name))
            elif re.match(r"^vase_\w+$", name):
                vase_sensors.append((idx, name))

        # ---- SETTINGS ----
        lines: List[str] = []
        lines += [
            "%%%%%%%%%%%% SETTINGS %%%%%%%%%%%%",
            "",
            "learn(unsafe_next/1).",
            "",
            "% allowed rule components",
        ]

        # One mode per action direction: act_left(+), act_right(+), ...
        for act_name in actions:
            # guard in case action names aren't valid atoms (very defensive)
            safe_act = re.sub(r"[^a-zA-Z0-9_]", "_", act_name)
            lines.append(f"mode(act_{safe_act}(+)).")

        # One mode per hazard direction: hazard_front(+), etc.
        for _, sensor_name in hazard_sensors:
            lines.append(f"mode({sensor_name}(+)).")

        # One mode per vase direction: vase_front(+), etc. (optional, but useful)
        for _, sensor_name in vase_sensors:
            lines.append(f"mode({sensor_name}(+)).")

        lines += [
            "",
            "% type declarations",
        ]

        # One base per action direction
        for act_name in actions:
            safe_act = re.sub(r"[^a-zA-Z0-9_]", "_", act_name)
            lines.append(f"base(act_{safe_act}(example)).")

        # One base per hazard/vase sensor
        for _, sensor_name in hazard_sensors + vase_sensors:
            lines.append(f"base({sensor_name}(example)).")

        lines += [
            "base(unsafe_next(example)).",
            "",
            "example_mode(labeled).",
            "",
            "%%%%%%%%%%%% DATA %%%%%%%%%%%%",
            "",
        ]

        # ---- DATA ----

        # Deterministic order over time steps
        def _sort_key(x):
            try:
                return int(x)
            except Exception:
                return str(x)

        for t in sorted(log_dict.keys(), key=_sort_key):
            rec = log_dict[t]

            # Label: unsafe probability from (possibly normalized) safety cost
            cost = float(rec.get("safety cost", 0.0))
            if self.normalization_fn is not None:
                cost = self.normalization_fn(cost)
            if not (0.0 <= cost <= 1.0):
                raise ValueError(
                    f"'safety cost' must be in [0,1]. Got {cost} at timestep {t}."
                )

            # undersample zero-cost examples if needed
            if cost == 0.0 and random.random() > self.NEG_KEEP_PROB:
                continue

            E = f"t{t}"

            sensor_vals = rec.get("sensor_values", [])
            if len(sensor_vals) != len(sensors):
                raise ValueError(
                    f"sensor_values length mismatch at timestep {t}: "
                    f"got {len(sensor_vals)}, expected {len(sensors)}"
                )

            # Emit hazard_<dir>(E) for active hazard_* sensors
            for idx, sensor_name in hazard_sensors:
                v = sensor_vals[idx]
                if v > self.SENSOR_THRESHOLD:
                    lines.append(f"{sensor_name}({E}).")

            # Emit vase_<dir>(E) for active vase_* sensors (optional extra features)
            for idx, sensor_name in vase_sensors:
                v = sensor_vals[idx]
                if v > self.SENSOR_THRESHOLD:
                    lines.append(f"{sensor_name}({E}).")

            # Emit chosen action as act_<dir>(E)
            a = rec.get("actions")
            if isinstance(a, int):
                if not (0 <= a < len(actions)):
                    raise ValueError(
                        f"Action index out of range at timestep {t}: "
                        f"{a} not in [0, {len(actions)-1}]"
                    )
                act_name = actions[a]
            else:
                # assume string
                act_name = str(a)

            safe_act_name = re.sub(r"[^a-zA-Z0-9_]", "_", act_name)
            lines.append(f"act_{safe_act_name}({E}).")

            # Probabilistic label for unsafe_next(E)
            lines.append(f"{cost:.3f}::unsafe_next({E}).")
            lines.append("")

        program_str = "\n".join(lines).rstrip() + "\n"

        # save to file for inspection/debugging
        with open("mylar_learn_input.pl", "w") as f:
            f.write(program_str)

        return program_str


    def _compile_probfoil_clauses_to_shield(self, clauses: str) -> str:
        """
        Transform learned ProbFOIL clauses over unsafe_next(E), sensor(E, S), action(E, A)
        into shield-style clauses over unsafe_next, sensor(S), action(A).

        Assumes `clauses` is a ProbLog/Prolog chunk containing rules like:

            unsafe_next(E) :- sensor(E, stag_near_self), \+action(E, stay).

        Returns a string like:

            unsafe_next :- sensor(stag_near_self), \+action(stay).
            ...

        Any non-unsafe_next lines are ignored.
        """

        out_lines: List[str] = []

        for raw in clauses:
            raw = str(raw)
            line = raw.strip()
            if not line or line.startswith("%"):
                continue
            # if "unsafe_next" not in line:
            #     continue  # ignore other learned stuff if any

            # Drop probability annotations if they somehow appear (e.g., "0.8::unsafe_next(E) :- ...")
            # line = re.sub(r"^\s*\d*\.?\d+\s*::\s*", "", line)

            # Head: unsafe_next(E) -> unsafe_next
            line = re.sub(
                r"\bunsafe_next\s*\(\s*[A-Za-z_][A-Za-z0-9_]*\s*\)",
                "unsafe_next",
                line,
            )

            # Body: sensor(E, X) -> sensor(X)
            line = re.sub(
                r"\bsensor\s*\(\s*[A-Za-z_][A-Za-z0-9_]*\s*,\s*",
                "sensor(",
                line,
            )

            # Body: action(E, A) -> action(A)
            line = re.sub(
                r"\baction\s*\(\s*[A-Za-z_][A-Za-z0-9_]*\s*,\s*",
                "action(",
                line,
            )

            # Normalize whitespace
            line = re.sub(r"\s+", " ", line).strip()

            # Ensure trailing '.'
            if not line.endswith("."):
                line += "."

            out_lines.append(line)

        return "\n".join(out_lines)

    def learn_probfoil(self, probfoil_program: str) -> str:
        """
        Learn ProbFOIL clauses from the given ProbFOIL program string.

        :param probfoil_program: full ProbFOIL program string (settings + data)
        :return: learned clauses as a string
        """
        data = DataFile(PrologString(probfoil_program))
        learn = ProbFOIL2(data, beam_size=50, logger='probfoil', verbose=2)
        hypothesis = learn.learn()
        clauses = hypothesis.to_clauses(hypothesis.target.functor)
        if len(clauses) > 1:
            return clauses[1:]
        return clauses

    def generate_new_shield(self, old_shield: str, log_dict: Dict[Any, Dict[str, Any]]) -> str:
        """
        1. Extract actions and sensors from old_shield.
        2. Convert log_dict -> ProbFOIL program using convert_str_log_to_pl.
        3. Call learn_probfoil(...) to get learned unsafe_next(E) clauses.
        4. Compile those clauses into shield KB form:
            unsafe_next :- ...
        and add:
            safe_next :- \+unsafe_next.
        5. Prepend original actions/sensors preamble from old_shield.

        Returns: full shield string ready to be used by the RL agent.
        """
        # 1) Get actions/sensors + preamble
        actions, sensors, preamble = self._extract_actions_and_sensors_from_shield(old_shield)

        print(f"[MylarShield] Extracted {len(actions)} actions and {len(sensors)} sensors from old shield.")
        # print("Actions:", actions)
        # print("Sensors:", sensors)

        # 2) Build ProbFOIL input
        probfoil_program = self.convert_str_log_to_pl(sensors, actions, log_dict)
        print("[MylarShield] Generated ProbFOIL program (to learn from) from logs.")
        print("[MylarShield] Length of ProbFOIL program:", probfoil_program.count('\n'), "lines")

        # print(probfoil_program[:500])

        # Check if there are any unsafe examples to learn from
        costs = [float(v["safety cost"]) for v in log_dict.values()]
        print("[MylarShield] Max safety cost in batch:", max(costs))
        print("[MylarShield] Min safety cost in batch:", min(costs))
        # print(costs)
        print("[MylarShield] Mean safety cost in batch:", np.mean(costs))
        max_cost = max(costs) if costs else 0.0
        if max_cost <= 0.0:
            # nothing unsafe in this batch -> keep old shield
            print("[MylarShield] No unsafe examples in batch, skipping ProbFOIL update.")
            return old_shield

        # 3) Learn clauses with ProbFOIL
        learned_clauses = self.learn_probfoil(probfoil_program)  # <- you provide this
        print("[MylarShield] Learned ProbFOIL clauses:")
        print(learned_clauses if len(learned_clauses) else "(none)")

        # 4) Compile to shield-style clauses
        shield_unsafe_clauses = self._compile_probfoil_clauses_to_shield(learned_clauses)
        print("[MylarShield] Learned shield unsafe_next clauses:")
        print(shield_unsafe_clauses if shield_unsafe_clauses.strip() else "(none)")
        normalized = " ".join(shield_unsafe_clauses.lower().split())
        if "unsafe_next :- true." in normalized:
            print("[MylarShield] ProbFOIL returned 'always unsafe'; keeping old shield.")
            return old_shield

        # 5) Assemble final shield
        parts: List[str] = []
        parts.append(preamble.rstrip())
        parts.append("")
        parts.append("% KB:")
        if shield_unsafe_clauses.strip():
            parts.append(shield_unsafe_clauses.strip())
            parts.append("")
        # Always define safe_next in terms of unsafe_next
        # parts.append("bad_actions :- \\+unsafe_next.")
        # parts.append("safe_next :- \\+bad_actions.") # TODO: equating safe_next to not unsafe_next via bad_actions for now

        parts.append("safe_next :- \\+unsafe_next.")
        parts.append("")

        return "\n".join(parts)


# def parse_log_string(raw_data: str):
#     """
#     Convert raw log string into:
#       log_dict[time_step] = {
#           "sensor_values": [0/1, ...],
#           "actions": int,
#           "safety cost": float,
#       }
#     """
#     log_dict = {}

#     lines = raw_data.strip().splitlines()
#     for line in lines:
#         # Example line:
#         # [1 0 0 1 1 0],4,0,0,0
#         sensor_part, action, time_idx, safety, done = line.split(",")

#         # Parse sensors: "[1 0 0 1 1 0]" -> [1,0,0,1,1,0]
#         sensor_values = list(
#             map(int, sensor_part.strip("[]").split())
#         )

#         time_idx = int(time_idx)

#         log_dict[time_idx] = {
#             "sensor_values": sensor_values,
#             "actions": int(action),
#             "safety cost": float(safety),
#         }

#     return log_dict # this simulates the log_dict that would be passed in by an actual run

# def normalize_reward_to_norm(r):
#     # 10 == stag, 2 == hare, 0 == nothing, -2 == stag penalty
#     if r==10:
#         return 1
#     elif r==2:
#         return 0
#     elif r==-2:
#         return 1
#     else:
#         return 0
    
if __name__ == "__main__":
    
    # current step until now: run trajectory, collect data,
    # change to correct format. The next four lines are simulated;
    # in actuality they would come directly as a single string from
    # the appropriate PLPG agent

    example_data = parse_log_string(open("ppo_shielded_log_1.csv", 'r').read())
    old_shield_str = open("./shields/markov_stag_hunt/shield_v7.pl", 'r').read()

    shield_maker = MylarShield(normalization_fn=normalize_reward_to_norm)
    new_shield_str = shield_maker.generate_new_shield(old_shield_str, example_data)
    print(new_shield_str)