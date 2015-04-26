if(!exists("NEI")){
  print("Loading Data...")
  NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
  SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
}

## Calculate total PM 2.5 emissions by year for Baltimore

library("dplyr")
Baltimore <- group_by(filter(NEI, fips == "24510"), year)
Baltimore_forPlot <- summarize(Baltimore, Emissions = sum(Emissions))


## Create barplot

png(filename = "ExDataP2/plot2.png")

barplot(Baltimore_forPlot$Emissions,  names.arg = Baltimore_forPlot$year, 
        main = "Baltimore Total PM 2.5 Emissions, 1999-2008", 
        xlab = "Year", ylab = "Tons PM 2.5",
        border=NA, col = "tan2")

dev.off()