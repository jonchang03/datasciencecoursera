# Summary of Work #
*The script, run_analysis.R performs the following 5 steps listed in the project guidelines. (If the dataset is not already in the user's working directory in a /data folder, the code at the top of run_Analysis.R can be uncommented to download the dataset and unzip it.*


#### Step 1. Merges the training and the test sets to create one data set. ####
The following variables contain the variables read in from the dataset files corresponding to their names:
* features
* activity_labels
* X_train
* y_train
* X_test
* y_test

Then, merge the 'x' data, subject ids (1-30), and activity ids (1-6) by row (rbind) into the following variables:
* XData
* subject
* activity

Finally, merge everything into one complete dataset by column (cbind). Our complete dataframe is called `dataset`.

#### Step 2. Extracts only the measurements on the mean and standard deviation for each measurement. ###
Use grep to search the features for "mean()" and "std". Use the returned indices to find the desired columns in the dataset.

### Step 3. Uses descriptive activity names to name the activities in the data set ####
Use the number (1-6) within the activity column as the index for activity_labels.
`dataset$Activity <- activity_labels[activity[,1],2]`

#### Step 4. Appropriately labels the data set with descriptive variable names. ####
Make the following replacements using gsub
* 't' -> time
* 'f' -> frequency
* 'Acc' -> Accelerometer
* 'Gyro' -> Gyroscope
* 'Mag' -> Magnitude

#### Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. ####
Use the aggregate function to create the 2nd, independent dataset, and order this dataset, now called `dataset2` by Activity, then by Subject. Write this to a text file called `"averages_by_variables.txt"`.
