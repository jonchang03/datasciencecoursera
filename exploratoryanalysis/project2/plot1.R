## Question 1

# This first line will likely take a few seconds. Be patient!
# read each of the two files using readRDS()
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission from
# all sources for each of the years 1999, 2002, 2005, and 2008.

total_emissions <- with(NEI, setNames(aggregate(Emissions, by = list(year), sum), c("year", "emissions")))

png(filename = "plot1.png")
par(mar=c(5,7,4,2))
barplot(total_emissions$emissions/10^6,
        names.arg=total_emissions$year,
        main = expression("Total Emissions from PM"[2.5]*" in the US"),
        xlab = "Year",
        ylab = expression("PM"[2.5]*" Emissions (10"^6*" tons)"))
dev.off()