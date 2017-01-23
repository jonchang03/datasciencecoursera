## Question 1
## Use this data to find the time that the datasharing repo was created. What time was it created?
## Run within terminal instead of RStudio
library(httr)
library(httpuv)
library(jsonlite)

# 1. Find OAuth settings for github:
oauth_endpoints("github")
myapp <- oauth_app("github",
                   key = "c3fe67259a69648e3b99",
                   secret = "a440081465b57d6be3fefa6b816ec1634aff27c7")

# 2. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 3. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
#print(content(req))
# 4. Extract content from request and convert list to json
json1 = content(req)
json2 = jsonlite::fromJSON(toJSON(json1))
print(json2[json2$full_name=="jtleek/datasharing",]$created_at)

## "2013-11-07T13:25:07Z"

## Question 2
# Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?
if(!file.exists("data")) {dir.create("data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "./data/AmericanCommunitySurvey.csv", method = "curl")
acs <- read.csv("./data/AmericanCommunitySurvey.csv")
head(acs)
library("sqldf")
## sqldf("select pwgtp1 from acs where AGEP < 50")

## Question 3
# Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)
query0 <- unique(acs$AGEP)
## query1 <- sqldf("select distinct AGEP from acs")

## Question 4
# How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:
# http://biostat.jhsph.edu/~jleek/contact.html
# (Hint: the nchar() function in R may be helpful)

con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(con)
close(con)

# use `<<-` to assign a value to an object in an environment
# different from the current environment.
ans <- c()
sapply(c(10, 20, 30, 100), function(x){
  ans <<- c(ans, nchar(htmlCode[x]))
})
print(ans)
## 45 31  7  25

## Question 5
# Read this data set into R and report the sum of the numbers in the fourth of the nine columns.
# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
# (Hint this is a fixed width file format)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(fileUrl, destfile = "./data/q5.for", method = "curl") # fortran data
wid <- c(1, 9, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3)
colNames <- c("space", "week", "space", 
              "sstnino12", "space", "sstanino12", "space", 
              "sstnino3", "space", "sstanino3", "space", 
              "sstnino34", "space", "sstanino34", "space",
              "sstnino4", "space", "sstanino4")
data <- read.fwf("./data/q5.for", widths=wid, header=FALSE, skip=4, col.names = colNames) # fixed width format file
print(sum(data$sstnino3))
## 32426.7
