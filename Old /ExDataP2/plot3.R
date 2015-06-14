if(!exists("NEI")){
  print("Loading Data...")
  NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
  SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
}

library("dplyr")
Baltimore <- filter(NEI, fips == "24510")

# Summarize Batimore emissions by type, year

Balt_grp <- group_by(Baltimore, type, year)
Balt_plot <- summarize(Balt_grp, Emissions = sum(Emissions))

Balt_plot$type <- as.factor(Balt_plot$type)
#Balt_plot$year <- as.character(Balt_plot$year)


# Plot emissions by type

png(filename = "ExDataP2/plot3.png")

library(ggplot2)

qplot(year, Emissions, data = Balt_plot, color = type,
      geom=c("point","line"), xlab = "Year", ylab = "Tons PM 2.5", 
      main = "Baltimore PM 2.5 Emissions by Type, 1999-2008")

dev.off()

# Other changes to experiment with: 
  # Change theme
  # Replace continuous year label with factor year label, without destroying line plot
  # Change legend title
  # Make main title bold


