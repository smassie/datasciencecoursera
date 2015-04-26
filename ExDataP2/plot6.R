if(!exists("NEI")){
  print("Loading Data...")
  NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
  SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
}


# Get motor vehcile emissions from Baltimore and Los Angeles

library("dplyr")

BaltLA <- filter(NEI, type == "ON-ROAD" & {fips == "06037" | fips == "24510"})

BaltLA <- mutate(BaltLA, City = "LA")
BaltLA[BaltLA$fips=="24510",]$City <- "Baltimore"
BaltLA$City <- as.factor(BaltLA$City)

BaltLA <- group_by(BaltLA, year, City)

BTLAplot <- summarize(BaltLA, Emissions = sum(Emissions))


# Create plot

png("ExDataP2/plot6.png")

library("ggplot2")

qplot(year, Emissions, data = BTLAplot, color = City, geom = c("point","line"),
      main = "PM 2.5 Emissions from Motor Vehicles, LA vs. Baltimore",
      xlab = "Year", ylab = "Tons PM 2.5")

dev.off()