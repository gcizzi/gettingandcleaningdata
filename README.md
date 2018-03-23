Submission of final assignment for Coursera's Getting and Cleaning Data course.

### File list

Original README.txt - original README document from the UCI HAR data sets, describing the experimental set-up

run.analysis.R - a script that performs the required data analysis:
  - Merges the training and the test sets (from the UCI HAR data) to create one data set.
  - Extracts only the measurements on the mean and standard deviation for each measurement.
  - Uses descriptive activity names to name the activities in the data set
  - Appropriately labels the data set with descriptive variable names.
  - Finally creates a second, independent tidy data set ('averages.txt') with the average of each variable for each activity and each subject.
   
 averages.txt - a tidy data set, the output of run.analysis.R
 
 codebook.MD - a document that describes the variables used in averages.txt
