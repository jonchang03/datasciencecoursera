## Queston 6

# Uncomment only if the following files haven't yet been read into the environment
#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in
# Los Angeles County, California (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). Which city has seen greater changes over time in motor vehicle emissions?

# aggregate totals for Baltimore and LA
Baltimore <- subset(NEI, fips == "24510" & type == "ON-ROAD")
Baltimore_emissions <- cbind(with(Baltimore, aggregate(Emissions, by = list(year), sum)), city = "Baltimore")
LA <- subset(NEI, fips == "06037" & type == "ON-ROAD")
LA_emissions <- cbind(with(LA, aggregate(Emissions, by = list(year), sum)), city = "LA")
total_emissions <- rbind.data.frame(Baltimore_emissions, LA_emissions)
colnames(total_emissions) <- c("year", "emissions", "city")

library(ggplot2)

plot6 <- ggplot(data = total_emissions, aes(x=year, y=emissions, fill=year)) +
    geom_bar(stat="identity") +
    facet_grid(. ~ city) +
    xlab("Year") + ylab(expression("PM"[2.5]*" Emissions (tons)")) +
    ggtitle("Total Vehicle Emissions in Baltimore, MD vs. Los Angeles, CA") +
    theme(legend.position='none') +
    scale_x_continuous(breaks=c(1999,2002,2005,2008)) +
    geom_text(aes(label=round(emissions), size = 2, hjust = 0.5, vjust = -1))

png(filename = "plot6.png")
print(plot6)
dev.off()