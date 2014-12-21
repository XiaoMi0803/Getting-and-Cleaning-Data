## You should create one R script called run_analysis.R that does the following. 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with 
##    the average of each variable for each activity and each subject

## Set working directory
setwd("/Users/Yanshu/Desktop/coursera/Getting and Cleaning Data/UCI HAR Dataset")

## Load data
activity_labels <- read.table("activity_labels.txt")
features <-read.table("features.txt")
subject_test <-read.table("./test/subject_test.txt")
X_test <-read.table("./test/X_test.txt")
y_test <-read.table("./test/Y_test.txt")
subject_train <-read.table("./train/subject_train.txt")
X_train <-read.table("./train/X_train.txt")
y_train <-read.table("./train/y_train.txt")

## 1.Merges the training and the test sets to create one data set.
subject <-rbind(subject_train,subject_test)
X <-rbind(X_train,X_test)
y <-rbind(y_train,y_test)
names(subject)<-"subject"
names(X)<-features$V2
names(y)<-"activity"
data<-cbind(subject,X,y)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
extracted_features<-features[grep("mean\\(\\)|std\\(\\)", features$V2), ]$V2
selectedNames<-c(as.character(extracted_features), "subject", "activity" )
Data<-subset(data,select=selectedNames)

## 3. Uses descriptive activity names to name the activities in the data set
Data$activity<-activity_labels[Data$activity,2]

## 4. Appropriately labels the data set with descriptive variable names.
names(Data) <-gsub("^t","time",names(Data))
names(Data) <-gsub("^f","frequency",names(Data))
names(Data) <-gsub("Acc","Accelerometer",names(Data))
names(Data) <-gsub("Gyro","Gyroscope",names(Data))
names(Data) <-gsub("Mag","Magnitude",names(Data))

## 5. From the data set in step 4, creates a second, independent tidy data set 
##    with the average of each variable for each activity and each subject
library(plyr)
TidyData <-aggregate(.~activity+subject,Data,mean)
TidyData<-arrange(TidyData,activity)
write.table(TidyData,file="tidydata.txt",row.name=FALSE)
