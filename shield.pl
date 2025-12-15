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
sensor_value(4)::sensor(vase_front).
sensor_value(5)::sensor(vase_right).
sensor_value(6)::sensor(vase_back).
sensor_value(7)::sensor(vase_left).

hazard(X) :- sensor(hazard_front), X = front.
hazard(X) :- sensor(hazard_right), X = right.
hazard(X) :- sensor(hazard_back), X = back.
hazard(X) :- sensor(hazard_left), X = left.

% KB:
% all actions are safe
bad_act :- action(A), hazard(X).

unsafe_next :- \+bad_act.

safe_next :- \+unsafe_next.