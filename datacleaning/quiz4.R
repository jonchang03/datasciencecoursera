## Question 1
# The American Community Survey distributes downloadable data about United States communities.
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv and load the data into R.
# The code book, describing the variable names is here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# Apply strsplit() to split all the names of the data frame on the characters "wgtp".
# What is the value of the 123 element of the resulting list?
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/AmericanCommunitySurvey.csv", method = "curl")
acs <- read.csv("./data/AmericanCommunitySurvey.csv")
colnames <- names(acs)
print(strsplit(colnames, "wgtp")[[123]])
## ""   "15"

## Question 2
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?
# Original data sources:
# http://data.worldbank.org/data-catalog/GDP-ranking-table
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile = "./data/GDP.csv", method = "curl")
library(data.table)
gdp = fread("./data/GDP.csv", skip=4, nrows = 190, select = c(1, 2, 4, 5), col.names=c("CountryCode", "GDPRank", "CountryName", "GDP"))
print(mean(as.numeric(gsub(",", "", gdp$GDP))))
## 377652.4

## Question 3
# In the data set from Question 2 what is a regular expression that would allow you to count the number of
# countries whose name begins with "United"? Assume that the variable with the country names in it is named countryNames.
# How many countries begin with United?
countryNames <- gdp$CountryName
print(length(grep("^United",countryNames)))
## grep("^United",countryNames)
## 3

## Question 4
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Load the educational data from this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available,
# how many end in June?
library(dtplyr)
url1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url1, destfile = "./data/GDP.csv", method = "curl")
download.file(url2, destfile = "./data/FEDSTATS_Country.csv", method = "curl")
gdp = fread("./data/GDP.csv", skip=4, nrows = 190, select = c(1, 2, 4, 5), col.names=c("CountryCode", "GDPRank", "CountryName", "GDP"))
feds <- fread("./data/FEDSTATS_Country.csv")
mergedData <- merge(gdp, feds, by="CountryCode")
print(sum(grepl("Fiscal year end: June", mergedData$`Special Notes`)))
## 13



## Question 5
# You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for
# publicly traded companies on the NASDAQ and NYSE. Use the following code to download data on Amazon's stock price 
# and get the times the data was sampled.
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
# How many values were collected in 2012? 
print(length(grep("^2012", sampleTimes)))
## 250
# How many values were collected on Mondays in 2012?
print(sum(weekdays(sampleTimes[grep("^2012", sampleTimes)]) == "Monday"))
## 47
