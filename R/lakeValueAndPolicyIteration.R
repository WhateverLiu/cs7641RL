



# States from 3 to 20, stop eps = 1e-5
# For each number of states, run algo 20 times.
# Value and policy iteration.
if(T)
{
  
  
  source("R/rfuns.R")
  unlink("lakeMDPiter", recursive = T)
  dir.create("lakeMDPiter", showWarnings = F)
  envs = c('FrozenLake4x4-v0', 'FrozenLake8x8-v0', 'FrozenLake16x16-v0', 'FrozenLake32x32-v0')
  NrunEach = 20L
  k = 0L
  for(i in 1:length(envs))
  # for(i in 1L)
  {
    cat(k, "")
    for(j in 1:NrunEach)
    # for(j in 2L)
    {
      saveFileName = paste0("lakeMDPiter/rst", k, ".txt")
      
      
      # if(envs[i] == "FrozenLake4x4-v0") stopElipson = 1e-4
      # else if(envs[i] == "FrozenLake8x8-v0") stopElipson = 1e-5
      # else if(envs[i] == "FrozenLake16x16-v0") stopElipson = 1e-7
      # else if(envs[i] == "FrozenLake32x32-v0") stopElipson = 1e-8
      
      
      lakeValueIter(saveFileName = saveFileName, pyExeFilePath = "py/lakeValueIter.py", envName = envs[i], discount = 0.999, stopElipson = 1e-8, maxIter = 1e6L, wait = F)
      k = k + 1L
      
      
      saveFileName = paste0("lakeMDPiter/rst", k, ".txt")
      lakePolicyIter(saveFileName = saveFileName, pyExeFilePath = "py/lakePolicyIter.py", envName = envs[i], discount = 0.999, stopElipson = 1e-8, maxIter = 1e6L, wait = F)
      k = k + 1L
    }
  }
  
  
}


# Read in.
rst = lapply(list.files("lakeMDPiter", full.names = T), function(x)
{
  readIn(x)
})




if(T)
{
  
  
  policyTmp = as.data.frame(t(as.data.frame(lapply(rst[unlist(lapply(rst, function(x) x$method == "policyIteration"))], function(x)
  {
    c(Nstate = x$Nstate, Niter = x$Niter)
  }))))
  policyTmp = policyTmp[order(policyTmp$Nstate), ] 
  
  
  valueTmp = as.data.frame(t(as.data.frame(lapply(rst[unlist(lapply(rst, function(x) x$method == "valueIteration"))], function(x)
  {
    c(Nstate = x$Nstate, Niter = x$Niter)
  }))))
  valueTmp = valueTmp[order(valueTmp$Nstate), ]
  NstateVSnIter = data.frame(Nstate = valueTmp$Nstate, valueNiter = valueTmp$Niter, policyNiter = policyTmp$Niter)
  
  
  NstateVSnIter = data.table::setDF(data.table::setDT(NstateVSnIter)[, .(valueNiter = mean(valueNiter), policyNiter = mean(policyNiter)), by = Nstate])
  
  
  policyTmp = as.data.frame(t(as.data.frame(lapply(rst[unlist(lapply(rst, function(x) x$method == "policyIteration"))], function(x)
  {
    c(Nstate = x$Nstate, timeCost = x$time)
  }))))
  policyTmp = policyTmp[order(policyTmp$Nstate), ] 
  
  
  valueTmp = as.data.frame(t(as.data.frame(lapply(rst[unlist(lapply(rst, function(x) x$method == "valueIteration"))], function(x)
  {
    c(Nstate = x$Nstate, timeCost = x$time)
  }))))
  valueTmp = valueTmp[order(valueTmp$Nstate), ]
  NstateVStime = data.frame(Nstate = valueTmp$Nstate, valueTimeCost = valueTmp$timeCost, policyTimeCost = policyTmp$timeCost)
  
  
  tmp = data.table::setDF(data.table::setDT(NstateVStime)[, .(valueTimeCost = mean(valueTimeCost), policyTimeCost = mean(policyTimeCost)), by = Nstate])
  NstateVStime = tmp
  
  
  itermethod = unlist(lapply(rst, function(x) x$method))
  iterNstate = unlist(lapply(rst, function(x) x$Nstate))
  iterValFun = lapply(rst, function(x) x$valFun)
  tmp = aggregate(list(ind = 1:length(iterNstate)), list(iterNstate = iterNstate, itermethod = itermethod), function(x) x, simplify = F)
  avgValFun = lapply(tmp$ind, function(x) rowMeans(as.data.frame(iterValFun[x])))
  tmp$ind = NULL
  tmp$avgValFun = avgValFun
  agg = tmp
  tmp = aggregate(agg[-1], agg["iterNstate"], function(x) x, simplify = F)
  NstateVSvalFunErr = data.frame(Nstate = tmp$iterNstate, err = unlist(lapply(tmp$avgValFun, function(x) sqrt(sum((x[[1]] / x[[2]] - 1) ^ 2) / length(x[[2]])))))
  
  
  # tmp = lapply(rst, function(x) x$optPol)
  agg = aggregate(list(1:length(rst)), by = list(Nstate = unlist(lapply(rst, function(x) x$Nstate)), method = unlist(lapply(rst, function(x) x$method))), function(x) x, simplify = F)
  tmp = lapply(agg[[3]], function(x) lapply(rst[x], function(u) u$optPol))
  tmp = lapply(tmp, function(x) as.integer(round(rowMeans(as.data.frame(x))) ))
  tmp = lapply(aggregate(list(pol = 1:length(tmp)), list(Nstate = as.integer(agg[[1]])), function(x) x, simplify = F)[[2]], function(x) tmp[x])
  cat("Difference in policies from value iteration and policy iteration: ", unlist(lapply(tmp, function(x) sum(as.integer(x[[1]]) != as.integer(x[[2]])))), "\n")
  
  
  
  
  # NstateVSvalFunErr, NstateVStime, NstateVSnIter
  tmp = data.frame(Nstate = NstateVSnIter$Nstate, NstateVSnIter[-1], NstateVStime[-1], policyValFunErr = NstateVSvalFunErr$err)
  lakeValPolicyRst = tmp
  save(lakeValPolicyRst, file = "result/lakeValPolicyRst.Rdata")
}


