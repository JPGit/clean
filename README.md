---
title: "README.md"
output: html_document
---

Process:

Download zipped data file, and extract data to local working directory

Read metadata files: features.txt and activity_labels.txt to provide variable and activity names

From the features variables, limit operations to those variables which are "mean()" and "std()" measures.
Refer to the readme.md file included in the zipped data file for detailed explanations of the variables.

Read the x_<train|test>.txt, y_<train|test>.txt and subject_<train|test>.txt data files for the train and test data sets.
The x_?.txt files are the observations
The y_?.txt files are the activity being performed during the observation
The subject_?.txt files are the subjects(persons) performing the activity during which the observation is made

The variable names of the observation data points are retained through the analysis

Transform the activity from the y_?.txt files to the textual description in the activity_labels.txt file 

Combine the test and train data sets for final analysis

Calculate the mean of each observation by activity and subject

Save the results to a file

Read the results with the following command:
 data <- read.table("averages.txt", header = TRUE) 
 View(data)



