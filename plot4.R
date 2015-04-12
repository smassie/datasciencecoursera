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



# Plot 4: Combined plot

png("plot4.png", width = 480, height = 480)

par(mfcol = c(2,2), mar = c(4,4,2,2))

#1
with(data, plot(Time, Global_active_power, type = "n", xlab = "",
                ylab = "Global Active Power"))
with(data, lines(Time, Global_active_power))

#2
with(data, plot(Time, Sub_metering_1, type = "n", xlab = "",
                ylab = "Energy sub metering"))
with(data,{     
  lines(Time, Sub_metering_1);
  lines(Time, Sub_metering_2, col = "red");
  lines(Time, Sub_metering_3, col = "blue")
})

legend("topright", col = c("black","red","blue"), pch = "______", bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#3
with(data, {
  plot(Time, Voltage, xlab = "datetime", type = "n");
  lines(Time,Voltage)
})

#4
with(data, {
  plot(Time, Global_reactive_power, xlab = "datetime", type = "n");
  lines(Time,Global_reactive_power)
})

dev.off()