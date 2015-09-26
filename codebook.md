#Project Description
This is my course project for the Coursera Getting and Cleaning Data Module
The purpose of this is to create a tidy data set that meets the guidelines for tidy data.
The project uses raw data from the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
and a full description of the data can be found by following the link. 

#Study design and data processing
##Collection of the raw data
The data used in this project is the Human Activity Recognition Using Smartphones Dataset
Version 1.0
The raw data used in this project has been provided by UCI Machine Learning (link above). The data collection is described as follows:

"_The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data._

_The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain."_


##Notes on the original (raw) data
The data is split into two, the test data and the training data.
The data is provided in a compressed zip file containing the following files that were used in the project:
(files not listed here but in the data set were not used)

File Name | Description | Used in this project or not
----------|-------------|----------------------------
Readme.txt| Descriptive narrative of the data set and the files | used to provide the understanding of the data |
features.txt| Contains the varible names for the main tables| Used to create the inital column headings
features_info.txt|Contains a description of the variables | Used to understand variable units and purpose
activity_labels.txt| Contains the observation types for the main data| Used to identify the activity types as row names in the final data set
test data: X_test.txt| Observations recoreded for the test activities | Used as part of the main data set
test data: y_test.txt | Activity identifier for each observation | Used to create the activity varible for each observation
test data: subject_test.txt | Subject identifier for each observation | Used as the subject identifer in the data sets
train data: X_train.txt| Observations recoreded for the training activities | Used as part of the main data set
train data: y_train.txt | Activity identifier for each observation | Used to create the activity varible for each observation
train data: subject_train.txt | Subject identifier for each observation | Used as the subject identifer in the data sets


Some additional notes (if avaialble, otherwise you can leave this section out).

Creating the tidy datafile

Guide to create the tidy data file

Description on how to create the tidy data file (1. download the data, ...)/

Cleaning of the data

Short, high-level description of what the cleaning script does. link to the readme document that describes the code in greater detail

Description of the variables in the tiny_data.txt file

General description of the file including:

Dimensions of the dataset
Summary of the data
Variables present in the dataset
(you can easily use Rcode for this, just load the dataset and provide the information directly form the tidy data file)

Variable 1 (repeat this section for all variables in the dataset)

Short description of what the variable describes.

Some information on the variable including:

Class of the variable
Unique values/levels of the variable
Unit of measurement (if no unit of measurement list this as well)
In case names follow some schema, describe how entries were constructed (for example time-body-gyroscope-z has 4 levels of descriptors. Describe these 4 levels).
(you can easily use Rcode for this, just load the dataset and provide the information directly form the tidy data file)

Notes on variable 1:

If available, some additional notes on the variable not covered elsewehere. If no notes are present leave this section out.

Sources

Sources you used if any, otherise leave out.

Annex

If you used any code in the codebook that had the echo=FALSE attribute post this here (make sure you set the results parameter to 'hide' as you do not want the results to show again)
