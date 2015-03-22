## My procedure to get tidy data
---------------------------------------
### Set working directory
#### Please put run_analysis.R and UCI HAR Dataset folder under the same folder as your working directory

### 1 Merges the training and the test sets to create one data set
##### load test data set, assign features to column name, add "subject" and "activity" as ID variable; Do the same thing to train dataset. 
#### use rbind() to combine testData and trainData to make a full data set


### 2 Extracts only the measurements on the mean and standard deviation for each measurement.
##### use grep() to extract measurements contain "mean()" and "std()"from the full data set from last step.
##### add "subject" and "activity" as ID variable to the extracted data set to be ready for data reshaping 

### 3 Reshape the data with the average of each variable for each activity and each subject
##### load reshape2 package, use melt() and dcast() function to reshape data
##### use "activity" and "subject" as ID variable 
##### apply mean to each variable for each activity and each subject

### 4 Uses descriptive activity names to name the activities in the data set
##### replace activity code with activity name, using gsub() function embeded in a for loop.  

### 5 Output tidy data
##### create mytidydata.txt file under working directory with write.table() using row.name=FALSE
