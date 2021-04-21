import numpy as np
import gym


def returnDisc(envName, testlist):
  env = gym.make(envName).env
  desc = []
  for x in env.desc: 
    for y in x: desc.append(y.decode('UTF8'))
  rstList = {}
  for x in testlist.keys(): rstList[x] = testlist[x] + 1.0
  return {"lake": desc, "testlist": rstList}


if 0:
  a = np.zeros(10)
  b = np.ones(10)
  tmp = returnDisc("FrozenLake4x4-v0", {"a":a, "b":b})
  print(tmp)




