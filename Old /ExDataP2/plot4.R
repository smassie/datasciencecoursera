if(!exists("NEI")){
  print("Loading Data...")
  NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
  SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
}

library("dplyr")

## Filter data to only include sources with SCC related to coal combustion

# Return SCCs from sectors related to coal combustion:
coal <- SCC$SCC[grep("[Cc]omb(.*)[Cc]oal", SCC$EI.Sector)]

NEI_c <- filter(NEI, SCC %in% coal)



library("ggplot2")


# Prepare data

NEI_c <- group_by(NEI_c, year, type)
NEI_plot <- summarize(NEI_c, Emissions = sum(Emissions), Sources = n(),)

NEI_plot <- mutate(NEI_plot, Avg = Emissions/Sources)



# Create plot showing trends in total emissions, no. sources, and emissions per sources

png(filename = "ExDataP2/plot4.png")

par(mfrow = c(2,2))

with(subset(NEI_plot, type == "POINT"), plot(year, Emissions, type = "l", 
      col = "red", ylim = c(0,600000), xlab = ""))
with(subset(NEI_plot, type == "NONPOINT"), lines(year, Emissions, col = "blue"))
legend("topright", col=c("red","blue"), legend=c("Point","Nonpoint"), lty=1, bty="n")
title("Total U.S. Emissions")


with(subset(NEI_plot, type == "POINT"), plot(year, Sources, type = "l", 
      col = "red", ylim = c(1000,7600), xlab = ""))
with(subset(NEI_plot, type == "NONPOINT"), lines(year, Sources, col = "blue"))
legend("topright", col=c("red","blue"), legend=c("Point","Nonpoint"), lty=1, bty="n")
title("Total Sources")


with(subset(NEI_plot, type == "POINT"), plot(year, Avg, type = "l", col = "red",
      main = "Avg Emissions/Source, Point", xlab = ""))
with(subset(NEI_plot, type == "NONPOINT"), plot(year, Avg, type = "l", col = "blue", 
      main = "Avg Emissions/Source, Nonpoint", ylab = ""))

dev.off()





## OLD PLOTS ##


# Look at trend by places (only if time / interest): 

#NEI_f <- arrange(NEI_c, fips)
#NEI_f <- group_by(NEI_f, fips)
#NEI_p2 <- summarize(NEI_f, Emissions = sum(Emissions), Sources = n())


# Make some plots to understand trends

#boxplot(NEI_c[NEI_c$year == 1999,]$Emissions)
# Values heavily stacked towards zero.


#qplot(year, Emissions, Sources, data = NEI_plot, color = type, geom = c("point","smooth"),
#      main = "Coal-related PM 2.5 emissions, 1999-2008")

#qplot(year, Sources, data = NEI_plot, color = type, geom = c("point","smooth"),
#      main = "Number of Coal-related PM 2.5 sources, 1999-2008")

#qplot(year, Emissions/Sources, data = NEI_plot, color = type, geom = c("point","smooth"),
#      main = "Average emissions per source, 1999-2008")

# Plot together in a panel.  Way to do this in ggplot2?
