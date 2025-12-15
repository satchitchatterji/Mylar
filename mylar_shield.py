import csv, random
from problog.program import PrologString
from probfoil.data import DataFile
import time
from probfoil.probfoil import ProbFOIL, ProbFOIL2
import re
from typing import Dict, List, Tuple, Any
import numpy as np

class MylarShield:
    def __init__(self, actions=list(), sensors=list(), normalization_fn=None, log=True):
        self.actions = actions
        self.sensors = sensors
        self.normalization_fn = normalization_fn
        self.NEG_KEEP_PROB = 0.3 # probability to keep zero-cost examples
        self.SENSOR_THRESHOLD = 0.1 # threshold to consider sensor "active"
        cur_time = time.strftime("%Y%m%d-%H%M%S")
        self.log_filename = f"logs/mylar_shield_learn_log_{cur_time}.txt"
        self.log_file = open(self.log_filename, 'a') if log else None
        if log:
            print(f"[MylarShield] Logging to {self.log_filename}")

    def log(self, *args):
        msg = " ".join([str(a) for a in args])
        print(msg)
        if self.log_file is not None:
            self.log_file.write(msg + "\n")

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
        import re, random
        from typing import List, Tuple, Dict, Any

        # Identify hazard_* and vase_* sensors by index
        hazard_sensors: List[Tuple[int, str]] = []
        vase_sensors: List[Tuple[int, str]] = []
        for idx, name in enumerate(sensors):
            if re.match(r"^hazard_\w+$", name):
                hazard_sensors.append((idx, name))
            elif re.match(r"^vase_\w+$", name):
                vase_sensors.append((idx, name))

        def _sort_key(x):
            try:
                return int(x)
            except Exception:
                return str(x)

        # ---------- PASS 1: build retained examples and track used predicates ----------
        examples = []
        used_action_preds = set()
        used_hazard_preds = set()
        used_vase_preds = set()

        for t in sorted(log_dict.keys(), key=_sort_key):
            rec = log_dict[t]

            cost = float(rec.get("safety cost", 0.0))
            if self.normalization_fn is not None:
                cost = self.normalization_fn(cost)
            if not (0.0 <= cost <= 1.0):
                raise ValueError(f"'safety cost' must be in [0,1]. Got {cost} at timestep {t}.")

            # undersample safe examples
            if cost == 0.0 and random.random() > self.NEG_KEEP_PROB:
                continue

            E = f"t{t}"
            sensor_vals = rec.get("sensor_values", [])
            if len(sensor_vals) != len(sensors):
                raise ValueError(
                    f"sensor_values length mismatch at timestep {t}: "
                    f"got {len(sensor_vals)}, expected {len(sensors)}"
                )

            active_haz = []
            for idx, sensor_name in hazard_sensors:
                if sensor_vals[idx] > self.SENSOR_THRESHOLD:
                    active_haz.append(sensor_name)
                    used_hazard_preds.add(sensor_name)

            active_vase = []
            for idx, sensor_name in vase_sensors:
                if sensor_vals[idx] > self.SENSOR_THRESHOLD:
                    active_vase.append(sensor_name)
                    used_vase_preds.add(sensor_name)

            # action -> act_<name>
            a_raw = rec.get("actions")
            try:
                a_idx = int(a_raw)
            except (TypeError, ValueError):
                a_idx = None

            if a_idx is not None and 0 <= a_idx < len(actions):
                act_name = str(actions[a_idx])
            else:
                act_name = str(a_raw)

            safe_act = re.sub(r"[^a-zA-Z0-9_]", "_", act_name)
            act_pred = f"act_{safe_act}"
            used_action_preds.add(act_pred)

            examples.append((E, active_haz, active_vase, act_pred, cost))

        # If we kept nothing, return a minimal file
        if not examples:
            program_str = (
                "%%%%%%%%%%%% SETTINGS %%%%%%%%%%%%\n\n"
                "learn(unsafe_next/1).\n\n"
                "example_mode(labeled).\n\n"
                "%%%%%%%%%%%% DATA %%%%%%%%%%%%\n"
            )
            with open("mylar_learn_input.pl", "w") as f:
                f.write(program_str)
            return program_str

        # ---------- SETTINGS: only declare used predicates ----------
        lines: List[str] = []
        lines += [
            "%%%%%%%%%%%% SETTINGS %%%%%%%%%%%%",
            "",
            "learn(unsafe_next/1).",
            "",
            "% allowed rule components",
        ]

        for p in sorted(used_action_preds):
            lines.append(f"mode({p}(+)).")
        for p in sorted(used_hazard_preds):
            lines.append(f"mode({p}(+)).")
        for p in sorted(used_vase_preds):
            lines.append(f"mode({p}(+)).")

        lines += ["", "% type declarations"]
        for p in sorted(used_action_preds):
            lines.append(f"base({p}(example)).")
        for p in sorted(used_hazard_preds | used_vase_preds):
            lines.append(f"base({p}(example)).")

        lines += [
            "base(unsafe_next(example)).",
            "",
            "example_mode(labeled).",
            "",
            "%%%%%%%%%%%% DATA %%%%%%%%%%%%",
            "",
        ]

        # ---------- PASS 2: emit data ----------
        for E, active_haz, active_vase, act_pred, cost in examples:
            for s in active_haz:
                lines.append(f"{s}({E}).")
            for s in active_vase:
                lines.append(f"{s}({E}).")
            lines.append(f"{act_pred}({E}).")
            lines.append(f"{cost:.3f}::unsafe_next({E}).")
            lines.append("")

        program_str = "\n".join(lines).rstrip() + "\n"
        with open("mylar_learn_input.pl", "w") as f:
            f.write(program_str)
        return program_str

    def _compile_probfoil_clauses_to_shield(self, clauses):
        """
        Transform learned ProbFOIL clauses into shield-style clauses.

        Learning-time predicates (what ProbFOIL sees):
            unsafe_next(E)
            act_<dir>(E)          % e.g. act_front(E), act_left(E)
            hazard_<dir>(E)       % e.g. hazard_front(E)
            vase_<dir>(E)         % e.g. vase_left(E)

        Shield-time predicates (what the runtime shield uses):
            unsafe_next.
            action(Dir).          % from act_<dir>(E)
            hazard(Dir).          % from hazard_<dir>(E)  (combined with your existing hazard/1)
            sensor(Name).         % for vases: sensor(vase_front), etc.

        Examples:
            unsafe_next(E) :- act_front(E), hazard_front(E).

        becomes:

            unsafe_next :- action(front), hazard(front).

        and

            unsafe_next(E) :- act_back(E), vase_left(E).

        becomes:

            unsafe_next :- action(back), sensor(vase_left).

        Any non-unsafe_next lines are ignored.
        """

        out_lines: List[str] = []

        # Work line-by-line; 'clauses' is a string
        for raw in clauses:
            line = str(raw).strip()
            if not line or line.startswith("%"):
                continue

            # Only care about clauses that define unsafe_next
            if "unsafe_next" not in line:
                continue

            # Drop any probability prefix like "0.8::unsafe_next(A) :- ..."
            line = re.sub(r"^\s*\d*\.?\d+\s*::\s*", "", line)

            # Head: unsafe_next(E) -> unsafe_next
            line = re.sub(
                r"\bunsafe_next\s*\(\s*[A-Za-z_][A-Za-z0-9_]*\s*\)",
                "unsafe_next",
                line,
            )

            # act_<dir>(E) -> action(dir)
            # e.g. act_front(E) -> action(front)
            line = re.sub(
                r"\bact_([A-Za-z0-9_]+)\s*\(\s*[A-Za-z_][A-Za-z0-9_]*\s*\)",
                r"action(\1)",
                line,
            )

            # hazard_<dir>(E) -> hazard(dir)
            # e.g. hazard_front(E) -> hazard(front)
            line = re.sub(
                r"\bhazard_([A-Za-z0-9_]+)\s*\(\s*[A-Za-z_][A-Za-z0-9_]*\s*\)",
                r"hazard(\1)",
                line,
            )

            # vase_<dir>(E) -> sensor(vase_dir)
            # e.g. vase_left(E) -> sensor(vase_left)
            # (Assumes your shield has sensor(vase_front), ... declarations)
            line = re.sub(
                r"\bvase_([A-Za-z0-9_]+)\s*\(\s*[A-Za-z_][A-Za-z0-9_]*\s*\)",
                r"sensor(vase_\1)",
                line,
            )

            # Normalize whitespace
            line = re.sub(r"\s+", " ", line).strip()

            # Ensure trailing '.'
            if not line.endswith("."):
                line += "."

            # Drop useless "unsafe_next :- fail."
            if line.replace(" ", "").lower() == "unsafe_next:-fail.":
                continue

            out_lines.append(line)

        return "\n".join(out_lines)

    def learn_probfoil(self, probfoil_program: str) -> str:
        """
        Learn ProbFOIL clauses from the given ProbFOIL program string.

        :param probfoil_program: full ProbFOIL program string (settings + data)
        :return: learned clauses as a string
        """
        data = DataFile(PrologString(probfoil_program))
        learn = ProbFOIL2(data, beam_size=5, logger='probfoil', verbose=2)
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

        self.log(f"[MylarShield] Extracted {len(actions)} actions and {len(sensors)} sensors from old shield.")
        # self.log("Actions:", actions)
        # self.log("Sensors:", sensors)

        # 2) Build ProbFOIL input
        probfoil_program = self.convert_str_log_to_pl(sensors, actions, log_dict)
        self.log("[MylarShield] Generated ProbFOIL program (to learn from) from logs.")
        self.log("[MylarShield] Length of ProbFOIL program:", probfoil_program.count('\n'), "lines")

        # self.log(probfoil_program[:500])

        # Check if there are any unsafe examples to learn from
        costs = [float(v["safety cost"]) for v in log_dict.values()]
        self.log("[MylarShield] Max safety cost in batch:", max(costs))
        self.log("[MylarShield] Min safety cost in batch:", min(costs))
        # self.log(costs)
        self.log("[MylarShield] Mean safety cost in batch:", np.mean(costs))
        max_cost = max(costs) if costs else 0.0
        if max_cost <= 0.0:
            # nothing unsafe in this batch -> keep old shield
            self.log("[MylarShield] No unsafe examples in batch, skipping ProbFOIL update.")
            return old_shield

        # 3) Learn clauses with ProbFOIL
        learned_clauses = self.learn_probfoil(probfoil_program)  # <- you provide this
        self.log("[MylarShield] Learned ProbFOIL clauses:")
        self.log(learned_clauses if len(learned_clauses) else "(none)")

        # 4) Compile to shield-style clauses
        shield_unsafe_clauses = self._compile_probfoil_clauses_to_shield(learned_clauses)
        self.log("[MylarShield] Learned shield unsafe_next clauses:")
        self.log(shield_unsafe_clauses if shield_unsafe_clauses.strip() else "(none)")
        normalized = " ".join(shield_unsafe_clauses.lower().split())
        if "unsafe_next :- true." in normalized:
            self.log("[MylarShield] ProbFOIL returned 'always unsafe'; keeping old shield.")
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

        self.log("[MylarShield] Generated new shield program.")
        self.log("--------------------------------------------------")
        self.log("\n".join(parts))
        self.log("--------------------------------------------------")

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
    Self.log(new_shield_str)