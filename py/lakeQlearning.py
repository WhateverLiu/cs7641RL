import sys
import numpy as np
import gym
import time
import csv
from schedule import *
from pyfuns import *
import time



# =============================================================================
# `Q` contains the potential for each state-action pair.
# `R` contains the reward for each state-action pair.
# `numpy` matrix is row-major, so each row of `Q` represents a state. This
#   assumes states have equal numbers of actions that can be taken.
# `eps` is the probability that agent takes a random action.
# `gamma` is the discounted factor.
# `alpha` is the step size / learning rate.
# In this assignment, each step in an episode is given as an action taken.
# =============================================================================
# def makemap(s):
#   n = int(np.round(np.sqrt(len(s))))
#   rst = []
#   for i in range(n):
#     k = i * n
#     rst.append(s[k:(k + n)])
#   return rst


# =============================================================================
def epsGreedyAction(env, Q, state, eps):
  u = np.random.random()
  if u < eps: 
    sam = np.random.randint(env.action_space.n)
  else: sam = np.argmax(Q[state, :])
  return sam
  
  
# =============================================================================
def train(env, gamma, Nepisode, epsSchedule, alphaSchedule):
  Q = np.zeros((env.nS, env.nA))
  episodeReward = np.zeros(Nepisode)
  st = time.time()
  statesVisited = np.zeros(env.nS, dtype = int)
  statesVisited[0] = 1
  for i in range(Nepisode):
    state = env.reset()
    done = False
    eps = epsSchedule.spit()
    alpha = alphaSchedule.spit()
    totalReward = 0.0
    while not done:
      action = epsGreedyAction(env, Q, state, eps)
      newState, reward, done, info = env.step(action)
      totalReward += reward
      bestAction = np.argmax(Q[newState, :])
      Q[state, action] += \
        alpha * (reward + gamma * Q[newState, bestAction] - Q[state, action])
      state = newState
      statesVisited[state] = 1
    episodeReward[i] = totalReward
  policy = np.argmax(Q, axis = 1)
  return {"Nstate":env.nS, "method":"Qlearning", "discount":gamma, "statesVisited":tuple(statesVisited),
  "optPol":tuple(policy), "rewardHist":tuple(episodeReward), "time":time.time() - st}




saveFileName = sys.argv[1]
envName = sys.argv[2]
discount = float(sys.argv[3])
epsScheduleType = sys.argv[4]
epsSchedulePara = sys.argv[5]
epsScheduleParaResv = epsSchedulePara
alphaScheduleType = sys.argv[6]
alphaSchedulePara = sys.argv[7]
alphaScheduleParaResv = alphaSchedulePara
Nepisode = int(float(sys.argv[8]))


epsSchedule = None
if epsScheduleType == "stepwiseSchedule":
  epsSchedulePara = stepwiseStringList2num(epsSchedulePara)
  epsSchedule = StepwiseSchedule(epsSchedulePara[0], epsSchedulePara[1])
elif epsScheduleType == "exponentialSchedule":
  epsSchedulePara = stringList2num(epsSchedulePara)
  # print(epsSchedulePara)
  epsSchedule = ExponentialSchedule(epsSchedulePara[0], epsSchedulePara[1], epsSchedulePara[2])
elif epsScheduleType == "linearSchedule":
  epsSchedulePara = stringList2num(epsSchedulePara)
  epsSchedule = LinearSchedule(epsSchedulePara[0], epsSchedulePara[1], epsSchedulePara[2])
  

alphaSchedule = None
if alphaScheduleType == "stepwiseSchedule":
  alphaSchedulePara = stepwiseStringList2num(alphaSchedulePara)
  alphaSchedule = StepwiseSchedule(alphaSchedulePara[0], alphaSchedulePara[1])
elif alphaScheduleType == "exponentialSchedule":
  alphaSchedulePara = stringList2num(alphaSchedulePara)
  alphaSchedule = ExponentialSchedule(alphaSchedulePara[0], alphaSchedulePara[1], alphaSchedulePara[2])
elif alphaScheduleType == "linearSchedule":
  alphaSchedulePara = stringList2num(alphaSchedulePara)
  alphaSchedule = LinearSchedule(alphaSchedulePara[0], alphaSchedulePara[1], alphaSchedulePara[2])
  

env = gym.make(envName).env
rst = train(env, discount, Nepisode, epsSchedule, alphaSchedule)
rst['lakeMap'] = tuple(translateMap(env.desc))
rst['epsScheduleType'] = epsScheduleType
rst['epsSchedulePara'] = tuple(convertStringPara2singlenumvec(epsScheduleParaResv))
rst['alphaScheduleType'] = alphaScheduleType
rst['alphaSchedulePara'] = tuple(convertStringPara2singlenumvec(alphaScheduleParaResv))


with open(saveFileName, 'w') as f:
  writer = csv.writer(f)
  for key, value in rst.items():
    writer.writerow([key, value])






