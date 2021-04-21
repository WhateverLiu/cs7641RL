import numpy as np
import gym
import time



# print(P)
# P is a dictionary: {s0: { a0:[ (p, s01, r, isEnd), ( , , , , ), (), () ], a1:[ (), (), (), () ] }, s1:{}   }


def valueIterOld(env, discountRate, maxIter, stopEps):
  maxIter = int(maxIter)
  stateValue = [0 for i in range(env.nS)]
  newStateValue = stateValue.copy()
  for k in range(maxIter):
    for state in range(env.nS):
      action_values = []      
      for action in range(env.nA):
        state_value = 0
        for i in range(len(env.P[state][action])):
          prob, next_state, reward, done = env.P[state][action][i]
          state_action_value = prob * (reward + discountRate * stateValue[next_state])
          state_value += state_action_value
        action_values.append(state_value)      #the value of each action
        best_action = np.argmax(np.asarray(action_values))   # choose the action which gives the maximum value
        newStateValue[state] = action_values[best_action]  #update the value of the state
      # print(action_values)
    if np.abs(np.sum(stateValue) - np.sum(newStateValue)) / env.nS < stopEps:   # if there is negligible difference break the loop
      break
    else:
      stateValue = newStateValue.copy()
  return stateValue
  
  
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
    if np.mean(np.absolute(stateValue - newStateValue))  < stopEps: 
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
  
  
  return {"Nstate":env.nS, "discount":discountRate, 
          "valFun":tuple(stateValue), "optPol":tuple(policy), "Niter":Niter,
          "time":time.time() - st}




def expectation(envP, V, s, a, discountRate):
  E = 0.0
  for p, s_, r, _ in envP[s][a]: 
    E += p * (r + discountRate * V[s_])
  return E


def policyIter(env, discountRate, pol, policyValStopEps):
  if pol is not None: np.random.seed(pol)
  pol = np.random.choice(env.nA, env.nS)
  V = np.zeros(env.nS)
  Niter = 0
  st = time.time()
  while True:
    while True:
      delta = 0
      for s in range(env.nS):
        v = V[s]
        V[s] = expectation(env.P, V, s, pol[s], discountRate)
        delta = np.amax((delta, np.absolute(v - V[s])))
      if delta < policyValStopEps: break
    
    
    policyStable = True
    for s in range(env.nS):
      oldaction = pol[s]
      pol[s] = np.argmax([
        expectation(env.P, V, s, a, discountRate) for a in range(env.nA)])
      policyStable = policyStable and oldaction == pol[s]
    if policyStable: break
    Niter += 1
  return {"Nstate":env.nS, "discount":discountRate, 
          "valFun":tuple(V), "optPol":tuple(pol), "Niter":Niter, 
          "time":time.time() - st}

# rst['problem'] = "forest"
#   rst['method'] = "policyIteration"
#   rst['Nstate'] = S
#   rst['discount'] = discount
#   rst['r1'] = r1
#   rst['r2'] = r2
#   rst['p'] = p
#   rst['maxIter'] = maxIter
#   rst['valFun'] = tuple(PI.V)
#   rst['optPol'] = tuple(PI.policy)
#   rst['Niter'] = PI.iter
#   rst['time'] = PI.time


env = gym.make('FrozenLake32x32-v0')
env = env.env # env.P


valueIterRst = valueIter(env, maxIter = 1e9, discountRate = 0.999, stopEps = 1e-6, seed = 13)
policyIterRst = policyIter(env, discountRate = 0.999, pol = 42, policyValStopEps = 1e-6)


print(np.sum(np.abs(np.asarray(policyIterRst['optPol']) - np.asarray(valueIterRst['optPol']))))

















# print(np.sum(np.absolute(np.asarray(tmp) - tmp2)))


# # =============================================================================
# # `Q` contains the potential for each state-action pair.
# # `R` contains the reward for each state-action pair.
# # `numpy` matrix is row-major, so each row of `Q` represents a state. This
# #   assumes states have equal numbers of actions that can be taken.
# # `eps` is the probability that agent takes a random action.
# # `gamma` is the discounted factor.
# # `alpha` is the step size / learning rate.
# # In this assignment, each step in an episode is given as an action taken.
# # =============================================================================
# def makemap(s):
#   n = int(np.round(np.sqrt(len(s))))
#   rst = []
#   for i in range(n):
#     k = i * n
#     rst.append(s[k:(k + n)])
#   return rst
# 
# 
# # =============================================================================
# def epsGreedyAction(env, Q, state, eps):
#   u = np.random.random()
#   if u < eps: 
#     sam = np.random.randint(env.action_space.n)
#   else: sam = np.argmax(Q[state, :])
#   return sam
#   
#   
# # =============================================================================
# def train(s, eps, gamma, alpha, Nepisode, seed):
#   s = makemap(s)
#   env = gym.make('FrozenLake-v0', desc = s).unwrapped
#   env.seed(seed)
#   np.random.seed(seed)
#   Q = np.zeros((env.observation_space.n, env.action_space.n))
#   for i in range(Nepisode):
#     state = env.reset()
#     action = epsGreedyAction(env, Q, state, eps)
#     done = False
#     while done is False:
#       newState, reward, done, info = env.step(action)
#       newAction = epsGreedyAction(env, Q, newState, eps)
#       Q[state, action] += \
#         alpha * (reward + gamma * Q[newState, newAction] - Q[state, action])
#       state = newState
#       action = newAction
#   act = '<v>^'
#   rst = ''
#   for i in range(len(Q)):
#     k = np.argmax(Q[i, :])
#     rst += act[k]
#   return rst  
# 
# 
# # =============================================================================
# amap="SFFFHFFFFFFFFFFG";
# gamma=1.0;
# alpha=0.25;
# epsilon=0.29;
# n_episodes=14697;
# seed=741684
# 
# 
# rst = train(amap, epsilon, gamma, alpha, n_episodes, seed); print(rst)









