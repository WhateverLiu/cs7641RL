import sys
import numpy as np
import gym
import time
import csv


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
  return {"Nstate":env.nS, "method":"policyIteration", "discount":discountRate, 
          "valFun":tuple(V), "optPol":tuple(pol), "Niter":Niter, 
          "time":time.time() - st}




saveFileName = sys.argv[1]
envName = sys.argv[2]
discount = float(sys.argv[3])
stopElipson = float(sys.argv[4])
maxIter = int(float(sys.argv[5]))


env = gym.make(envName).env
rst = policyIter(env, discount, None, stopElipson)
with open(saveFileName, 'w') as f:
  writer = csv.writer(f)
  for key, value in rst.items():
    writer.writerow([key, value])













