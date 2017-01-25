## run_analysis.R

# ## Download and unzip dataset if needed
# if(!file.exists("data")) {dir.create("data")}
# fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download.file(fileUrl, destfile = "./data/Dataset.zip", method = "curl")
# unzip(zipfile="./data/Dataset.zip",exdir="./data")
#
## 1. Merges the training and the test sets to create one data set.

## Read in data
# features and activity labels
features <- read.table("./data/UCI HAR Dataset/features.txt")
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
# training sets
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
# test sets
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")

## Merge the data
# merge 'x' data by row
XData <- rbind(X_train, X_test)
# merge 'subject' data by row
subject <- rbind(subject_train, subject_test)
# merge 'y' (activity) data by row
activity <- rbind(y_train, y_test)
# assign column names
colnames(XData) <- features[, 2] # use the list of features as column names for XData
colnames(subject) <- "Subject"
colnames(activity) <- "Activity"
# merge everything into one dataset by column
dataset <- cbind(XData, subject, activity)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# grep the features (column names) for "mean()" or "std()"
mean_and_std <- grep("(mean|std)\\(\\)", features[,2])
# use the returned indices to find the desired columns, remembering to keep subject and activity columns
dataset <- cbind(dataset[,mean_and_std], subject, activity)

## 3. Uses descriptive activity names to name the activities in the data set
# use the activity_labels read earlier which map activity names to numbers
# use number (1-6) within the activity column as index for activity_labels
dataset$Activity <- activity_labels[activity[,1],2]

## 4. Appropriately labels the data set with descriptive variable names.
# use README.txt and features_info.txt for ideas for descriptive variables
# 't' -> time
# 'f' -> frequency
# 'Acc' -> Accelerometer
# 'Gyro' -> Gyroscope
# 'Mag' -> Magnitude
names(dataset) <- gsub("^t", "time", names(dataset))
names(dataset) <- gsub("^f", "frequency", names(dataset))
names(dataset) <- gsub("Acc", "Accelerometer", names(dataset))
names(dataset) <- gsub("Gyro", "Gyroscope", names(dataset))
names(dataset) <- gsub("Mag", "Magnitude", names(dataset))


## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# use the aggregate function
# http://stackoverflow.com/questions/14087610/what-is-the-meaning-of-in-aggregate-function
library(dtplyr)
# '.' means all other variables which are otherwise not present in the formula
dataset2 <- aggregate(. ~ Subject + Activity,  dataset, mean)
# should be 180 rows because 30 subjects, and 6 activities each
# order dataset2 by Activity, then Subject
dataset2 <- dataset2[order(dataset2$Activity, dataset2$Subject), ]
# write to text file
write.table(dataset2, "averages_by_variable.txt", row.names=FALSE)
