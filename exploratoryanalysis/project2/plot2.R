## Question 2

# Uncomment only if the following files haven't yet been read into the environment
# NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶") from 1999
# to 2008? Use the base plotting system to make a plot answering this question.

Baltimore_NEI <- NEI[NEI$fips == "24510", ]
total_emissions <- with(Baltimore_NEI, setNames(aggregate(Emissions, by = list(year), sum), c("year", "emissions")))

png(filename = "plot2.png")
barplot(total_emissions$emissions,
        names.arg=total_emissions$year,
        main = expression("Total Emissions from PM"[2.5]* " in Baltimore City, Maryland"),
        xlab = "Year",
        ylab = expression("PM"[2.5]*" Emissions"))
dev.off()