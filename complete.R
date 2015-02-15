complete <- function(directory, id = 1:332){
  
  initial.dir <- getwd()
  setwd(directory)
  
  monitors <- dir()[id]
  output <- data.frame(id, nobs = 0)
  i <- 1
  
  while(i <= length(id)){
    data <- read.csv(monitors[i])
    good <- complete.cases(data)
    output$nobs[i] <- sum(good)  
    i = i+1
  }

  setwd(initial.dir)  
  
  return(output)

}