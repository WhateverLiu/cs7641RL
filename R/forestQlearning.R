

source("R/rfuns.R")
# Fixed parameters
r1 = 4
r2 = 2
p = 0.1


# Q learning trial and error, eps constant 0.1 --> 0.1
if(T)
{
  
  
  rst = list()
  for(i in 1:10)
  {
    Nstate = 6L
    maxIter = 30000L
    maxIterDecay = maxIter * 0.6666
    
    
    paralist = list()
    dir.create("result", showWarnings = F)
    paralist$rstFile = "result/forestQlearning.txt"
    paralist$Nstate = Nstate
    paralist$discount = 0.9
    
    
    iniEps = 0.1; endEps = 0.1
    paralist$epsScheduleType = "exponentialSchedule"
    decayEps = exponentialDecayInMaxIter(iniEps, endEps, maxIterDecay)
    paralist$epsSchedulePara = c(iniEps, decayEps, endEps)
    
    
    iniAlpha = 0.1; endAlpha = 0.1
    paralist$alphaScheduleType = "exponentialSchedule"
    decayAlpha = exponentialDecayInMaxIter(iniAlpha, endAlpha, maxIterDecay)
    paralist$alphaSchedulePara = c(iniAlpha, decayAlpha, endAlpha)
    
    
    #-------------------------------------------------
    paralist$r1 = r1; paralist$r2 = r2; paralist$p = p
    #-------------------------------------------------
    paralist$maxIter = maxIter
    paraString = QlearningMakeParaString(paralist)
    exe = paste0("python py/forestQlearning.py ", paraString)
    system(exe)
    
    
    tmp = readIn(paralist$rstFile)
    print(tmp$optPol)
    tmp$meanReward =  windowMean(tmp$rewardHist, windowSize = 300)
    plot(tmp$meanReward, type = "l", ylim = c(0, 3))
    rst[[length(rst) + 1]] = tmp
  }
  
  
  
  save(rst, file = "result/forestQlearningEpsConst-0.1-0.1.Rdata")
}




# Q learning trial and error, eps exponential 0.1 --> 0.01
if(T)
{
  
  
  rst = list()
  for(i in 1:10)
  {
    Nstate = 6L
    maxIter = 30000L
    maxIterDecay = maxIter * 0.6666
    
    
    paralist = list()
    dir.create("result", showWarnings = F)
    paralist$rstFile = "result/forestQlearning.txt"
    paralist$Nstate = Nstate
    paralist$discount = 0.9
    
    
    iniEps = 0.1; endEps = 0.01
    paralist$epsScheduleType = "exponentialSchedule"
    decayEps = exponentialDecayInMaxIter(iniEps, endEps, maxIterDecay)
    paralist$epsSchedulePara = c(iniEps, decayEps, endEps)
    
    
    iniAlpha = 0.1; endAlpha = 0.1
    paralist$alphaScheduleType = "exponentialSchedule"
    decayAlpha = exponentialDecayInMaxIter(iniAlpha, endAlpha, maxIterDecay)
    paralist$alphaSchedulePara = c(iniAlpha, decayAlpha, endAlpha)
    
    
    #-------------------------------------------------
    paralist$r1 = r1; paralist$r2 = r2; paralist$p = p
    #-------------------------------------------------
    paralist$maxIter = maxIter
    paraString = QlearningMakeParaString(paralist)
    exe = paste0("python py/forestQlearning.py ", paraString)
    system(exe)
    
    
    tmp = readIn(paralist$rstFile)
    print(tmp$optPol)
    tmp$meanReward =  windowMean(tmp$rewardHist, windowSize = 300)
    plot(tmp$meanReward, type = "l", ylim = c(0, 3))
    rst[[length(rst) + 1]] = tmp
  }
  
  
  save(rst, file = "result/forestQlearningEpsExp-0.1-0.01.Rdata")
}


# Q learning trial and error, eps exponential 0.5 --> 0.01
if(T)
{
  
  
  rst = list()
  for(i in 1:10)
  {
    Nstate = 6L
    maxIter = 30000L
    maxIterDecay = maxIter * 0.6666
    
    
    paralist = list()
    dir.create("result", showWarnings = F)
    paralist$rstFile = "result/forestQlearning.txt"
    paralist$Nstate = Nstate
    paralist$discount = 0.9
    
    
    iniEps = 0.5; endEps = 0.01
    paralist$epsScheduleType = "exponentialSchedule"
    decayEps = exponentialDecayInMaxIter(iniEps, endEps, maxIterDecay)
    paralist$epsSchedulePara = c(iniEps, decayEps, endEps)
    
    
    iniAlpha = 0.1; endAlpha = 0.1
    paralist$alphaScheduleType = "exponentialSchedule"
    decayAlpha = exponentialDecayInMaxIter(iniAlpha, endAlpha, maxIterDecay)
    paralist$alphaSchedulePara = c(iniAlpha, decayAlpha, endAlpha)
    
    
    #-------------------------------------------------
    paralist$r1 = r1; paralist$r2 = r2; paralist$p = p
    #-------------------------------------------------
    paralist$maxIter = maxIter
    paraString = QlearningMakeParaString(paralist)
    exe = paste0("python py/forestQlearning.py ", paraString)
    system(exe)
    
    
    tmp = readIn(paralist$rstFile)
    print(tmp$optPol)
    tmp$meanReward =  windowMean(tmp$rewardHist, windowSize = 300)
    plot(tmp$meanReward, type = "l", ylim = c(0, 3))
    rst[[length(rst) + 1]] = tmp
  }
  
  
  save(rst, file = "result/forestQlearningEpsExp-0.5-0.01.Rdata")
}


