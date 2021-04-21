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
  S = 50
  discount = 0.9
  stopElipson = 1e-10
  r1 = 4
  r2 = 2
  p = 0.1
  maxIter = 1000
else: # Read from command line.
  saveFileName = sys.argv[1]
  S = int(sys.argv[2]) # Number of states.
  discount = float(sys.argv[3])
  stopElipson = float(sys.argv[4])
  r1 = float(sys.argv[5])
  r2 = float(sys.argv[6])
  p = float(sys.argv[7])
  maxIter = int(float(sys.argv[8]))
  

value0 = -1 # 0 or > 0. If latter, use it as random seed to initialize policy.
is_sparse = 0 # 0 or 1


if value0 < 0:
  value0 = np.random.uniform(size = S) * 1e-200
elif value0 == 0: value0 = np.zeros(S)
else: 
  np.random.seed(value0)
  value0 = np.random.uniform(size = S) * 1e-200


P, R = mdptoolbox.example.forest(S = S, r1 = r1, r2 = r2, p = p, is_sparse = is_sparse)


X = mdptoolbox.mdp.ValueIteration(transitions = P, reward = R, discount = discount, 
  initial_value = value0, max_iter = maxIter, epsilon = stopElipson)
  
  
X.run()


if not cmd:
  print("Value function = ", np.round(X.V, 2))
  print("Optimal policy = ", X.policy)
  print("N(iter) = ", X.iter)
  print("Time cost = ", np.round(X.time, 5))


if saveFileName is not None:
  rst = {}
  rst['problem'] = "forest"
  rst['method'] = "valueIteration"
  rst['Nstate'] = S
  rst['discount'] = discount
  rst['stopElipson'] = stopElipson
  rst['r1'] = r1
  rst['r2'] = r2
  rst['p'] = p
  rst['maxIter'] = maxIter
  rst['valFun'] = tuple(X.V)
  rst['optPol'] = tuple(X.policy)
  rst['Niter'] = X.iter
  rst['time'] = X.time
  with open(saveFileName, 'w') as f:
    writer = csv.writer(f)
    for key, value in rst.items():
       writer.writerow([key, value])
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       



