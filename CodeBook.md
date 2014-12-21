This is a code book that describes the variables, the data, and any transformations or work that I performed to clean up the data.

## run_analysis.R performs the following steps as described in the project requirements
* Read in the data. The data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
 There are 8 text files in total. activity_labels.txt, features.txt, subject_test.txt, X_test.txt, y_test.txt, subject_train.txt, X_train.txt, and y_train.txt. 
* Used rbind(), cbind() to merges the data sets
* Used grep() function to get the feature names with mean() and std(), and use subset() function to further extract the measurements on the mean and standard deviation
* Assigned the columns with the activity label names in activity.txt to name the activities in the data set.
* From the features_info.txt, 'f' indicate 'frequency' domain signals, 't' denotes 'time', 'Acc' denotes 'accelaerometer', 'Gyro' denotes 'gyroscope', and 'Mag' denotes 'magnitude'. 
  I used gsub() function to replace 'f','t','Acc','Gyro', and 'Mag' with 'frequency','time','Accelaerometer', 'Gyroscope', and 'Magnitude'.
* I used aggregate() function in {plyr} to get a data set with the average of each variable for each activity and each subject, and then use write.table() function to save a text file called "tidydata.txt".