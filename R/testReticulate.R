



tmp = reticulate::source_python('py/test002.py')
a = as.matrix(runif(10))
b = as.matrix(runif(8))
ab = list(a = a, b = b)
tmp = reticulate::returnDisc("FrozenLake8x8-v0", ab)


















