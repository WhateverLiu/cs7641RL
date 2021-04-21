

# stop eps 1e-6
# For each environment, run algo 20 times.
# Value and policy iteration.
if(T)
{
  
  
  source("R/rfuns.R")
  unlink("lakeMDPiter", recursive = T)
  dir.create("lakeMDPiter", showWarnings = F)
  envNames = c("", "", "", "")
  
  
  
  
  
  
  
  Nstates = seq(3L, 51L, by = 2L)
  NrunEach = 20L
  k = 0L
  for(i in 1:length(Nstates))
  {
    cat(k, "")
    Nstate = Nstates[i]
    for(j in 1:NrunEach)
    {
      saveFileName = paste0("forestMDPiter/rst", k, ".txt")
      # tmp = system("tasklist", intern = T)
      valueIter(saveFileName = saveFileName, pyExeFilePath = "py/forestValueIter.py", Nstate = Nstate, discount = 0.9, stopElipson = 1e-10, r1 = 4, r2 = 2, p = 0.1, maxIter = 1e6L, wait = F)
      k = k + 1L
      
      
      saveFileName = paste0("forestMDPiter/rst", k, ".txt")
      policyIter(saveFileName = saveFileName, pyExeFilePath = "py/forestPolicyIter.py", Nstate = Nstate, discount = 0.9, r1 = 4, r2 = 2, p = 0.1, maxIter = 1e6L, wait = F)
      k = k + 1L
    }
  }
  
  
}
 

# Read in.
rst = lapply(list.files("forestMDPiter", full.names = T), function(x)
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
  
  
  # NstateVSvalFunErr, NstateVStime, NstateVSnIter
  tmp = data.frame(Nstate = NstateVSnIter$Nstate, NstateVSnIter[-1], NstateVStime[-1], policyValFunErr = NstateVSvalFunErr$err)
  forestValPolicyRst = tmp
  save(forestValPolicyRst, file = "result/forestValPolicyRst.Rdata")
}


# Plot.
if(T)
{
  
  
  load("result/forestValPolicyRst.Rdata")
  X = forestValPolicyRst
  
  
  pdf("figure/forestValPolicyRst.pdf", width = 10, height = 10 * 0.3)
  par(mar = c(4.1, 5, 0, 0), family = "serif", mfrow = c(1, 3))
  ylim = c(0, max(c(X$valueNiter, X$policyNiter)))
  plot(x = X$Nstate, y = X$valueNiter, ylim = ylim, col = "darkblue", bty = "L", xlab = "Number of states", ylab = "Number of iterations", type = "l", lwd = 2, cex.lab = 2, cex.axis = 1.5)
  lines(x = X$Nstate, y = X$policyNiter, col = "red", lwd = 2)
  legend("right", legend = c("Value iteration", "Policy iteration"), bty = "n", pch = c(15, 15), col = c("darkblue", "red"), cex = 2)
  
  
  
  ylim = log(range(c(X$valueTimeCost, X$policyTimeCost)))
  plot(x = X$Nstate, y = log(X$valueTimeCost), ylim = ylim, col = "darkblue", bty = "L", xlab = "", ylab = "Time cost (s)", type = "l", lwd = 2, cex.lab = 2, cex.axis = 1.5, yaxt = "n")
  lines(x = X$Nstate, y = log(X$policyTimeCost), col = "red", lwd = 2, yaxt = "n")
  axis(side = 2, at = log(c(1e-4, 1e-3, 1e-2, 1e-1, 1, 10, 100)), labels = c(1e-4, 1e-3, 1e-2, 1e-1, 1, 10, 100), cex.axis = 1.5)

  
  plot(x = X$Nstate, y = X$policyValFunErr, col = "black", bty = "L", xlab = "", ylab = "Error", type = "l", lwd = 2, cex.lab = 2, cex.axis = 1.5, yaxt = "s")
  # legend("top", legend = "Distance between value function and the optimal")
  dev.off()
  
  
  
  
  
  
}



















