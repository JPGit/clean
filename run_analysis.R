
#
# Coursera - Clean Data - Course Project
#  Calculate averages of a dataset
# August 16, 2015
#


# Get data locally
# setwd("D:/DataScience/Clean/Project")

dataset_filename <- "dataset.zip"

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
             destfile=dataset_filename,method="auto", mode = "wb")
unzip (dataset_filename, exdir = "dataset")

# Examine data

#
# list of feature variable names - to correspond to source dataset variable names
#
features <- read.table("dataset\\UCI HAR Dataset\\features.txt",  header = FALSE, col.names = c("VariableId", "VariableName"))

#list of activity labels
activity_labels <- read.table("dataset\\UCI HAR Dataset\\activity_labels.txt", header = FALSE, col.names = c("ActivityId", "ActivityName"))[,2]


# identify the feature variable names which are mean and standard deviations
#  as being those variables whose name contains "mean()" or "stdev()"

# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
colClasses <- c(rep("NULL", 561))
mean_stdev_variables <- subset(features, grepl("mean\\(\\)", VariableName) | grepl("std\\(\\)", VariableName))[,1]
colClasses[mean_stdev_variables] = "numeric"


# - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
train <-  read.table("dataset\\UCI HAR Dataset\\train\\x_train.txt",
                     header = FALSE, col.names = features[,"VariableName"], 
                     colClasses = colClasses, check.names = FALSE)
y_train <-  read.table("dataset\\UCI HAR Dataset\\train\\y_train.txt", 
                       header = FALSE, col.names = c("ActivityId") )
subject_train <- read.table("dataset\\UCI HAR Dataset\\train\\subject_train.txt", 
                            header = FALSE, col.names = c("Subject") )

test <-  read.table("dataset\\UCI HAR Dataset\\test\\x_test.txt", 
                    header = FALSE, col.names = features[,"VariableName"], 
                    colClasses = colClasses, check.names = FALSE)
y_test <-  read.table("dataset\\UCI HAR Dataset\\test\\y_test.txt", 
                      header = FALSE, col.names = c("ActivityId") )
subject_test <- read.table("dataset\\UCI HAR Dataset\\test\\subject_test.txt",
                           header = FALSE, col.names = c("Subject") )

#
# 1. Merge the training and the test sets to create one data set.
# 3. Use descriptive activity names to name the activities in the data set
#

dataset <- cbind(ActivityName = activity_labels[y_train[,1]],
               subject_train, train)
dataset <- rbind(dataset, 
                 cbind(ActivityName = activity_labels[y_test[,1]], 
              subject_test, test), make.row.names = FALSE)




# 5. Create a tidy data set with the average of each variable
#    for each activity and each subject.
agg <- aggregate(dataset, 
                 by=list(ActivityName = dataset$ActivityName, 
                        Subject = dataset$Subject),
                 FUN=mean)[c(1,2,5:66)]

#
# Save the data set  as a txt file created with write.table() using row.name=FALSE
#
write.table(agg, file = "averages.txt", row.names = FALSE)


write.table(names(agg), file = "averages_names.txt", row.names = FALSE)
