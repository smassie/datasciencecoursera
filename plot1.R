##  Load data from 2007/2/1 - 2007/2/2 and convert dates to date formats

data.names <- read.table("household_power_consumption.txt", header = TRUE,
                         sep = ";", nrows = 1)

data <- read.table("household_power_consumption.txt", header = FALSE, na.strings = "?", 
                   skip = 66637, sep = ";", nrows = 69516-66637, 
                   col.names = names(data.names))

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
tmp       <- paste(data$Date, data$Time)
data$Time <- strptime(tmp, format = "%F %H:%M:%S") 
rm(tmp)



# Plot 1: Histogram of Global Active Power

png("plot1.png", width = 480, height = 480)

hist(data$Global_active_power, col = "red", 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.off()