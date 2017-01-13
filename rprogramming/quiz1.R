df <- read.csv("hw1_data.csv")
# Question 11 - column names of the dataset
names(df)

# Question 12 - extract first two rows of data frame
head(df, 2)

# Question 13 - number of rows in data frame
nrow(df)

# Question 14 - extract last 2 rows of the data frame
tail(df, 2)

# Question 15 - value of Ozone in the 47th row
df[47, "Ozone"]

# Question 16 - count missing values in the Ozone column
sum(is.na(df[, "Ozone"]))

# Question 17 - mean of Ozone column excluding NA values
# Alternatives
# !is.na(df$Ozone)
# !is.na(df[, "Ozone"])
mean(df$Ozone[complete.cases(df$Ozone)])

# Question 18 - Extract the subset of rows of the data frame where Ozone values
# are above 31 and Temp values are above 90. What is the mean of
# Solar.R in this subset?
good <- complete.cases(df$Ozone, df$Temp, df$Solar.R)
mean(df$Solar.R[good & df$Ozone > 31 & df$Temp > 90])

# Question 19 - What is the mean of "Temp" when "Month" is equal to 6?
good <- complete.cases(df$Temp, df$Month)
mean(df$Temp[good & df$Mont == 6])

# Question 20 - What was the maximum ozone value in the month of May
# (i.e. Month is equal to 5)?
good <- complete.cases(df$Ozone, df$Month)
max(df$Ozone[good & df$Month == 5])
