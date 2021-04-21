import sys
import numpy as np
import gym
import time
import csv


# P is a dictionary: {s0: { a0:[ (p, s01, r, isEnd), ( , , , , ), (), () ], a1:[ (), (), (), () ] }, s1:{}   }
def valueIter(env, discountRate, maxIter, stopEps, seed = None):
  if seed is not None: np.random.seed(seed)
  stateValue = np.random.uniform(0.0, 1e-300, size = env.nS)
  newStateValue = np.zeros(env.nS)
  actionValues = np.zeros(env.nA)
  st = time.time()
  Niter = 0
  maxIter = int(maxIter)
  for k in range(maxIter):
    for state in range(env.nS):
      for action in range(env.nA):
        state_value = 0.0
        for i in range(len(env.P[state][action])):
          prob, nextState, reward, done = env.P[state][action][i]
          stateActionValue = prob * (reward + discountRate * stateValue[nextState])
          state_value += stateActionValue
        actionValues[action] = state_value
        bestAction = np.argmax(np.asarray(actionValues))
        newStateValue[state] = actionValues[bestAction]
    if np.amax(np.absolute(stateValue - newStateValue))  < stopEps:
      Niter = k; break
    else: stateValue, newStateValue = newStateValue, stateValue
  
  
  # Infer policy
  policy = np.zeros(env.nS, dtype = int)
  for state in range(env.nS):
    for action in range(env.nA):
      action_value = 0
      for i in range(len(env.P[state][action])):
        prob, nextState, r, _ = env.P[state][action][i]
        action_value += prob * (r + discountRate * stateValue[nextState])
      actionValues[action] = action_value
    bestAction = np.argmax(actionValues)
    policy[state] = bestAction
  
  
  return {"Nstate":env.nS, "method":"valueIteration", "discount":discountRate, 
          "valFun":tuple(stateValue), "optPol":tuple(policy), "Niter":Niter,
          "time":time.time() - st}



if 0: # Run from command.
  saveFileName = sys.argv[1]
  envName = sys.argv[2]
  discount = float(sys.argv[3])
  stopElipson = float(sys.argv[4])
  maxIter = int(float(sys.argv[5]))


  env = gym.make(envName).env


  rst = valueIter(env, discount, maxIter, stopElipson, seed = None)
  with open(saveFileName, 'w') as f:
    writer = csv.writer(f)
    for key, value in rst.items():
      writer.writerow([key, value])




def rewardUnderOptPol(env, optpol, maxStepInOneEpisode = 4096, Nepisode = 10000, seed = 42):
  # def policyIter(env, discountRate, pol, policyValStopEps):
  if seed is not None: np.random.seed(seed)
  # totalReward = 0.0
  epsoidRewards = np.zeros(Nepisode)
  NdidnotReachAbsorbState = 0
  for i in range(Nepisode):
    episodeTotalR = 0.0
    s = 0
    for k in range(maxStepInOneEpisode):
      action = optpol[s]
      # P is a dictionary: {s0: { a0:[ (p, s01, r, isEnd), ( , , , , ), ()], a1:[ (), (), (), () ] }, s1:{}   }
      choosingP = np.asarray([x[0] for x in env.P[s][action]])
      choice = np.random.choice(a = 3, size = 1, p = choosingP)[0]
      p, snew, r, isEnd = env.P[s][action][choice]
      episodeTotalR += r
      if isEnd: break
      s = snew
    NdidnotReachAbsorbState += k >= maxStepInOneEpisode
    epsoidRewards[i] = episodeTotalR
  # print(epsoidRewards)
  return np.mean(epsoidRewards), NdidnotReachAbsorbState


# 4x4 optMeanReward =  0.82417
# 8x8 optMeanReward =  1.0
# 16x16 optMeanReward =  0.33746
# 32x32 optMeanReward =  0.05718
# if __name__ == "__main__":
if 0:
  env = gym.make('FrozenLake4x4-v0').env
  valueIterRst = valueIter(env, maxIter = 1e9, discountRate = 0.999, stopEps = 1e-10, seed = 42)
  optPol = np.asarray(valueIterRst['optPol'])
  optMeanReward = rewardUnderOptPol(env, optPol, maxStepInOneEpisode = 4096, Nepisode = 100000, seed = None)
  print("4x4 optMeanReward = ", optMeanReward)


  env = gym.make('FrozenLake8x8-v0').env
  valueIterRst = valueIter(env, maxIter = 1e9, discountRate = 0.999, stopEps = 1e-10, seed = 42)
  optPol = np.asarray(valueIterRst['optPol'])
  optMeanReward = rewardUnderOptPol(env, optPol, maxStepInOneEpisode = 4096, Nepisode = 100000, seed = None)
  print("8x8 optMeanReward = ", optMeanReward)


if 1:
  env = gym.make('FrozenLake16x16-v0').env
  valueIterRst = valueIter(env, maxIter = 1e9, discountRate = 0.999, stopEps = 1e-10, seed = 42)
  optPol = np.asarray(valueIterRst['optPol'])
  optMeanReward = rewardUnderOptPol(env, optPol, maxStepInOneEpisode = 4096, Nepisode = 100000, seed = None)
  print("16x16 optMeanReward = ", optMeanReward)


  env = gym.make('FrozenLake32x32-v0').env
  valueIterRst = valueIter(env, maxIter = 1e9, discountRate = 0.999, stopEps = 1e-10, seed = 42)
  optPol = np.asarray(valueIterRst['optPol'])
  optMeanReward = rewardUnderOptPol(env, optPol, maxStepInOneEpisode = 4096, Nepisode = 100000, seed = None)
  print("32x32 optMeanReward = ", optMeanReward)











































