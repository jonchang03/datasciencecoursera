## Question 1
# Create a logical vector that identifies the households on greater than 10 acres who sold more than 
# $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. 
# Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE.
# which(agricultureLogical)
# What are the first 3 values that result?

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/AmericanCommunitySurvey.csv", method = "curl")
acs <- read.csv("./data/AmericanCommunitySurvey.csv")
agriculturalLogical <- (acs$ACR==3) & (acs$AGS==6)
print(head(which(agriculturalLogical), 3))
# 125 238 262

## Question 2
# Using the jpeg package read in the following picture of your instructor into R
# https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg
# Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? 

library(jpeg)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileUrl, destfile = "./data/jeff.jpg", method = "curl")
print(quantile(readJPEG("./data/jeff.jpg", native=TRUE), probs= c(30,80)/100))
# -15259150 -10575416

## Question 3
# Match the data based on the country shortcode. How many of the IDs match? 
# Sort the data frame in descending order by GDP rank (so United States is last). 
# What is the 13th country in the resulting data frame?

library(dtplyr)
url1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url1, destfile = "./data/GDP.csv", method = "curl")
download.file(url2, destfile = "./data/FEDSTATS_Country.csv", method = "curl")
gdp = fread("./data/GDP.csv", skip=4, nrows = 190, select = c(1, 2, 4, 5), col.names=c("CountryCode", "GDPRank", "CountryName", "GDP"))
feds <- fread("./data/FEDSTATS_Country.csv")
mergedData <- merge(gdp, feds, by="CountryCode")
print(sum(unique(gdp$CountryCode) %in% unique(feds$CountryCode)))
#print(nrow(mergedData))
# 189
library(dplyr)
sorted <- arrange(mergedData, desc(GDPRank))
print(sorted[13, "CountryName"])
# St. Kitts and Nevis

## Question 4
# What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
# tapply(X, INDEX, FUN = NULL, ..., simplify = TRUE)

print(tapply(mergedData$GDPRank, mergedData$`Income Group`, mean))

# 32.9667 and 91.91304
# High income: nonOECD    High income: OECD           Low income  Lower middle income  Upper middle income 
# 91.91304             32.96667            133.72973            107.70370             92.13333 

## Question 5
# Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries
# are Lower middle income but among the 38 nations with highest GDP?

library(Hmisc)
c1 <- cut2(mergedData$GDPRank, g=5)
table(c1, mergedData$`Income Group`)

# 5
# c1          High income: nonOECD High income: OECD Low income Lower middle income Upper middle income
# [  1, 39)                    4                18          0                   5                  11
# [ 39, 77)                    5                10          1                  13                   9
# [ 77,115)                    8                 1          9                  12                   8
# [115,154)                    5                 1         16                   8                   8
# [154,190]                    1                 0         11                  16                   9
