import sys
try:
   import cPickle as pickle
except:
   import pickle
import mdptoolbox.example
import numpy as np
import csv


# Action 0: do nothing, 1: cut down the forest and sell logs.
# S: the number of states (the ends of S years)
# r1: reward of being at state S - 1 and leave the forest alone.
# r2: reward of being at state S - 1 and cut down the forest.
# 1: reward of cutting down forest at any state.
# p: probability of a fire burning down the forest.
# P: P[x, y, z]: probability of reaching State z from State y by taking action x.
# R: R[x, y]: reward of taking action y while in State x. The reward is the same
#   regardless of the destination state.


saveFileName = None
cmd = 1


if not cmd:
  S = 20
  discount = 0.9
  r1 = 4
  r2 = 2
  p = 0.1
  maxIter = 1000
else: # Read from command line.
  saveFileName = sys.argv[1]
  S = int(sys.argv[2]) # Number of states.
  discount = float(sys.argv[3])
  r1 = float(sys.argv[4])
  r2 = float(sys.argv[5])
  p = float(sys.argv[6])
  maxIter = int(float(sys.argv[7]))
  

policy0 = -1 # 0 or > 0. If latter, use it as random seed to initialize policy.
is_sparse = 0 # 0 or 1


if policy0 < 0: policy0 = np.random.choice(2, S)
elif policy0 == 0: policy0 = None
else: 
  np.random.seed(policy0)
  policy0 = np.random.choice(2, S)


P, R = mdptoolbox.example.forest(S = S, r1 = r1, r2 = r2, p = p, is_sparse = is_sparse)


PI = mdptoolbox.mdp.PolicyIteration(transitions = P, reward = R, discount = discount, 
  policy0 = policy0, max_iter = maxIter, eval_type = 0)
  
  
PI.run()


if not cmd:
  print("Value function = ", np.round(PI.V, 2))
  print("Optimal policy = ", PI.policy)
  print("N(iter) = ", PI.iter)
  print("Time cost = ", np.round(PI.time, 5))


if saveFileName is not None:
  rst = {}
  rst['problem'] = "forest"
  rst['method'] = "policyIteration"
  rst['Nstate'] = S
  rst['discount'] = discount
  rst['r1'] = r1
  rst['r2'] = r2
  rst['p'] = p
  rst['maxIter'] = maxIter
  rst['valFun'] = tuple(PI.V)
  rst['optPol'] = tuple(PI.policy)
  rst['Niter'] = PI.iter
  rst['time'] = PI.time
  with open(saveFileName, 'w') as f:
    writer = csv.writer(f)
    for key, value in rst.items():
       writer.writerow([key, value])
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       



