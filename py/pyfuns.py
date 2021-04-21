

import re

def stringList2num(a):
  a = a.split(',')
  return [float(x) for x in a]

  
def stepwiseStringList2num(a):
  x = a.split(',,')
  rst = [stringList2num(a) for a in x]


def stepwiseStringList2numSinglevec(a):
  x = a.split(',,')
  rst = [stringList2num(a) for a in x]
  result = []
  for x in rst:
    for y in x:
      result.append(y)
  return result
  
  
def convertStringPara2singlenumvec(a):
  tmp = re.search(',,', a)
  if tmp: return stepwiseStringList2numSinglevec(a)
  return stringList2num(a)
  
  
def translateMap(desc):
  M = []
  for y in desc: 
    for x in y: 
      if x == b'S': M.append(int(2))
      elif x == b'F': M.append(int(1))
      elif x == b'H': M.append(int(0))
      elif x == b'G': M.append(int(3))
  return M
    

if __name__ == "__main__":
  # a = "3434-896.890-312.1"
  # y = stringList2num(a)
  # print(y)
  # [30, 50], valArray = [0.1, 0.01, 0.001]
  a = "3434,896.89,0.1,,0.01,0.001"
  tmp = convertStringPara2singlenumvec(a)
  print(tmp)




