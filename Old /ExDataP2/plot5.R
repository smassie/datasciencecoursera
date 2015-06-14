if(!exists("NEI")){
  print("Loading Data...")
  NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
  SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
}


# Get data for motor-related emissions

library("dplyr")

Balt_motor <- group_by(filter(NEI, fips=="24510" & type=="ON-ROAD"), year)
motor_plot <- summarize(Balt_motor, Emissions = sum(Emissions))

#  Look at spread of point values over time
#motor_log <- mutate(Balt_motor, LogEmissions = log(Emissions))
#loft(motor_log$year, motor_log$LogEmissions, pch = 19, alpha = 0.2)



# Create plot

library("ggplot2")

png("ExDataP2/plot5.png")

qplot(year, Emissions, data = motor_plot, geom = c("point","line"), 
      main = "PM 2.5 emissions from motor sources, Baltimore", xlab = "Year",
      ylab = "Tons PM 2.5 emitted")

dev.off()


