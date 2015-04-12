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


# Plot 2: Global Active Power by Date & Time

png("plot2.png", width = 480, height = 480)

with(data, plot(Time, Global_active_power, type = "n", xlab = "",
                ylab = "Global Active Power (kilowatts)"))
with(data, lines(Time, Global_active_power))

dev.off()