# Q learning trial and error, eps exponential 1 --> 0.01
if(T)
{
  
  
  rst = list()
  for(i in 1:10)
  {
    Nstate = 6L
    maxIter = 30000L
    maxIterDecay = maxIter * 0.6666
    
    
    paralist = list()
    dir.create("result", showWarnings = F)
    paralist$rstFile = "result/forestQlearning.txt"
    paralist$Nstate = Nstate
    paralist$discount = 0.9
    
    
    iniEps = 1; endEps = 0.01
    paralist$epsScheduleType = "exponentialSchedule"
    decayEps = exponentialDecayInMaxIter(iniEps, endEps, maxIterDecay)
    paralist$epsSchedulePara = c(iniEps, decayEps, endEps)
    
    
    iniAlpha = 0.1; endAlpha = 0.1
    paralist$alphaScheduleType = "exponentialSchedule"
    decayAlpha = exponentialDecayInMaxIter(iniAlpha, endAlpha, maxIterDecay)
    paralist$alphaSchedulePara = c(iniAlpha, decayAlpha, endAlpha)
    
    
    #-------------------------------------------------
    paralist$r1 = r1; paralist$r2 = r2; paralist$p = p
    #-------------------------------------------------
    paralist$maxIter = maxIter
    paraString = QlearningMakeParaString(paralist)
    exe = paste0("python py/forestQlearning.py ", paraString)
    system(exe)
    
    
    tmp = readIn(paralist$rstFile)
    print(tmp$optPol)
    tmp$meanReward =  windowMean(tmp$rewardHist, windowSize = 300)
    plot(tmp$meanReward, type = "l", ylim = c(0, 3))
    rst[[length(rst) + 1]] = tmp
  }
  
  
  save(rst, file = "result/forestQlearningEpsExp-1-0.01.Rdata")
}




# Q learning trial and error, eps linear 0.5 --> 0.01
if(T)
{
  
  
  rst = list()
  for(i in 1:10)
  {
    Nstate = 6L
    maxIter = 30000L
    maxIterDecay = maxIter * 0.6666
    
    
    paralist = list()
    dir.create("result", showWarnings = F)
    paralist$rstFile = "result/forestQlearning.txt"
    paralist$Nstate = Nstate
    paralist$discount = 0.9
    
    
    iniEps = 0.5; endEps = 0.01
    paralist$epsScheduleType = "linearSchedule"
    decayEps = linearDecayInMaxIter(iniEps, endEps, maxIterDecay)
    paralist$epsSchedulePara = c(iniEps, decayEps, endEps)
    
    
    iniAlpha = 0.1; endAlpha = 0.1
    paralist$alphaScheduleType = "exponentialSchedule"
    decayAlpha = exponentialDecayInMaxIter(iniAlpha, endAlpha, maxIterDecay)
    paralist$alphaSchedulePara = c(iniAlpha, decayAlpha, endAlpha)
    
    
    #-------------------------------------------------
    paralist$r1 = r1; paralist$r2 = r2; paralist$p = p
    #-------------------------------------------------
    paralist$maxIter = maxIter
    paraString = QlearningMakeParaString(paralist)
    exe = paste0("python py/forestQlearning.py ", paraString)
    system(exe)
    
    
    tmp = readIn(paralist$rstFile)
    print(tmp$optPol)
    tmp$meanReward =  windowMean(tmp$rewardHist, windowSize = 300)
    plot(tmp$meanReward, type = "l", ylim = c(0, 3))
    rst[[length(rst) + 1]] = tmp
  }
  
  
  
  save(rst, file = "result/forestQlearningEpsLinear-0.5-0.01.Rdata")
}


