## Queston 4

# Uncomment only if the following files haven't yet been read into the environment
# NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# find coal combustion-related sources from SCC and then map to NEI
coal <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
combustion <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal_combustion_SCC <- SCC[coal & combustion, ]$SCC
coal_combustion_NEI <- NEI[NEI$SCC %in% coal_combustion_SCC, ]
coal_emissions <- with(coal_combustion_NEI, setNames(aggregate(Emissions, by = list(year), sum), c("year", "emissions")))

library(ggplot2)

plot4 <- ggplot(coal_emissions, aes(x = year, y = emissions/1000)) +
    geom_line() +
    geom_point(size = 5) +
    xlab("Year") + ylab(expression("PM"[2.5]*" Emissions (10"^3*" tons)")) +
    ggtitle("Total Emissions from Coal Combusion Sources in the US")

png(filename = "plot4.png")
print(plot4)
dev.off()