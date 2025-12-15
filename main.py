import safety_gymnasium
import torch
import numpy as np
from mppo import MylarPPO

env = safety_gymnasium.make("SafetyPointGoal1-v0")
observation, info = env.reset(seed=0)

# Specific Observation Space
# ^^^^^^^^^^^^^^^^^^^^^^^^^^

# +-------+----------------+------+------+---------------+
# | Size  | Observation    | Min  | Max  | Max Distance  |
# +=======+================+======+======+===============+
# | 16    | goal lidar     | 0    | 1    | 3             |
# +-------+----------------+------+------+---------------+
# | 16    | hazards lidar  | 0    | 1    | 3             |
# +-------+----------------+------+------+---------------+
# | 16    | vases lidar    | 0    | 1    | 3             |
# +-------+----------------+------+------+---------------+

ACTIONS = {
    0: [0.0, 1.0],  # turn left
    1: [0.0, -1.0],   # turn right
    2: [1.0, 1.0],   # move forward
    3: [-1.0, 0.0],  # move backward
}

def sensor_wrapper_16(lidar):
   front = np.array([14, 15, 0, 1, 2])
   right = np.array([2,3,4,5,6])
   back = np.array([6,7,8,9,10])
   left = np.array([10,11,12,13,14])
   lidar = np.array(lidar)

   mean_front = np.mean(lidar[front])
   mean_right = np.mean(lidar[right])
   mean_back = np.mean(lidar[back])
   mean_left = np.mean(lidar[left])

   return [mean_front, mean_right, mean_back, mean_left]
    

def sensor_wrapper(observation):
      """Convert observation to symbolic representation."""
      if len(observation.shape) == 2:
         sensor_values = []
         for obs in observation:
            hazard_lidar = obs[-32:-16]
            vase_lidar = observation[:, -16:]
            hazard_sensors = sensor_wrapper_16(hazard_lidar)
            vase_sensors = sensor_wrapper_16(vase_lidar)
            sensor_values.append(torch.Tensor(hazard_sensors+vase_sensors))
         return torch.stack(sensor_values)
      
      elif len(observation.shape) == 1:
         hazard_lidar = observation[-32:-16]
         vase_lidar = observation[-16:]
         hazard_sensors = sensor_wrapper_16(hazard_lidar)
         vase_sensors = sensor_wrapper_16(vase_lidar)
         # print(hazard_sensors+vase_sensors)
         return torch.Tensor(hazard_sensors+vase_sensors)
      
def action_wrapper(action):
      """Convert symbolic action to low-level action."""
      # actions: turn left, turn right, move forward, move backward
      return torch.Tensor(ACTIONS[action])

# print(env.obs_space_dict)
# print(env.action_space)
# Dict('accelerometer': Box(-inf, inf, (3,), float64), 
#      'velocimeter': Box(-inf, inf, (3,), float64), 
#      'gyro': Box(-inf, inf, (3,), float64), 
#      'magnetometer': Box(-inf, inf, (3,), float64), 
#      'goal_lidar': Box(0.0, 1.0, (16,), float64), 
#      'hazards_lidar': Box(0.0, 1.0, (16,), float64), 
#      'vases_lidar': Box(0.0, 1.0, (16,), float64))
# A simple robot constrained to the 2D-plane, with one actuator for turning
# and another for moving forward/backwards

   #  def __init__(self, 
   #               state_dim, 
   #               action_dim, 
   #               lr_actor, 
   #               lr_critic, 
   #               gamma, 
   #               train_epochs, 
   #               eps_clip,
   #               update_timestep,
   #               alpha=0,
   #               policy_safety_params={},
   #               policy_kw_args={},
   #               vf_coef=0.5,
   #               entropy_coef=0.01,
   #               device="cpu",
   #               **kwargs # made to be comptible with DQN
   #               ):


sh_params = {
    "config_folder": '.',
    "num_sensors": 8,  # 16 hazards + 16 vases
    "num_actions": 4,
    "differentiable": True,
    "shield_program": "shield.pl",
    "observation_type": "ground truth",
    "get_sensor_value_ground_truth": sensor_wrapper,
}

agent = MylarPPO(
   state_dim=observation.shape[0],
   action_dim=4, # 4 symbolic actions
   lr_actor=0.001,
   lr_critic=0.001,
   gamma=0.99,
   train_epochs=20,
   eps_clip=0.2,
   update_timestep=1000,
   alpha=1,
   policy_safety_params=sh_params,
   policy_kw_args={"shield_params":sh_params, "get_sensor_value_ground_truth":sensor_wrapper}
)

rewards, costs = [], []
for _ in range(10000):
   action = agent.act(observation)
   observation, reward, cost, terminated, truncated, info = env.step(action_wrapper(action))

   agent.update_reward(reward, terminated or truncated, cost)
   rewards.append(reward)
   costs.append(cost)

   if terminated or truncated:
      observation, info = env.reset()

print("Average Reward:", sum(rewards)/len(rewards))
print("Average Cost:", sum(costs)/len(costs))

env.close()