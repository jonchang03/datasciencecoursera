## Problem 1
## How many properties are worth $1,000,000 or more?

# if(!file.exists("data")) {dir.create("data")}
# fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
# download.file(fileUrl, destfile = "./data/idaho_housing.csv", method = "curl")
# housingData <- read.csv("./data/idaho_housing.csv")
# head(housingData)
# print(sum(!is.na(housingData$VAL) & housingData$VAL==24))
# 
# ## Problem 2
# ## Use the data you loaded from Question 1. Consider the variable FES in the code book.
# ## Which of the "tidy data" principles does this variable violate?
# # Ans. Tidy data has one variable per column. (family type and empployee status shouldn't be in same column)
# 
# ## Problem 3
# # http://stackoverflow.com/questions/35179151/cannot-load-r-xlsx-package-on-mac-os-10-11
# # http://stackoverflow.com/questions/30738974/rjava-load-error-in-rstudio-r-after-upgrading-to-osx-yosemite
# library("xlsx")
# fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
# download.file(fileUrl, destfile = "./data/gove_NGAP.xlsx", method = "curl")
# colIndex <- 7:15
# rowIndex <- 18:23
# dat <- read.xlsx("./data/gove_NGAP.xlsx", sheetIndex=1,
#                  colIndex=colIndex, rowIndex=rowIndex)
# print(sum(dat$Zip*dat$Ext,na.rm=T))
# 
# ## Problem 4
# # How many restaurants have zipcode 21231?
# library(XML)
# fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
# doc <- xmlTreeParse(fileUrl, useInternal=TRUE)
# rootNode <- xmlRoot(doc)
# xmlName(rootNode)
# print(sum(xpathSApply(rootNode, "//zipcode", xmlValue) == 21231))

## Problem 5
library(data.table)
#fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
#download.file(fileUrl, destfile = "./data/idaho_housing.csv", method = "curl")
DT <- fread("./data/idaho_housing.csv")
print(system.time(mean(DT$pwgtp15,by=DT$SEX)))
print(system.time(mean(DT[DT$SEX==1,]$pwgtp15)) + system.time(mean(DT[DT$SEX==2,]$pwgtp15)))
print(system.time(tapply(DT$pwgtp15,DT$SEX,mean)))
print(system.time(DT[,mean(pwgtp15),by=SEX]))
print(system.time(sapply(split(DT$pwgtp15,DT$SEX),mean)))
print(system.time(rowMeans(DT)[DT$SEX==1]) + system.time(rowMeans(DT)[DT$SEX==2]))