



# linear, 1-->0.01 in 1e5 * 0.6666 episodes, total 1e5 episodes.
if(T)
{
  
  
  source("R/rfuns.R")
  forzenLakePyPath = "C:/Users/i56087/AppData/Local/Programs/Python/Python36/Lib/site-packages/gym/envs/toy_text/frozen_lake.py"
  py = readLines(forzenLakePyPath)
  tmp = which(grepl("# Reset rightMoveProb here:", py))
  py[tmp + 1] = "    rightMoveProb = 1.0/3"
  writeLines(py, forzenLakePyPath)
  envName = 'FrozenLake32x32-v0' # ; actualOptReward = 0.33746
  
  
  
  
  pytempPath = "result/lake32x32-P-0.333-1000000episodes-PH-0.9-linearEpsDecay-1-0.01-0.6.txt"
  Nepsoide = 100000L
  maxIterDecay = Nepsoide * 0.6666
  
  
  
  
  paralist = list()
  dir.create("result", showWarnings = F)
  paralist$rstFile = pytempPath
  paralist$envName = envName
  paralist$discount = 0.999
  
  
  iniEps = 1; endEps = 0.01
  paralist$epsScheduleType = "linearSchedule"
  decayEps = linearDecayInMaxIter(iniEps, endEps, maxIterDecay)
  paralist$epsSchedulePara = c(iniEps, decayEps, endEps)
  
  
  iniAlpha = 0.1; endAlpha = 0.1
  paralist$alphaScheduleType = "exponentialSchedule"
  decayAlpha = exponentialDecayInMaxIter(iniAlpha, endAlpha, maxIterDecay)
  paralist$alphaSchedulePara = c(iniAlpha, decayAlpha, endAlpha)
  
  
  paralist$Nepsoide = Nepsoide
  paraString = QlearningMakeParaString(paralist)
  exe = paste0("python py/lakeQlearning.py ", paraString)
  system(exe, wait = F)
}




# linear, 1-->0.01 in 1e5 * 0.5 episodes, total 1e5 episodes.
if(T)
{
  
  
  source("R/rfuns.R")
  forzenLakePyPath = "C:/Users/i56087/AppData/Local/Programs/Python/Python36/Lib/site-packages/gym/envs/toy_text/frozen_lake.py"
  py = readLines(forzenLakePyPath)
  tmp = which(grepl("# Reset rightMoveProb here:", py))
  py[tmp + 1] = "    rightMoveProb = 1.0/3"
  writeLines(py, forzenLakePyPath)
  envName = 'FrozenLake32x32-v0' # ; actualOptReward = 0.33746
  
  
  
  
  pytempPath = "result/lake32x32-P-0.333-1000000episodes-PH-0.9-linearEpsDecay-1-0.01-0.5.txt"
  Nepsoide = 100000L
  maxIterDecay = Nepsoide * 0.5
  
  
  
  
  paralist = list()
  dir.create("result", showWarnings = F)
  paralist$rstFile = pytempPath
  paralist$envName = envName
  paralist$discount = 0.999
  
  
  iniEps = 1; endEps = 0.01
  paralist$epsScheduleType = "linearSchedule"
  decayEps = linearDecayInMaxIter(iniEps, endEps, maxIterDecay)
  paralist$epsSchedulePara = c(iniEps, decayEps, endEps)
  
  
  iniAlpha = 0.1; endAlpha = 0.1
  paralist$alphaScheduleType = "exponentialSchedule"
  decayAlpha = exponentialDecayInMaxIter(iniAlpha, endAlpha, maxIterDecay)
  paralist$alphaSchedulePara = c(iniAlpha, decayAlpha, endAlpha)
  
  
  paralist$Nepsoide = Nepsoide
  paraString = QlearningMakeParaString(paralist)
  exe = paste0("python py/lakeQlearning.py ", paraString)
  system(exe, wait = F)
  
  
  if(F)
  {
    tmp = readIn("result/lake32x32-P-0.333-1000000episodes-PH-0.9-linearEpsDecay-1-0.01-0.5.txt")
    tmp$meanReward =  windowMean(tmp$rewardHist, windowSize = 100)
    actualOptReward = 0.99394
    plot(tmp$meanReward, type = "l", ylim = c(0, actualOptReward * 1.1), col = "darkblue")
    lines(x = c(-1, 1e10), y = c(actualOptReward, 1), col = "red")
    lines(x = c(-1, 1e10), y = c(actualOptReward * 0.9, actualOptReward * 0.9), col = "red", lty = 2)
  }
  
  
}




