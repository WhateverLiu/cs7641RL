



readIn = function(filePath, transformMapForImage = T)
{
  rst = readLines(filePath)
  rst = sapply(rst, function(x) gsub('"|[(]|[)]', '', x))
  rst = strsplit(rst, split = ",")
  thenames = unlist(lapply(rst, function(x) x[1]))
  rst = lapply(rst, function(x)
  {
    suppressWarnings(
      if(is.na(as.numeric(x[-1]))) x[-1] 
      else as.numeric(x[-1]))
  })
  names(rst) = thenames
  if("lakeMap" %in% thenames)
  {
    l = as.integer(round(sqrt(length(rst[["lakeMap"]]))))
    rst[["lakeMap"]] = t(matrix(as.integer(rst[["lakeMap"]]), nrow = l))
    if(transformMapForImage) rst[["lakeMap"]] = t(rst[["lakeMap"]]) [, nrow(rst[["lakeMap"]]):1]
  }
  
  
  if("optPol" %in% thenames)
  {
    rst[["optPol"]] = as.integer(rst[["optPol"]])
  }
  
  
  if("statesVisited" %in% thenames)
  {
    l = as.integer(round(sqrt(length(rst[["statesVisited"]]))))
    rst[["statesVisited"]] = t(matrix(as.integer(rst[["statesVisited"]]), nrow = l))
    if(transformMapForImage) rst[["statesVisited"]] = t(rst[["statesVisited"]]) [, nrow(rst[["statesVisited"]]):1]
  }
  
  
  
  
  rst
}


getLakeMap = function(size = 8, p = 0.8, seed = 8)
{
  cmd = paste0("python py/getLakeMaps.py tmpmap.txt  ", size, "  ", p, " ", seed)
  system(cmd)
  rst = readIn("tmpmap.txt")[[1]]
  unlink("tmpmap.txt", recursive = T); rst
}


makeScheduleParaString = function(schedule, para)
{
  # print(schedule)
  if(schedule == "stepwiseSchedule")
  {
    tmp = as.integer(round(length(para) - 1L / 2L))
    rst = paste0(paste0(para[1:tmp], collapse = ","), ",,", paste0(para[-(1:tmp)], collapse = ","))
    return(rst)
  }
  paste0(para, collapse = ",")
}


QlearningMakeParaString = function(paralist)
{
  paralist$epsSchedulePara = makeScheduleParaString(paralist$epsScheduleType, para = paralist$epsSchedulePara)
  paralist$alphaSchedulePara = makeScheduleParaString(paralist$alphaScheduleType, para = paralist$alphaSchedulePara)
  paste0(unlist(paralist), collapse = " ")
}


exponentialDecayInMaxIter = function(inival, endval, maxIter)
{
  1 - (endval / inival) ^ (1 / maxIter)
}


linearDecayInMaxIter = function(inival, endval, maxIter)
{
  (inival - endval) / maxIter
}


meanCumRewardHist = function(rd, windowSize = 100L)
{
  rst = numeric(length(rd) - windowSize + 1L)
  for(i in 1:windowSize)
    rst = rst + rd[1:(length(rd) - windowSize + 1L)]
  rst / windowSize
}


windowMean = function(rd, windowSize = 100L)
{
  tmp = length(rd) %% windowSize
  if(tmp != 0L) rd = c(numeric(windowSize - tmp), rd)
  rst = matrix(rd, nrow = windowSize)
  colMeans(rst)
}


windowAvgDecayRate = function(inival, endval, decaytype = "exponential", maxIter = 30000, decayIter = 30000 * 0.6666, windowSize = 300L)
{
  if(decaytype == "exponential")
  {
    decayIter = as.integer(round(decayIter))
    decayrate = (endval / inival) ^ (1 / decayIter)
    rst = c(inival * decayrate ^ (0:(decayIter - 1L)), rep(endval, maxIter - decayIter))
    return(windowMean(rst, windowSize))
  }
  
  
  if(decaytype == "linear")
  {
    decayIter = as.integer(round(decayIter))
    rst = c(seq(inival, endval, len = decayIter), rep(endval, maxIter - decayIter))
    return(windowMean(rst, windowSize))
  }
  
  
  rep(endval, maxIter / windowSize)
}



valueIter = function(saveFileName, pyExeFilePath, Nstate, discount = 0.9, stopElipson = 1e-5, r1 = 4, r2 = 2, p = 0.1, maxIter = 1e6L, wait = T)
{
  paralist = list(saveFileName = saveFileName, Nstate = Nstate, discount = discount, stopElipson = stopElipson, r1 = r1, r2 = r2, p = p, maxIter = maxIter)
  cmd = paste0(unlist(paralist), collapse = " ")
  cmd = paste0("python ", pyExeFilePath, " ", cmd)
  system(cmd, wait = wait)
  if(wait) readIn(saveFileName)
}


policyIter = function(saveFileName, pyExeFilePath, Nstate, discount = 0.9, r1 = 4, r2 = 2, p = 0.1, maxIter = 1e6L, wait = T)
{
  paralist = list(saveFileName = saveFileName, Nstate = Nstate, discount = discount, r1 = r1, r2 = r2, p = p, maxIter = maxIter)
  cmd = paste0(unlist(paralist), collapse = " ")
  cmd = paste0("python ", pyExeFilePath, " ", cmd)
  system(cmd, wait = wait)
  if(wait) readIn(saveFileName)
}




lakeValueIter = function(saveFileName, pyExeFilePath, envName, discount = 0.9, stopElipson = 1e-6, maxIter = 1e6L, wait = T)
{
  paralist = list(saveFileName = saveFileName, envName = envName, discount = discount, stopElipson = stopElipson, maxIter = maxIter)
  cmd = paste0(unlist(paralist), collapse = " ")
  cmd = paste0("python ", pyExeFilePath, " ", cmd)
  system(cmd, wait = wait)
  if(wait) readIn(saveFileName)
}


lakePolicyIter = function(saveFileName, pyExeFilePath, envName, discount = 0.9, stopElipson = 1e-6, maxIter = 1e6L, wait = T)
{
  paralist = list(saveFileName = saveFileName, envName = envName, discount = discount, stopElipson = stopElipson, maxIter = maxIter)
  cmd = paste0(unlist(paralist), collapse = " ")
  cmd = paste0("python ", pyExeFilePath, " ", cmd)
  system(cmd, wait = wait)
  if(wait) readIn(saveFileName)
}






