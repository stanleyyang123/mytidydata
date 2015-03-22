# retrieve test data, add column name, add "subject" and "activity" variable 
## load test data to testData
## load column feature names to ColLabel, assign testData column name as ColLabel[,2] 
testData <- read.table("./UCI HAR Dataset/test/X_test.txt")
ColLabel <- read.table("./UCI HAR Dataset/features.txt")
colnames(testData) <- ColLabel[,2]
## load test subject ID Label (testSubjLabel) 
## creat a new variable "subject" in testData, assign it with testSubjLabel
testSubjLabel <- read.table("./UCI HAR Dataset/test/subject_test.txt")
testData$subject <- testSubjLabel[,1]
## load test activity label to testActLabel 
## creat another new variable "activity" in testData, assign it with testActLabel
testActLabel <- read.table("./UCI HAR Dataset/test/y_test.txt")
testData$activity <- testActLabel[,1]

# retrieve train data, add column name, add "subject" and "activity" variable
## same procedure as that of test data
trainData <- read.table("./UCI HAR Dataset/train/X_train.txt")
colnames(trainData) <- ColLabel[,2]

trainSubjLabel <- read.table("./UCI HAR Dataset/train/subject_train.txt")
trainData$subject <- trainSubjLabel[,1]

trainActLabel <- read.table("./UCI HAR Dataset/train/y_train.txt")
trainData$activity <- trainActLabel[,1]

#combine testData and trainData to make a full dataset as DataAll
DataAll <- rbind(testData, trainData)

# extract mean and std measurements from DataAll to make selected dataset as DataExtract
DataExtract <- DataAll[, grep("mean\\(\\)|std\\(\\)", colnames(DataAll))]
# add "subject" and "activity" variable to DataExtract
DataExtract$subject <-DataAll$subject
DataExtract$activity <- DataAll$activity

# Now ready for reshaping DataExtract
##load reshape2 package, use melt() and dcast() function to reshape data
##use "activity" and "subject" as ID variable in melt() function
###melt all other numeric variables as mearured value (by default)
##cast melted data with "activity" and "suject" as ID variable 
###apply mean to each variable for each activity and each subject
library(reshape2)
DataMelt <- melt(DataExtract, id=c("activity", "subject")) 
DataCast <- dcast(DataMelt, activity + subject ~ variable, mean)

# replace activity code with activity label
activitytable<- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
activity<-DataCast$activity
for (i in 1:6) activity <- gsub(i, activitytable[i,2], activity)
DataCast$activity <- activity

#output tidydata
write.table(DataCast, "./mytidydata.txt", row.name=FALSE)
