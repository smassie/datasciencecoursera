print("Type 'GO()' to begin.")
GO <- function(){

  
## Check if data exists.  If not, download, unzip, and save to the Data directory. ##

if(!file.exists("./data")){
  dir.create("./data")
}

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileDir <- "./data/GetDataCourseProject.zip"

if(!file.exists(fileDir)){
  print("Data does not exist.  Downloading data...")
  
  download.file(fileURL, destfile = fileDir)
  downloadTime <- date()
  unzip(fileDir, overwrite = TRUE, exdir = "./data")
  
  print("Downloaded.")
}


## Extract raw data and apply variable names ##

print("Loading data into R...")


#   Test dataset
print("Loading 'test' data set")

test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "")
names(test) <- read.table("./data/UCI HAR Dataset/features.txt")[,2]

test_y <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = "")
names(test_y) <- "activity_ID"

test <- cbind(test_y, test)


#   Train dataset
print("Loading 'train' data set")

train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "")
names(train) <- read.table("./data/UCI HAR Dataset/features.txt")[,2]

train_y <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = "")
names(train_y) <- "activity_ID"

train <- cbind(train_y, train)


## Merge "train" and "test" data frames ##

print("Merging datasets...")

alldata <- rbind(test, train)


## Extract only measurements on mean and standard deviation ##

print("Cleaning data...")

means <- grep("mean", names(alldata))
stds <- grep("std", names(alldata))

data_ms <- alldata[,c(1,means, stds)]


## Use descriptive activity names to name activities in the data set ##

activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
names(activityLabels) <- c("activity_ID", "activity_name")

data_w_activities <- merge(activityLabels, data_ms, by = "activity_ID")


## Create new data set with the average of each variable, grouped by activity ##

print("Calculating output matrix...")

#   Create empty data frame to hold the means (by activity) of each variable
n_rows <- length(levels(data_w_activities$activity_name))
n_cols <- length(data_w_activities)-2
output <- data.frame(matrix(nrow = n_rows, ncol = n_cols),
                     row.names = levels(data_w_activities$activity_name) )  

#   Run "tapply" to get mean by activity along all columns, and store in data frame
for(i in 1:n_cols){
  output[,i] <- tapply(data_w_activities[,i+2], data_w_activities$activity_name, mean)  
}

#   Rename columns to match dataset
names(output) <- names(data_w_activities)[3:(n_cols+2)]


##  Final step: export to a text file and save to GitHub repo ##
output <- cbind(activity_name = row.names(output), output)
write.table(output, file = "GetData_W3.txt", row.name = FALSE)

print("Data saved to 'GetData_W3.txt' in working directory.")


}



## Double check output for correctness
## Write README file