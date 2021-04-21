import numpy as np


class ExponentialSchedule():
  def __init__(self, initval, decayRate, minVal):
    self.minVal = minVal
    self.val = initval
    self.decayRate = 1 - decayRate
  def spit(self):
    rst = self.val
    self.val = max(self.minVal, self.decayRate * self.val)
    return rst
  

class LinearSchedule():
  def __init__(self, initval, decayRate, minVal):
    self.val = initval
    self.decayRate = decayRate
    self.minVal = minVal
  def spit(self):
    rst = self.val
    self.val = max(self.minVal, self.val - self.decayRate)
    return rst


# Niterarray = [30, 50], valArray = [0.1, 0.01, 0.001]
# means the first 30 iterations uses 0.1, the next 50 iterations
# uses 0.01, and 0.001 afterwards.
class StepwiseSchedule():
  def __init__(self, NiterList, valList):
    self.itera = 0
    self.count = 0
    NiterList.append(float('inf'))
    self.NiterList = np.cumsum(np.asarray(NiterList))
    self.valList = np.asarray(valList)
  def spit(self):
    rst = self.valList[self.count]
    self.itera += 1
    self.count += self.itera > self.NiterList[self.count]
    return rst
  

if __name__ == "__main__":
  tmp = StepwiseSchedule([30, 50], [0.1, 0.01, 0.001])
  for i in range(100):
    print(tmp.spit(), end = ", ")
  print()
  
    
  tmp = LinearSchedule(0.9, 0.1, 0.001)
  for i in range(100):
    print(tmp.spit(), end = ", ")
  print()
  
    
  tmp = ExpoSchedule(0.9, 0.1, 0.001)
  for i in range(100):
    print(tmp.spit(), end = ", ")


