# linear, 0.2-->0.01 in 1e5 * 0.6 episodes, total 1e5 episodes.
if(T)
{
  
  
  source("R/rfuns.R")
  forzenLakePyPath = "C:/Users/i56087/AppData/Local/Programs/Python/Python36/Lib/site-packages/gym/envs/toy_text/frozen_lake.py"
  py = readLines(forzenLakePyPath)
  tmp = which(grepl("# Reset rightMoveProb here:", py))
  py[tmp + 1] = "    rightMoveProb = 1.0/3"
  writeLines(py, forzenLakePyPath)
  envName = 'FrozenLake32x32-v0' # ; actualOptReward = 0.33746
  
  
  
  
  pytempPath = "result/lake32x32-P-0.333-1000000episodes-PH-0.9-linearEpsDecay-0.2-0.01-0.6.txt"
  Nepsoide = 100000L
  maxIterDecay = Nepsoide * 0.6
  
  
  
  
  paralist = list()
  dir.create("result", showWarnings = F)
  paralist$rstFile = pytempPath
  paralist$envName = envName
  paralist$discount = 0.999
  
  
  iniEps = 0.2; endEps = 0.01
  paralist$epsScheduleType = "linearSchedule"
  decayEps = linearDecayInMaxIter(iniEps, endEps, maxIterDecay)
  paralist$epsSchedulePara = c(iniEps, decayEps, endEps)
  
  
  iniAlpha = 0.1; endAlpha = 0.1
  paralist$alphaScheduleType = "exponentialSchedule"
  decayAlpha = exponentialDecayInMaxIter(iniAlpha, endAlpha, maxIterDecay)
  paralist$alphaSchedulePara = c(iniAlpha, decayAlpha, endAlpha)
  
  
  paralist$Nepsoide = Nepsoide
  paraString = QlearningMakeParaString(paralist)
  exe = paste0("python py/lakeQlearning.py ", paraString)
  system(exe, wait = F)
  
  
  if(F)
  {
    # tmp = readIn(paralist$rstFile)
    tmp = readIn("result/lake32x32-P-0.333-1000000episodes-PH-0.9-linearEpsDecay-0.2-0.01-0.6.txt")
    tmp$meanReward =  windowMean(tmp$rewardHist, windowSize = 100)
    actualOptReward = 0.99394
    plot(tmp$meanReward, type = "l", ylim = c(0, actualOptReward * 1.1), col = "darkblue")
    lines(x = c(-1, 1e10), y = c(actualOptReward, 1), col = "red")
    lines(x = c(-1, 1e10), y = c(actualOptReward * 0.9, actualOptReward * 0.9), col = "red", lty = 2)
  }
  
  
}




# exponential, 0.2-->0.01 in 1e5 * 0.6 episodes, total 1e5 episodes.
if(T)
{
  
  
  source("R/rfuns.R")
  forzenLakePyPath = "C:/Users/i56087/AppData/Local/Programs/Python/Python36/Lib/site-packages/gym/envs/toy_text/frozen_lake.py"
  py = readLines(forzenLakePyPath)
  tmp = which(grepl("# Reset rightMoveProb here:", py))
  py[tmp + 1] = "    rightMoveProb = 1.0/3"
  writeLines(py, forzenLakePyPath)
  envName = 'FrozenLake32x32-v0' # ; actualOptReward = 0.33746
  
  
  
  
  pytempPath = "result/lake32x32-P-0.333-1000000episodes-PH-0.9-exponentialEpsDecay-0.2-0.01-0.6.txt"
  Nepsoide = 100000L
  maxIterDecay = Nepsoide * 0.6
  
  
  
  
  paralist = list()
  dir.create("result", showWarnings = F)
  paralist$rstFile = pytempPath
  paralist$envName = envName
  paralist$discount = 0.999
  
  
  iniEps = 0.2; endEps = 0.01
  paralist$epsScheduleType = "exponentialSchedule"
  decayEps = exponentialDecayInMaxIter(iniEps, endEps, maxIterDecay)
  paralist$epsSchedulePara = c(iniEps, decayEps, endEps)
  
  
  iniAlpha = 0.1; endAlpha = 0.1
  paralist$alphaScheduleType = "exponentialSchedule"
  decayAlpha = exponentialDecayInMaxIter(iniAlpha, endAlpha, maxIterDecay)
  paralist$alphaSchedulePara = c(iniAlpha, decayAlpha, endAlpha)
  
  
  paralist$Nepsoide = Nepsoide
  paraString = QlearningMakeParaString(paralist)
  exe = paste0("python py/lakeQlearning.py ", paraString)
  system(exe, wait = F)
  
  
  if(F)
  {
    
    pytempPath = "result/lake32x32-P-0.333-1000000episodes-PH-0.9-exponentialEpsDecay-0.2-0.01-0.6.txt"
    tmp = readIn(pytempPath)
    tmp$meanReward =  windowMean(tmp$rewardHist, windowSize = 100)
    actualOptReward = 0.99394
    plot(tmp$meanReward, type = "l", ylim = c(0, actualOptReward * 1.1), col = "darkblue")
    lines(x = c(-1, 1e10), y = c(actualOptReward, 1), col = "red")
    lines(x = c(-1, 1e10), y = c(actualOptReward * 0.9, actualOptReward * 0.9), col = "red", lty = 2)
  }
  
  
}




