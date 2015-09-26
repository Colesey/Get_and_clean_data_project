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


