% actions
action(0)::action(left);
action(1)::action(right);
action(2)::action(front);
action(3)::action(back).

% sensors (4 lidar values for hazards and 4 for vases)
sensor_value(0)::sensor(hazard_front).
sensor_value(1)::sensor(hazard_right).
sensor_value(2)::sensor(hazard_back).
sensor_value(3)::sensor(hazard_left).

hazard(front) :- sensor(hazard_front).
hazard(right) :- sensor(hazard_right).
hazard(back) :- sensor(hazard_back).
hazard(left) :- sensor(hazard_left).

% KB:
% If there is a hazard in direction X, then action X is bad.
% bad_act :- action(A), hazard(X).

% unsafe_next :- \+bad_act. % forces the agent to take bad actions

unsafe_next :- action(left), \+sensor(hazard_left).

safe_next :- \+unsafe_next.