# exponential, 0.1-->0.01 in 1e5 * 0.6 episodes, total 1e5 episodes.
if(T)
{
  
  
  source("R/rfuns.R")
  forzenLakePyPath = "C:/Users/i56087/AppData/Local/Programs/Python/Python36/Lib/site-packages/gym/envs/toy_text/frozen_lake.py"
  py = readLines(forzenLakePyPath)
  tmp = which(grepl("# Reset rightMoveProb here:", py))
  py[tmp + 1] = "    rightMoveProb = 1.0/3"
  writeLines(py, forzenLakePyPath)
  envName = 'FrozenLake32x32-v0' # ; actualOptReward = 0.33746
  
  
  
  
  pytempPath = "result/lake32x32-P-0.333-1000000episodes-PH-0.9-exponentialEpsDecay-0.1-0.01-0.6.txt"
  Nepsoide = 100000L
  maxIterDecay = Nepsoide * 0.6
  
  
  
  
  paralist = list()
  dir.create("result", showWarnings = F)
  paralist$rstFile = pytempPath
  paralist$envName = envName
  paralist$discount = 0.999
  
  
  iniEps = 0.1; endEps = 0.01
  paralist$epsScheduleType = "exponentialSchedule"
  decayEps = exponentialDecayInMaxIter(iniEps, endEps, maxIterDecay)
  paralist$epsSchedulePara = c(iniEps, decayEps, endEps)
  
  
  iniAlpha = 0.1; endAlpha = 0.1
  paralist$alphaScheduleType = "exponentialSchedule"
  decayAlpha = exponentialDecayInMaxIter(iniAlpha, endAlpha, maxIterDecay)
  paralist$alphaSchedulePara = c(iniAlpha, decayAlpha, endAlpha)
  
  
  paralist$Nepsoide = Nepsoide
  paraString = QlearningMakeParaString(paralist)
  exe = paste0("python py/lakeQlearning.py ", paraString)
  system(exe, wait = F)
  
  
  if(F)
  {
    
    pytempPath = "result/lake32x32-P-0.333-1000000episodes-PH-0.9-exponentialEpsDecay-0.1-0.01-0.6.txt"
    tmp = readIn(pytempPath)
    tmp$meanReward =  windowMean(tmp$rewardHist, windowSize = 100)
    actualOptReward = 0.99394
    plot(tmp$meanReward, type = "l", ylim = c(0, actualOptReward * 1.1), col = "darkblue")
    lines(x = c(-1, 1e10), y = c(actualOptReward, 1), col = "red")
    lines(x = c(-1, 1e10), y = c(actualOptReward * 0.9, actualOptReward * 0.9), col = "red", lty = 2)
  }
  
  
}



