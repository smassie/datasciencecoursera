if(!exists("NEI")){
  print("Loading Data...")
  NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
  SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
}

## Calculate total PM 2.5 emissions by year

library("dplyr")
NEI_byYear <- group_by(NEI, year)
NEI_forPlot <- summarize(NEI_byYear, Emissions = sum(Emissions)/1e+6)


## Create barplot

png(filename = "ExDataP2/plot1.png")

barplot(NEI_forPlot$Emissions,  names.arg = NEI_forPlot$year, 
        main = "Total US PM 2.5 Emissions, 1999-2008", 
        xlab = "Year", ylab = "Million tons PM 2.5",
        border=NA, col = "tan")

dev.off()