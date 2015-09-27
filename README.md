# Getting and Cleaning Data Course Project
## Overview
This is my course project for the Coursera Getting and Cleaning Data Module
The purpose of this is to create a tidy data set that meets the guidelines for tidy data.
The project uses raw data from the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
and a full description of the data can be found by following the link. 


## Raw Data
The raw data has been collected from accelerometer and gyroscope of a Samsung Galaxy S II whilst subjects conduct various activities like walking, standing and sitting (full list in the Codebook.md).  

## Data processing and scripts
The processing of the data all takes place in a single script run_analysis.R
This script conducts the following steps (described in more detail in the Codebook.md):

1. Downloads the various raw data files and merges them into a single data frame
2. Extracts the measurements that are mean or standard deviations for the measurements and discards the rest
3. Adds the descriptive column names to the data frame
4. Adds the descriptive activity names to the rows
5. Amends the column names to be more readable
6. These steps produce a tidy data set named main_data that meets the objectives of the tidy data guidelines.
7. And finally, create a separate data frame called mean_readings that is a tidy data set with the average of each variable for each activity and each subject. This is written out as a text file called mean_readings.txt.

## Outputs and files
This repo contains the following files:
* README.md - this file
* Codebook.md - the fuller description of the run_analysis.R
* run_analysis.R -the main script that produces the two tidy data files
* mean_readings.txt - a copy of the text file output that contains the mean readings for the data.

# run_analysis.R detailed description

**Setting up the environment:**

The dplyr package is loaded primarily for the later grouping and summarising of the mean_readings data set.
A directory is created called ./data (if not already in use) for the raw data to be downloaded into.

**Downloading the zip file**

Checks to see if it is already there, if not - downloads the file from url:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
and stores it in a file called smartphone.zip in the ./data directory.

**Unzip the raw data.**

Checks to see if it has already been loaded, if not uses the unzip() function to unzip the file. It creates a new directory in the working directory called "UCI HAR Dataset" that contains all the seperate files used o construct the tidy data sets.

**Create the column names**

Using read.table() function, read in the features.txt file into a variable called fatures.
Convert it from a factor to a list.

Find the colunm names containing mean() and std() that are to be used in the tidy data set. 
Using the grep() function, search in the features lsit for mean() and std() create the index in the vector mean_std

**Build the first data frame for the test data:**

Load in the X_test.txt file in to test_data object.
Add the column names from the feature list and then selct only those columns needed using the mean_std index.
Read in the subject identifiers from the subject.txt file and add the varible name "subject" to it.
Read in the activities identifiers from the y_test.txt file and add the variable name "activities" to it.
Combine the three objects into a single data frame called test_data. The subject variable is added to the left followed by actvitiy and then the test_data using the cbind() function.

** The train data data frame is built** in the same way as the test data from the test data sub-directory and substituting train for test.

Uing the rbind() function, test_data and train_data are combined to create main_data data frame. This is the baisis of the tidy data set.

**Cleaning the main_data object:**

The activitiy references in the activitiy variable are converted to descriptive terms by:
reading in the activity_labels.txt file into the activities object and converted to character list.
Then the activity variable in main_data is amended using the de4scriptive terms in the activities variable.

Using gsub() function, the column names in the main_data object are amended to be more descriptive (see codebook.md)

**This results in  a tidy data main_data data frame.**

**Creating the independant, grouped and summarised data set called mean_readings**

mean_readings is created by grouping main_data by subject and activity
mean_readings is summarised using the summarise_each() function using the mean function across all the variables
mean_readings is output as a txt file using write.tabel and row.names = FALSE to a file called mean_readings.txt in the ./data directory.

Finally, the environment is cleaned up by removing the intermediate objects leaving only main_data and mean_readings.