# Linear, 1-->0.01 in 2e5 * 0.5 episodes, total 2e5 episodes.
if(T)
{
  
  
  source("R/rfuns.R")
  forzenLakePyPath = "C:/Users/i56087/AppData/Local/Programs/Python/Python36/Lib/site-packages/gym/envs/toy_text/frozen_lake.py"
  py = readLines(forzenLakePyPath)
  tmp = which(grepl("# Reset rightMoveProb here:", py))
  py[tmp + 1] = "    rightMoveProb = 1.0/3"
  writeLines(py, forzenLakePyPath)
  envName = 'FrozenLake32x32-v0' # ; actualOptReward = 0.33746
  
  
  
  
  pytempPath = "result/lake32x32-P-0.333-200000episodes-PH-0.9-linearEpsDecay-1-0.01-0.5.txt"
  Nepsoide = 200000L
  maxIterDecay = Nepsoide * 0.5
  
  
  
  
  paralist = list()
  dir.create("result", showWarnings = F)
  paralist$rstFile = pytempPath
  paralist$envName = envName
  paralist$discount = 0.999
  
  
  iniEps = 1; endEps = 0.01
  paralist$epsScheduleType = "linearSchedule"
  decayEps = linearDecayInMaxIter(iniEps, endEps, maxIterDecay)
  paralist$epsSchedulePara = c(iniEps, decayEps, endEps)
  
  
  iniAlpha = 0.1; endAlpha = 0.1
  paralist$alphaScheduleType = "exponentialSchedule"
  decayAlpha = exponentialDecayInMaxIter(iniAlpha, endAlpha, maxIterDecay)
  paralist$alphaSchedulePara = c(iniAlpha, decayAlpha, endAlpha)
  
  
  paralist$Nepsoide = Nepsoide
  paraString = QlearningMakeParaString(paralist)
  exe = paste0("python py/lakeQlearning.py ", paraString)
  system(exe, wait = F)
  
  
  if(F)
  {
    
    pytempPath = "result/lake32x32-P-0.333-200000episodes-PH-0.9-linearEpsDecay-1-0.01-0.5.txt"
    tmp = readIn(pytempPath)
    tmp$meanReward =  windowMean(tmp$rewardHist, windowSize = 100)
    actualOptReward = 0.99394
    plot(tmp$meanReward, type = "l", ylim = c(0, actualOptReward * 1.1), col = "darkblue")
    lines(x = c(-1, 1e10), y = c(actualOptReward, 1), col = "red")
    lines(x = c(-1, 1e10), y = c(actualOptReward * 0.9, actualOptReward * 0.9), col = "red", lty = 2)
  }
  
  
  
}




# Final tryout, 1-->0.01 in 2e5 * 0.5 episodes, total 2e5 episodes.
if(T)
{
  
  
  source("R/rfuns.R")
  forzenLakePyPath = "C:/Users/i56087/AppData/Local/Programs/Python/Python36/Lib/site-packages/gym/envs/toy_text/frozen_lake.py"
  py = readLines(forzenLakePyPath)
  tmp = which(grepl("# Reset rightMoveProb here:", py))
  py[tmp + 1] = "    rightMoveProb = 1.0/3"
  writeLines(py, forzenLakePyPath)
  envName = 'FrozenLake32x32-v0' # ; actualOptReward = 0.33746
  
  
  for(i in 1:13)
  {
    
    # iterName = i
    # pytempPath = "result/lake32x32-P-0.333-200000episodes-PH-0.9-linearEpsDecay-1-0.01-0.5.txt"
    pytempPath = paste0("result/lake32x32-P-0.333-200000episodes-PH-0.9-linearEpsDecay-1-0.01-0.6-iter-", i, ".txt")
    Nepsoide = 200000L
    maxIterDecay = as.integer(round(Nepsoide * 0.6))
    
    
    paralist = list()
    dir.create("result", showWarnings = F)
    paralist$rstFile = pytempPath
    paralist$envName = envName
    paralist$discount = 0.999
    
    
    iniEps = 1; endEps = 0.01
    paralist$epsScheduleType = "linearSchedule"
    decayEps = linearDecayInMaxIter(iniEps, endEps, maxIterDecay)
    paralist$epsSchedulePara = c(iniEps, decayEps, endEps)
    
    
    iniAlpha = 0.1; endAlpha = 0.1
    paralist$alphaScheduleType = "exponentialSchedule"
    decayAlpha = exponentialDecayInMaxIter(iniAlpha, endAlpha, maxIterDecay)
    paralist$alphaSchedulePara = c(iniAlpha, decayAlpha, endAlpha)
    
    
    paralist$Nepsoide = Nepsoide
    paraString = QlearningMakeParaString(paralist)
    exe = paste0("python py/lakeQlearning.py ", paraString)
    system(exe, wait = F)
    Sys.sleep(1)
  }
  
  
  
  pytempPath = paste0("result/lake32x32-P-0.333-200000episodes-PH-0.9-linearEpsDecay-1-0.01-0.6-iter-", 1:13, ".txt")
  for(i in 1:length(pytempPath))
  {
    tmp = readIn(pytempPath[i])
    tmp$meanReward =  windowMean(tmp$rewardHist, windowSize = 100)
    actualOptReward = 0.99394
    plot(tmp$meanReward, type = "l", ylim = c(0, actualOptReward * 1.1), col = "darkblue")
    lines(x = c(-1, 1e10), y = c(actualOptReward, 1), col = "red")
    lines(x = c(-1, 1e10), y = c(actualOptReward * 0.9, actualOptReward * 0.9), col = "red", lty = 2)
  }
  
  
  if(F)
  {
    
    pytempPath = "result/lake32x32-P-0.333-200000episodes-PH-0.9-linearEpsDecay-1-0.01-0.5.txt"
    tmp = readIn(pytempPath)
    tmp$meanReward =  windowMean(tmp$rewardHist, windowSize = 100)
    actualOptReward = 0.99394
    plot(tmp$meanReward, type = "l", ylim = c(0, actualOptReward * 1.1), col = "darkblue")
    lines(x = c(-1, 1e10), y = c(actualOptReward, 1), col = "red")
    lines(x = c(-1, 1e10), y = c(actualOptReward * 0.9, actualOptReward * 0.9), col = "red", lty = 2)
  }
  
  
  
}









