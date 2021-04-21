import sys
try:
   import cPickle as pickle
except:
   import pickle
import mdptoolbox.example
import numpy as np
import csv
from schedule import *
from pyfuns import *
import time


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
  stopElipson = 0.01
  r1 = 4
  r2 = 2
  p = 0.1
  maxIter = 1000
else: # Read from command line.
  saveFileName = sys.argv[1]
  S = int(sys.argv[2]) # Number of states.
  discount = float(sys.argv[3])
  epsScheduleType = sys.argv[4]
  epsSchedulePara = sys.argv[5]
  epsScheduleParaResv = epsSchedulePara
  alphaScheduleType = sys.argv[6]
  alphaSchedulePara = sys.argv[7]
  alphaScheduleParaResv = alphaSchedulePara
  # print(sys.argv[8])
  r1 = float(sys.argv[8])
  r2 = float(sys.argv[9])
  p = float(sys.argv[10])
  maxIter = int(float(sys.argv[11]))


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
  



P, R = mdptoolbox.example.forest(S = S, r1 = r1, r2 = r2, p = p, is_sparse = False)


# self, transitions, reward, discount, 
# epsSchedule, alphaSchedule, initQ, n_iter = 10000
initQ = np.random.uniform(0, 1, size = (S, 2)) * 1e-500
X = mdptoolbox.mdp.QLearning(transitions = P, reward = R, discount = discount,
  epsSchedule = epsSchedule, alphaSchedule = alphaSchedule, initQ = initQ, n_iter = maxIter)

  
X.run()


if not cmd:
  print("Value function = ", np.round(X.V, 2))
  print("Optimal policy = ", X.policy)
  print("N(iter) = ", X.iter)
  print("Time cost = ", np.round(X.time, 5))


if saveFileName is not None:
  rst = {}
  rst['problem'] = "forest"
  rst['method'] = "Qlearning"
  rst['Nstate'] = S
  rst['discount'] = discount
  rst['epsScheduleType'] = epsScheduleType
  rst['epsSchedulePara'] = tuple(convertStringPara2singlenumvec(epsScheduleParaResv))
  rst['alphaScheduleType'] = alphaScheduleType
  rst['alphaSchedulePara'] = tuple(convertStringPara2singlenumvec(alphaScheduleParaResv))
  rst['r1'] = r1
  rst['r2'] = r2
  rst['p'] = p
  rst['Niter'] = maxIter
  rst['valFun'] = tuple(X.V)
  rst['optPol'] = tuple(X.policy)
  # rst['QmeanDiscrepency'] = tuple(X.mean_discrepancy)
  rst['rewardHist'] = tuple(X.rewardHist)
  rst['time'] = X.time
  with open(saveFileName, 'w') as f:
    writer = csv.writer(f)
    for key, value in rst.items():
       writer.writerow([key, value])
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       




















