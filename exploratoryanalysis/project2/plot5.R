## Question 5

# Uncomment only if the following files haven't yet been read into the environment
# NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

Baltimore_vehicles_NEI <- NEI[NEI$fips == "24510" & NEI$type == 'ON-ROAD', ]

library(ggplot2)

plot5 <- ggplot(Baltimore_vehicles_NEI, aes(x = factor(year), y = Emissions, fill = year)) +
    geom_bar(stat = "identity") +
    guides(fill=FALSE) +
    xlab("Year") + ylab(expression("PM"[2.5]*" Emissions (tons)")) +
    ggtitle("Total Emissions from Motor Vehicle Sources in Baltimore City, Maryland")

png(filename = "plot5.png")
print(plot5)
dev.off()