# Plot the 16x16 and 32x32 grid worlds and reward histories
if(T)
{
  
  
  source("R/rfuns.R")
  lake16x16rst = readIn("result/lake16x16-P-0.333-100000episode-PH-0.9.txt")
  lake32x32rst = readIn("result/lake32x32-P-0.333-1000000episodes-PH-0.9-linearEpsDecay-1-0.01-0.6.txt")
  
  
  aw = c("<", "v", ">", "^")
  tmpf = function(x0x1y0y1, N = 4)
  {
    x0 = x0x1y0y1[1]; x1 = x0x1y0y1[2]; y0 = x0x1y0y1[3]; y1 = x0x1y0y1[4]
    dx = (x1 - x0) / N
    center = seq(x0, x1, len = N + 1)[-(N + 1)]
    center = center + dx / 2
    x = rep(center, N)
    
    
    dy = (y1 - y0) / N
    center = seq(y0, y1, len = N + 1)[-(N + 1)]
    center = center + dy / 2
    
    
    y = rep(rev(center), each = N)
    data.frame(x = x, y = y)
  }
  
  
  
  
  pdf("figure/lake16and32rst.pdf", width = 10, height = 10 * 0.25)
  par(mar = c(0.1, 0.1, 0.1, 0.1), family = "serif", mfrow = c(1, 4))
  image(lake16x16rst$lakeMap, col = c("black", "lightskyblue", "purple", "darkgreen"), bty = "n", xaxt = "n", yaxt = "n")
  # optPol16x16 = data.frame(tmpf(par("usr"), 16), s = aw[lake16x16rst$optPol + 1L])
  # text(x = optPol16x16$x, y = optPol16x16$y, labels = optPol16x16$s, cex = 1.5)
  
  
  par(mar = c(4.1, 5, 0, 1))
  meanReward = windowMean(lake16x16rst$rewardHist, windowSize = 100L)
  plot(meanReward, ylim = c(0, 0.98216 * 1.1), type = "l", lwd = 2, col = "darkblue", bty = "L", cex.lab = 2, cex.axis = 1.5, xlab = "Episode x 100", ylab = "")
  title(ylab = "Mean reward every 100 episodes", cex.lab = 1.2)
  lines(x = c(-1e10, 1e10), y = rep(0.98216, 2), lwd = 2, col = "red")
  lines(x = c(-1e10, 1e10), y = rep(0.98216, 2) * 0.9, lwd = 2, col = "red", lty = 2)
  legend("bottomleft", legend = "256 states", bty = "n", cex = 1.5)
  
  
  par(mar = c(0.1, 0.1, 0.1, 0.1))
  image(lake32x32rst$lakeMap, col = c("black", "lightskyblue", "purple", "darkgreen"), bty = "n", xaxt = "n", yaxt = "n")
  # optPol32x32 = data.frame(tmpf(par("usr"), 32), s = aw[lake32x32rst$optPol + 1L])
  # text(x = optPol32x32$x, y = optPol32x32$y, labels = optPol32x32$s, cex = 1.5)
  
  
  par(mar = c(4.1, 5, 0, 1))
  meanReward = windowMean(lake32x32rst$rewardHist, windowSize = 100L)
  plot(meanReward, ylim = c(0, 0.99394 * 1.1), type = "l", lwd = 2, col = "darkblue", bty = "L", cex.lab = 2, cex.axis = 1.5, xlab = "Episode x 100", ylab = "")
  title(ylab = "Mean reward every 100 episodes", cex.lab = 1.2)
  lines(x = c(-1e10, 1e10), y = rep(0.99394, 2), lwd = 2, col = "red")
  lines(x = c(-1e10, 1e10), y = rep(0.99394, 2) * 0.9, lwd = 2, col = "red", lty = 2)
  legend("bottomleft", legend = "1024 states", bty = "n", cex = 1.5)
  dev.off()
  
  
  
  
}





















