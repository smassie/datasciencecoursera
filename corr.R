corr <- function(directory, threshold = 0){
  
  initial.dir <- getwd()
  setwd(directory)
  monitors <- dir()

  output <- vector(mode = "numeric", length = length(monitors))
  
  i <- 1
  while(i <= length(monitors)){
    data <- read.csv(monitors[i])       
    
    if(sum(complete.cases(data)) > threshold){
      output[i] <- cor(data$nitrate, data$sulfate, "complete.obs")
    }
    else{
      output[i] <- NA
    }
    
    i <- i + 1
  }
  
  bad <- is.na(output)
  output2 <- output[!bad]

  setwd(initial.dir)
  return(output2)
  
}