# Plot.
if(T)
{
  
  
  load("result/lakeValPolicyRst.Rdata")
  X = lakeValPolicyRst
  
  
  pdf("figure/lakeValPolicyRst.pdf", width = 10, height = 10 * 0.3)
  par(mar = c(4.1, 5, 0, 0), family = "serif", mfrow = c(1, 3))
  ylim = c(0, max(c(X$valueNiter, X$policyNiter)))
  plot(x = X$Nstate, y = X$valueNiter, ylim = ylim, col = "darkblue", bty = "L", xlab = "Number of states", ylab = "Number of iterations", type = "l", lwd = 2, cex.lab = 2, cex.axis = 1.5)
  lines(x = X$Nstate, y = X$valueNiter, pch = 16, type = "p", col = "darkblue", cex = 2)
  lines(x = X$Nstate, y = X$policyNiter, col = "red", lwd = 2)
  lines(x = X$Nstate, y = X$policyNiter, col = "red", type = "p", pch = 16, cex = 2)
  legend("right", legend = c("Value iteration", "Policy iteration"), bty = "n", pch = c(15, 15), col = c("darkblue", "red"), cex = 2)
  
  
  
  ylim = log(range(c(X$valueTimeCost, X$policyTimeCost)))
  plot(x = X$Nstate, y = log(X$valueTimeCost), ylim = ylim, col = "darkblue", bty = "L", xlab = "", ylab = "Time cost (s)", type = "l", lwd = 2, cex.lab = 2, cex.axis = 1.5, yaxt = "n")
  lines(x = X$Nstate, y = log(X$valueTimeCost), type = "p", pch = 16, cex = 2, col = "darkblue")
  lines(x = X$Nstate, y = log(X$policyTimeCost), col = "red", lwd = 2, yaxt = "n")
  lines(x = X$Nstate, y = log(X$policyTimeCost), type = "p", pch = 16, cex = 2, col = "red")
  axis(side = 2, at = log(c(1e-4, 1e-3, 1e-2, 1e-1, 1, 10, 100)), labels = c(1e-4, 1e-3, 1e-2, 1e-1, 1, 10, 100), cex.axis = 1.5)
  
  
  plot(x = X$Nstate, y = X$policyValFunErr, col = "black", bty = "L", xlab = "", ylab = "Error", type = "l", lwd = 2, cex.lab = 2, cex.axis = 1.5, yaxt = "s", ylim = c(0, 1))
  lines(x = X$Nstate, y = X$policyValFunErr, col = "black", pch = 16, cex = 2, type = "p")
  # legend("top", legend = "Distance between value function and the optimal")
  dev.off()
  
  
  
  
  
  
}



















