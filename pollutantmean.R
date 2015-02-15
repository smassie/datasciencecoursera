## Part 1: Write function that takes the mean value of a pollutant
##  from a given directory

pollutantmean <- function(directory, pollutant, id=1:332){
  
  initial.dir <- getwd()    # Initialize directory
  setwd(directory)
  monitors <- dir()
  dcount <- 0               # Initialize values
  dsum <- 0

  for(i in id){
    data <- read.csv(monitors[i]) 
    bad <- is.na(data[[pollutant]])
    
    dcount <- dcount + length(data[[pollutant]][!bad])
    dsum <- dsum + sum(data[[pollutant]][!bad])
  }  
  
  setwd(initial.dir)
  return(dsum/dcount)
}