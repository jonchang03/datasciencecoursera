## Question 3

# Uncomment only if the following files haven't yet been read into the environment
# NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999–2008
# for Baltimore City? Which have seen increases in emissions from 1999–2008?
# Use the ggplot2 plotting system to make a plot answer this question.

Baltimore_NEI <- NEI[NEI$fips == "24510", ]

library(ggplot2)

plot3 <- ggplot(Baltimore_NEI, aes(x = factor(year), y = (Emissions), fill=type)) +
    geom_bar(stat="identity") +
    facet_grid(. ~ type) +
    guides(fill = FALSE) +
    xlab('Year') +
    ylab(expression("PM"[2.5]*" Emissions (tons)")) +
    labs(title = expression("PM"[2.5]*" Emissions by Source Type in Baltimore City, Maryland"))

png(filename = "plot3.png")
print(plot3)
dev.off()