corr <- function(directory, threshold = 0){
  
  cp <- complete("specdata")
  cp2 <- cp$id[cp$nobs > threshold]
  
  cp.mon <- dir("specdata")[cp2]
  
  output <- vector(mode = "numeric", length = length(cp.mon))
  
  
  initial.dir <- getwd()
  setwd(directory)
  
  i <- 1
  while(i <= length(cp.mon)){
    data <- read.csv(cp.mon[i])       
    output[i] <- cor(data$nitrate, data$sulfate, "complete.obs")
    i <- i + 1
  }
  
  setwd(initial.dir)
  return(output)
  
}