setwd("~/RStudio/Coursera/Getting and Cleaning Data")
library(dplyr)

#Download data files and read all relevant tables:

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,destfile="./uci.zip")
unzip("uci.zip")
setwd("./UCI HAR Dataset")

activity_labels <- read.table("./activity_labels.txt",
                              col.names=c("Activity_Code","Activity"))
features <- read.table("./features.txt")

subject_test <- read.table("./test/subject_test.txt")
X_test <- read.table("./test/X_test.txt")
Y_test <- read.table("./test/Y_test.txt")

body_acc_x_test <- read.table("./test/Inertial Signals/body_acc_x_test.txt")

subject_train <- read.table("./train/subject_train.txt")
X_train <- read.table("./train/X_train.txt")
Y_train <- read.table("./train/Y_train.txt")

#Merge the training and the test data sets into one set:

test <- cbind(subject_test,Y_test,X_test)       #combine test subject, activity, and data
train <- cbind(subject_train,Y_train,X_train)   #combine train subject, activity, and data
data <- rbind(test,train)                       #merge test and train data sets

colnames(data) <- c("Subject","Activity_Code",as.character(features[,2]))
    #add feature names to each data column

#Extract only the measurements on the mean and standard deviation for each measurement:

means <- grep("mean()",colnames(data))  #find the mean columns
stds <- grep("std()",colnames(data))    #find the standard deviation columns
combined <- means %>% c(stds) %>% sort()     #combine and sort the desired column numbers

#Use descriptive activity names to name the activites in the set:

mean_std <- data[,c(1,2,combined)]         #select desired columns (mean and std)
detailed <- merge(mean_std,activity_labels)   #add column of desciptive activity names

#Appropriately label the data set with descriptive variable names:

colnames(detailed) <- gsub("^t","Time:",colnames(detailed))
colnames(detailed) <- gsub("^f","Frequency:",colnames(detailed))
colnames(detailed) <- gsub("Acc","Acceleration",colnames(detailed))
colnames(detailed) <- gsub("Gyro","Gyroscope",colnames(detailed))
colnames(detailed) <- gsub("Mag","Magnitude",colnames(detailed))

#Create a second, independent tidy data set with the average of each variable
# for each activity and each subject:

averages <- detailed %>% group_by(Activity,Subject) %>% summarise_all(mean)