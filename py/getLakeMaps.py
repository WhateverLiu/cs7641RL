
import numpy as np
import sys
import gym
from pyfuns import *
import csv


def generate_random_map(size, p, seed):
    """Generates a random valid map (one that has a path from start to goal)
    :param size: size of each side of the grid
    :param p: probability that a tile is frozen
    """
    valid = False

    # DFS to check that it's a valid path.
    def is_valid(res):
        frontier, discovered = [], set()
        frontier.append((0, 0))
        while frontier:
            r, c = frontier.pop()
            if not (r, c) in discovered:
                discovered.add((r, c))
                directions = [(1, 0), (0, 1), (-1, 0), (0, -1)]
                for x, y in directions:
                    r_new = r + x
                    c_new = c + y
                    if r_new < 0 or r_new >= size or c_new < 0 or c_new >= size:
                        continue
                    if res[r_new][c_new] == 'G':
                        return True
                    if (res[r_new][c_new] != 'H'):
                        frontier.append((r_new, c_new))
        return False


    if seed is not None: np.random.seed(seed)
    while not valid:
        p = min(1, p)
        res = np.random.choice(['F', 'H'], (size, size), p=[p, 1-p])
        res[0][0] = 'S'
        res[-1][-1] = 'G'
        valid = is_valid(res)
    return ["".join(x) for x in res]


saveFileName = sys.argv[1]
size = int(sys.argv[2])
p = float(sys.argv[3])
seed = int(sys.argv[4])
amap = generate_random_map(size, p, seed)
# print(amap)
rst = []
for x in amap: 
  for y in x:
    if y == 'S': rst.append(2)
    elif y == 'F': rst.append(1)
    elif y == 'H': rst.append(0)
    elif y == 'G': rst.append(3)
rst = {'lakeMap':tuple(rst)}


with open(saveFileName, 'w') as f:
  writer = csv.writer(f)
  for key, value in rst.items():
    writer.writerow([key, value])