# Q learning trial and error, eps linear 1 --> 0.01
if(T)
{
  
  
  rst = list()
  for(i in 1:10)
  {
    Nstate = 6L
    maxIter = 30000L
    maxIterDecay = maxIter * 0.6666
    
    
    paralist = list()
    dir.create("result", showWarnings = F)
    paralist$rstFile = "result/forestQlearning.txt"
    paralist$Nstate = Nstate
    paralist$discount = 0.9
    
    
    iniEps = 1; endEps = 0.01
    paralist$epsScheduleType = "linearSchedule"
    decayEps = linearDecayInMaxIter(iniEps, endEps, maxIterDecay)
    paralist$epsSchedulePara = c(iniEps, decayEps, endEps)
    
    
    iniAlpha = 0.1; endAlpha = 0.1
    paralist$alphaScheduleType = "exponentialSchedule"
    decayAlpha = exponentialDecayInMaxIter(iniAlpha, endAlpha, maxIterDecay)
    paralist$alphaSchedulePara = c(iniAlpha, decayAlpha, endAlpha)
    
    
    #-------------------------------------------------
    paralist$r1 = r1; paralist$r2 = r2; paralist$p = p
    #-------------------------------------------------
    paralist$maxIter = maxIter
    paraString = QlearningMakeParaString(paralist)
    exe = paste0("python py/forestQlearning.py ", paraString)
    system(exe)
    
    
    tmp = readIn(paralist$rstFile)
    print(tmp$optPol)
    tmp$meanReward =  windowMean(tmp$rewardHist, windowSize = 300)
    plot(tmp$meanReward, type = "l", ylim = c(0, 3))
    rst[[length(rst) + 1]] = tmp
  }
  
  
  
  save(rst, file = "result/forestQlearningEpsLinear-1-0.01.Rdata")
  
  
  # load("result/forestQlearningEpsExp-0.1-0.01.Rdata")
}







# Plot Q learning reward history.
if(T)
{
  result = list()
  load("result/forestQlearningEpsConst-0.1-0.1.Rdata")
  result[[length(result) + 1]] = rst
  load("result/forestQlearningEpsExp-0.1-0.01.Rdata")
  result[[length(result) + 1]] = rst
  load("result/forestQlearningEpsExp-0.5-0.01.Rdata")
  result[[length(result) + 1]] = rst
  load("result/forestQlearningEpsExp-1-0.01.Rdata")
  result[[length(result) + 1]] = rst
  load("result/forestQlearningEpsLinear-0.5-0.01.Rdata")
  result[[length(result) + 1]] = rst
  load("result/forestQlearningEpsLinear-1-0.01.Rdata")
  result[[length(result) + 1]] = rst
  gotOptPol = lapply(result, function(x) unlist(lapply(x, function(x) sum(x$optPol) == 0L)))
  
  
  
  
  resultRewardHist = lapply(result, function(x) lapply(x, function(u) windowMean(u$rewardHist, windowSize = 300)))
  epsDecayRateHist = list()
  epsDecayRateHist[[length(epsDecayRateHist) + 1]] = windowAvgDecayRate(inival = 0.1, endval = 0.1, decaytype = "constant", maxIter = 30000, decayIter = 30000 * 0.6666, windowSize = 300L)
  epsDecayRateHist[[length(epsDecayRateHist) + 1]] = windowAvgDecayRate(inival = 0.1, endval = 0.01, decaytype = "exponential", maxIter = 30000, decayIter = 30000 * 0.6666, windowSize = 300L)
  epsDecayRateHist[[length(epsDecayRateHist) + 1]] = windowAvgDecayRate(inival = 0.5, endval = 0.01, decaytype = "exponential", maxIter = 30000, decayIter = 30000 * 0.6666, windowSize = 300L)
  epsDecayRateHist[[length(epsDecayRateHist) + 1]] = windowAvgDecayRate(inival = 1, endval = 0.01, decaytype = "exponential", maxIter = 30000, decayIter = 30000 * 0.6666, windowSize = 300L)
  epsDecayRateHist[[length(epsDecayRateHist) + 1]] = windowAvgDecayRate(inival = 0.5, endval = 0.01, decaytype = "linear", maxIter = 30000, decayIter = 30000 * 0.6666, windowSize = 300L)
  epsDecayRateHist[[length(epsDecayRateHist) + 1]] = windowAvgDecayRate(inival = 1, endval = 0.01, decaytype = "linear", maxIter = 30000, decayIter = 30000 * 0.6666, windowSize = 300L)
  
  
  pdf("figure/forestQlearningRewardVSeps.pdf", width = 13, height = 13 * 0.618)
  par(mar = c(4.1, 5, 0, 0), family = "serif", mfrow = c(6, 11))
  for(i in 1:length(resultRewardHist))
  {
    y = epsDecayRateHist[[i]]
    if(i == length(resultRewardHist) | i == 1) xlab = "Episode" else xlab = ""
    if(i == 1) ylab = expression(epsilon) else ylab = ""
    plot(y, type = "l", col = "red", xlab = "", ylab = "", cex.lab = 1.5, cex.axis = 1.5, ylim = c(0, 1), bty = "L", lwd = 2)
    title(ylab = ylab, cex.lab = 3)
    title(xlab = xlab, cex.lab = 1.55, line = 2.5)
    for(j in 1:length(resultRewardHist[[i]]))
    {
      y = resultRewardHist[[i]][[j]]
      if(j == 1 & i == 1) ylab = "Reward" else ylab = ""
      plot(y, type = "l", xlab = "", ylab = ylab, ylim = c(0, 2.8), bty = "L", cex.lab = 2, cex.axis = 1.5, col = "darkblue")
      if(gotOptPol[[i]][j]) legend("bottomleft", legend = bquote(symbol("\326")), bty = "n", text.col = "darkgreen", text.font = 2, cex = 2)
    }
  }
  dev.off()
  
  
  
  
}


















