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


#Creating the tidy datafile

The script run_analysis.R is the only script in the project and it runs through the following steps. The script makes use of the dplyr package.

The outputs from this script are two tidy data sets:

1. main_data - this is the reconstructed data frame from the raw test and train data with only the varibles that are either mean() of std().
2. mean_readings.txt - this is the text file of the summarised main_data data set with the average of each variable for each activity and each subject

##Getting the raw data
In the run_analysis.R script the following stages are gone through to download and create the initail untidy dataset.

1. The file is downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip as a zip file.
2. The script will place this file in a subdirectory of your working directory called /data
3. The file is then unzipped into another sub directory called ./UCI HAR Dataset this then contains the uncompressed files

##Constructing the data set
The raw data set is divided into test and train data with both provided in components that are assembled into a single data frame to be used in the project. 
For each of the test and train data, a data frame is built using the X_test.tx and X_train.txt files. To both were added the column names by using the features.txt file as a list. 
As we are only using those variables that are a mean() or std() reading, using the grep function the column indices for these were identified. Using the index, the data frames were reduced to only those columns containing the mean() or std() in thier names.
To each of the data frames, the subject and activitiy identifiers were added to the left from the respective subject.txt and the y_trian.txt and y_test.txt files. 
Laastly, the two train and test data frames are comined using the rbind function to creat the intermediate tidy data set called main_data

##Cleaning of the data
the following two processes were used to create a more readable data set by adding descriptive names in the activity variable and changing the measurment variable names to a fuller descritptive name.
The activity_labels.txt contains the desctiptive names for the actvitiy numeric identifier in the main_data object. This file was read in and converted to a character list (from factors) and applied to the main_data$activities column using the numeric identifier as a index to the list.

The column names were expanded to be more descriptive, for each occurance of the following text in the column names shown in the table as Original Variable Name, this was changed using the gsub() function to the text shown in the Tidy Variable Name:


Original Variable Name Contains: | Tidy Variable Name Contains: 
----------|-------------
tBodyAcc| time body accelerometer 
tGravityAcc | time gravity accelerometer
tBodyGyro | time body gyrometer
fGravityAcc | fft body accelerometer
fBodyAcc" | fft body accelerometer
fBodyGyro | fft body gyrometer
fBodyBodyGyro | fft body body gyrometer
fBodyBodyAcc | fft body body accelerometer
Jerk | jerk
Mag | magnitude


#Description of the variables in the main_data file

##Dimensions of the dataset
The dimensions of main_data are 10299 rows and 68 columns

##Variables present in the main_data object:
These are present in both the main_table data set and the mean_readings data set. The main_data contains the original values form the raw data set. The mean_readings contains the mean of the readings for each subject and each activity.

Variable | Description | Class | Unit of measure | Levels of Descriptor
---------------------------------|-----------------------|----------|--------|-------------------------|
subject | Unique number that identifies the subject in each observation | integer | none | none
activity | Description of the activity being undertaken by the subject for the observation | character | none | There are 6 levels: walking, sitting laying, standing, walking_downstairs, walking_upstairs
time body accelerometer-mean()-X | accelerometer measurment | numeric | time | none
time body accelerometer-mean()-Y | accelerometer measurment | numeric | time | none                 
time body accelerometer-mean()-Z | accelerometer measurment | numeric | time | none
time body accelerometer-std()-X | accelerometer measurment | numeric | time | none    
time body accelerometer-std()-Y | accelerometer measurment | numeric | time | none
time body accelerometer-std()-Z | accelerometer measurment | numeric | time | none               
time gravity accelerometer-mean()-X | accelerometer measurment | numeric | time | none
time gravity accelerometer-mean()-Y | accelerometer measurment | numeric | time | none           
time gravity accelerometer-mean()-Z | accelerometer measurment | numeric | time | none
time gravity accelerometer-std()-X | accelerometer measurment | numeric | time | none           
time gravity accelerometer-std()-Y | accelerometer measurment | numeric | time | none
time gravity accelerometer-std()-Z | accelerometer measurment | numeric | time | none           
time body accelerometer jerk-mean()-X | accelerometer measurment | numeric | time | none
time body accelerometer jerk-mean()-Y | accelerometer measurment | numeric | time | none       
time body accelerometer jerk-mean()-Z | accelerometer measurment | numeric | time | none
time body accelerometer jerk-std()-X | accelerometer measurment | numeric | time | none        
time body accelerometer jerk-std()-Y | accelerometer measurment | numeric | time | none
time body accelerometer jerk-std()-Z | accelerometer measurment | numeric | time | none         
time body gyrometer-mean()-X | gyrometer measurment| numeric| time | none
time body gyrometer-mean()-Y | gyrometer measurment| numeric| time | none             
time body gyrometer-mean()-Z | gyrometer measurment| numeric| time | none
time body gyrometer-std()-X | gyrometer measurment| numeric| time | none                
time body gyrometer-std()-Y | gyrometer measurment| numeric| time | none
time body gyrometer-std()-Z | gyrometer measurment| numeric| time | none                 
time body gyrometer jerk-mean()-X | gyrometer jerk measurment| numeric| time | none
ime body gyrometer jerk-mean()-Y | gyrometer jerk measurment| numeric| time | none          
time body gyrometer jerk-mean()-Z | gyrometer jerk measurment| numeric| time | none
time body gyrometer jerk-std()-X | gyrometer jerk measurment| numeric| time | none            
time body gyrometer jerk-std()-Y | gyrometer jerk measurment| numeric| time | none
time body gyrometer jerk-std()-Z | gyrometer jerk measurment| numeric| time | none             
time body accelerometer magnitude-mean() | accelerometer magnitude measurement| numeric| time | none
time body accelerometer magnitude-std() | accelerometer magnitude measurement| numeric| time | none    
time gravity accelerometer magnitude-mean() | accelerometer magnitude measurement| numeric| time | none
time gravity accelerometer magnitude-std() | accelerometer magnitude measurement| numeric| time | none  
time body accelerometer jerk magnitude-mean() | accelerometer magnitude measurement| numeric| time | none
time body accelerometer jerk magnitude-std() | accelerometer magnitude measurement| numeric| time | none
time body gyrometer magnitude-mean() | gyrometer magnitude measurment| numeric| time | none  
time body gyrometer magnitude-std() | gyrometer magnitude measurment| numeric| time | none        
time body gyrometer jerk magnitude-mean() | gyrometer jerk magnitude measurment| numeric| time | none
time body gyrometer jerk magnitude-std() | gyrometer jerk magnitude measurment| numeric| time | none 
fft body accelerometer-mean()-X |fast fourier transform accelerometer measurment | numeric | time | none
fft body accelerometer-mean()-Y |fast fourier transform accelerometer measurment | numeric | time | none              
fft body accelerometer-mean()-Z |fast fourier transform accelerometer measurment | numeric | time | none
fft body accelerometer-std()-X |fast fourier transform accelerometer measurment | numeric | time | none            
fft body accelerometer-std()-Y |fast fourier transform accelerometer measurment | numeric | time | none
fft body accelerometer-std()-Z |fast fourier transform accelerometer measurment | numeric | time | none              
fft body accelerometer jerk-mean()-X |fast fourier transform accelerometer jerk measurment | numeric | time | none
fft body accelerometer jerk-mean()-Y |fast fourier transform accelerometer jerk measurment | numeric | time | none        
fft body accelerometer jerk-mean()-Z |fast fourier transform accelerometer jerk measurment | numeric | time | none
fft body accelerometer jerk-std()-X |fast fourier transform accelerometer jerk measurment | numeric | time | none       
fft body accelerometer jerk-std()-Y |fast fourier transform accelerometer jerk measurment | numeric | time | none
fft body accelerometer jerk-std()-Z |fast fourier transform accelerometer jerk measurment | numeric | time | none
fft body gyrometer-mean()-X |fast fourier transform gyrometer measurment | numeric | time | none
fft body gyrometer-mean()-Y |fast fourier transform gyrometer measurment | numeric | time | none                 
fft body gyrometer-mean()-Z |fast fourier transform gyrometer measurment | numeric | time | none
fft body gyrometer-std()-X |fast fourier transform gyrometer measurment | numeric | time | none                 
fft body gyrometer-std()-Y |fast fourier transform gyrometer measurment | numeric | time | none
fft body gyrometer-std()-Z |fast fourier transform gyrometer measurment | numeric | time | none                  
fft body accelerometer magnitude-mean() |fast fourier transform accelerometer magnitude measurment | numeric | time | none
fft body accelerometer magnitude-std() |fast fourier transform accelerometer magnitude measurment | numeric | time | none      
fft body body accelerometer jerk magnitude-mean() |fast fourier transform accelerometer jerk magnitude measurment | numeric | time | none
fft body body accelerometer jerk magnitude-std() |fast fourier transform accelerometer jerk magnitude measurment | numeric | time | none
fft body body gyrometer magnitude-mean() |fast fourier transform gyrometer magnitude measurment | numeric | time | none
fft body body gyrometer magnitude-std() |fast fourier transform gyrometer magnitude measurment | numeric | time | none 
fft body body gyrometer jerk magnitude-mean() |fast fourier transform gyrometer jerk magnitude measurment | numeric | time | none
fft body body gyrometer jerk magnitude-std() |fast fourier transform gyrometer jerk magnitude measurment | numeric | time | none


#Summary of the data
using str(main_data) function

 $ subject                                          : int  2 2 2 2 2 2 2 2 2 2 ...
 
 $ activity                                         : chr  "STANDING" "STANDING" "STANDING" "STANDING" ...
 
 $ time body accelerometer-mean()-X                 : num  0.257 0.286 0.275 0.27 0.275 ...
 
 $ time body accelerometer-mean()-Y                 : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
 
 $ time body accelerometer-mean()-Z                 : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...
 
 $ time body accelerometer-std()-X                  : num  -0.938 -0.975 -0.994 -0.995 -0.994 ...
 
 $ time body accelerometer-std()-Y                  : num  -0.92 -0.967 -0.97 -0.973 -0.967 ...
 
 $ time body accelerometer-std()-Z                  : num  -0.668 -0.945 -0.963 -0.967 -0.978 ...
 
 $ time gravity accelerometer-mean()-X              : num  0.936 0.927 0.93 0.929 0.927 ...
 
 $ time gravity accelerometer-mean()-Y              : num  -0.283 -0.289 -0.288 -0.293 -0.303 ...
 
 $ time gravity accelerometer-mean()-Z              : num  0.115 0.153 0.146 0.143 0.138 ...
 
 $ time gravity accelerometer-std()-X               : num  -0.925 -0.989 -0.996 -0.993 -0.996 ...
 
 $ time gravity accelerometer-std()-Y               : num  -0.937 -0.984 -0.988 -0.97 -0.971 ...
 
 $ time gravity accelerometer-std()-Z               : num  -0.564 -0.965 -0.982 -0.992 -0.968 ...
 
 $ time body accelerometer jerk-mean()-X            : num  0.072 0.0702 0.0694 0.0749 0.0784 ...
 
 $ time body accelerometer jerk-mean()-Y            : num  0.04575 -0.01788 -0.00491 0.03227 0.02228 ...
 
 $ time body accelerometer jerk-mean()-Z            : num  -0.10604 -0.00172 -0.01367 0.01214 0.00275 ...
 
 $ time body accelerometer jerk-std()-X             : num  -0.907 -0.949 -0.991 -0.991 -0.992 ...
 
 $ time body accelerometer jerk-std()-Y             : num  -0.938 -0.973 -0.971 -0.973 -0.979 ...
 
 $ time body accelerometer jerk-std()-Z             : num  -0.936 -0.978 -0.973 -0.976 -0.987 ...
 
 $ time body gyrometer-mean()-X                     : num  0.11998 -0.00155 -0.04821 -0.05664 -0.05999 ...
 
 $ time body gyrometer-mean()-Y                     : num  -0.0918 -0.1873 -0.1663 -0.126 -0.0847 ...
 
 $ time body gyrometer-mean()-Z                     : num  0.1896 0.1807 0.1542 0.1183 0.0787 ...
 
 $ time body gyrometer-std()-X                      : num  -0.883 -0.926 -0.973 -0.968 -0.975 ...
 
 $ time body gyrometer-std()-Y                      : num  -0.816 -0.93 -0.979 -0.975 -0.978 ...
 
 $ time body gyrometer-std()-Z                      : num  -0.941 -0.968 -0.976 -0.963 -0.968 ...
 
 $ time body gyrometer jerk-mean()-X                : num  -0.2049 -0.1387 -0.0978 -0.1022 -0.0918 ...
 
 $ time body gyrometer jerk-mean()-Y                : num  -0.1745 -0.0258 -0.0342 -0.0447 -0.029 ...
 
 $ time body gyrometer jerk-mean()-Z                : num  -0.0934 -0.0714 -0.06 -0.0534 -0.0612 ...
 
 $ time body gyrometer jerk-std()-X                 : num  -0.901 -0.962 -0.984 -0.984 -0.988 ...
 
 $ time body gyrometer jerk-std()-Y                 : num  -0.911 -0.956 -0.988 -0.99 -0.992 ...
 
 $ time body gyrometer jerk-std()-Z                 : num  -0.939 -0.981 -0.976 -0.981 -0.982 ...
 
 $ time body accelerometer magnitude-mean()         : num  -0.867 -0.969 -0.976 -0.974 -0.976 ...
 
 $ time body accelerometer magnitude-std()          : num  -0.705 -0.954 -0.979 -0.977 -0.977 ...
 
 $ time gravity accelerometer magnitude-mean()      : num  -0.867 -0.969 -0.976 -0.974 -0.976 ...
 
 $ time gravity accelerometer magnitude-std()       : num  -0.705 -0.954 -0.979 -0.977 -0.977 ...
 
 $ time body accelerometer jerk magnitude-mean()    : num  -0.93 -0.974 -0.982 -0.983 -0.987 ...
 
 $ time body accelerometer jerk magnitude-std()     : num  -0.896 -0.941 -0.971 -0.975 -0.989 ...
 
 $ time body gyrometer magnitude-mean()             : num  -0.796 -0.898 -0.939 -0.947 -0.957 ...
 
 $ time body gyrometer magnitude-std()              : num  -0.762 -0.911 -0.972 -0.97 -0.969 ...
 
 $ time body gyrometer jerk magnitude-mean()        : num  -0.925 -0.973 -0.987 -0.989 -0.99 ...
 
 $ time body gyrometer jerk magnitude-std()         : num  -0.894 -0.944 -0.984 -0.986 -0.99 ...
 
 $ fft body accelerometer-mean()-X                  : num  -0.919 -0.961 -0.992 -0.993 -0.992 ...
 
 $ fft body accelerometer-mean()-Y                  : num  -0.918 -0.964 -0.965 -0.968 -0.969 ...
 
 $ fft body accelerometer-mean()-Z                  : num  -0.789 -0.957 -0.967 -0.967 -0.98 ...
 
 $ fft body accelerometer-std()-X                   : num  -0.948 -0.984 -0.995 -0.996 -0.995 ...
 
 $ fft body accelerometer-std()-Y                   : num  -0.925 -0.97 -0.974 -0.977 -0.967 ...
 
 $ fft body accelerometer-std()-Z                   : num  -0.636 -0.942 -0.962 -0.969 -0.978 ...
 
 $ fft body accelerometer jerk-mean()-X             : num  -0.9 -0.944 -0.991 -0.991 -0.991 ...
 
 $ fft body accelerometer jerk-mean()-Y             : num  -0.937 -0.969 -0.973 -0.972 -0.98 ...
 
 $ fft body accelerometer jerk-mean()-Z             : num  -0.924 -0.973 -0.972 -0.97 -0.983 ...
 
 $ fft body accelerometer jerk-std()-X              : num  -0.924 -0.962 -0.992 -0.992 -0.994 ...
 
 $ fft body accelerometer jerk-std()-Y              : num  -0.943 -0.98 -0.971 -0.975 -0.979 ...
 
 $ fft body accelerometer jerk-std()-Z              : num  -0.948 -0.981 -0.972 -0.981 -0.989 ...
 
 $ fft body gyrometer-mean()-X                      : num  -0.824 -0.923 -0.973 -0.972 -0.976 ...
 
 $ fft body gyrometer-mean()-Y                      : num  -0.808 -0.926 -0.981 -0.981 -0.98 ...
 
 $ fft body gyrometer-mean()-Z                      : num  -0.918 -0.968 -0.972 -0.967 -0.969 ...
 
 $ fft body gyrometer-std()-X                       : num  -0.903 -0.927 -0.973 -0.967 -0.974 ...
 
 $ fft body gyrometer-std()-Y                       : num  -0.823 -0.932 -0.977 -0.972 -0.977 ...
 
 $ fft body gyrometer-std()-Z                       : num  -0.956 -0.97 -0.979 -0.965 -0.97 ...
 
 $ fft body accelerometer magnitude-mean()          : num  -0.791 -0.954 -0.976 -0.973 -0.978 ...
 
 $ fft body accelerometer magnitude-std()           : num  -0.711 -0.96 -0.984 -0.982 -0.979 ...
 
 $ fft body body accelerometer jerk magnitude-mean(): num  -0.895 -0.945 -0.971 -0.972 -0.987 ...
 
 $ fft body body accelerometer jerk magnitude-std() : num  -0.896 -0.934 -0.97 -0.978 -0.99 ...
 
 $ fft body body gyrometer magnitude-mean()         : num  -0.771 -0.924 -0.975 -0.976 -0.977 ...
 
 $ fft body body gyrometer magnitude-std()          : num  -0.797 -0.917 -0.974 -0.971 -0.97 ...
 
 $ fft body body gyrometer jerk magnitude-mean()    : num  -0.89 -0.952 -0.986 -0.986 -0.99 ...
 
 $ fft body body gyrometer jerk magnitude-std()     : num  -0.907 -0.938 -0.983 -0.986 -0.991 ...
 
 
## Summary for mean_readings text file
The mean_readings data set uses the same data as main_data grouped by subject and activity with the mean of the measurments.
The column names for the measurements are amended to add the "mean of measurement for:" to show they are average values.
It has been output as a text file called mean_readings.txt

#The str() for mean_readings is as follows:

Classes ‘grouped_df’, ‘tbl_df’, ‘tbl’ and 'data.frame':	180 obs. of  68 variables:

 $ subject                                          : int  1 1 1 1 1 1 2 2 2 2 ...
 
 $ activity                                         : chr  "LAYING" "SITTING" "STANDING" "WALKING" ...
 
 $ time body accelerometer-mean()-X                 : num  0.222 0.261 0.279 0.277 0.289 ...
 
 $ time body accelerometer-mean()-Y                 : num  -0.04051 -0.00131 -0.01614 -0.01738 -0.00992 ...
 
 $ time body accelerometer-mean()-Z                 : num  -0.113 -0.105 -0.111 -0.111 -0.108 ...
 
 $ time body accelerometer-std()-X                  : num  -0.928 -0.977 -0.996 -0.284 0.03 ...
 
 $ time body accelerometer-std()-Y                  : num  -0.8368 -0.9226 -0.9732 0.1145 -0.0319 ...
 
 $ time body accelerometer-std()-Z                  : num  -0.826 -0.94 -0.98 -0.26 -0.23 ...
 
 $ time gravity accelerometer-mean()-X              : num  -0.249 0.832 0.943 0.935 0.932 ...
 
 $ time gravity accelerometer-mean()-Y              : num  0.706 0.204 -0.273 -0.282 -0.267 ...
 
 $ time gravity accelerometer-mean()-Z              : num  0.4458 0.332 0.0135 -0.0681 -0.0621 ...
 
 $ time gravity accelerometer-std()-X               : num  -0.897 -0.968 -0.994 -0.977 -0.951 ...
 
 $ time gravity accelerometer-std()-Y               : num  -0.908 -0.936 -0.981 -0.971 -0.937 ...
 
 $ time gravity accelerometer-std()-Z               : num  -0.852 -0.949 -0.976 -0.948 -0.896 ...
 
 $ time body accelerometer jerk-mean()-X            : num  0.0811 0.0775 0.0754 0.074 0.0542 ...
 
 $ time body accelerometer jerk-mean()-Y            : num  0.003838 -0.000619 0.007976 0.028272 0.02965 ...
 
 $ time body accelerometer jerk-mean()-Z            : num  0.01083 -0.00337 -0.00369 -0.00417 -0.01097 ...
 
 $ time body accelerometer jerk-std()-X             : num  -0.9585 -0.9864 -0.9946 -0.1136 -0.0123 ...
 
 $ time body accelerometer jerk-std()-Y             : num  -0.924 -0.981 -0.986 0.067 -0.102 ...
 
 $ time body accelerometer jerk-std()-Z             : num  -0.955 -0.988 -0.992 -0.503 -0.346 ...
 
 $ time body gyrometer-mean()-X                     : num  -0.0166 -0.0454 -0.024 -0.0418 -0.0351 ...
 
 $ time body gyrometer-mean()-Y                     : num  -0.0645 -0.0919 -0.0594 -0.0695 -0.0909 ...
 
 $ time body gyrometer-mean()-Z                     : num  0.1487 0.0629 0.0748 0.0849 0.0901 ...
 
 $ time body gyrometer-std()-X                      : num  -0.874 -0.977 -0.987 -0.474 -0.458 ...
 
 $ time body gyrometer-std()-Y                      : num  -0.9511 -0.9665 -0.9877 -0.0546 -0.1263 ...
 
 $ time body gyrometer-std()-Z                      : num  -0.908 -0.941 -0.981 -0.344 -0.125 ...
 
 $ time body gyrometer jerk-mean()-X                : num  -0.1073 -0.0937 -0.0996 -0.09 -0.074 ...
 
 $ time body gyrometer jerk-mean()-Y                : num  -0.0415 -0.0402 -0.0441 -0.0398 -0.044 ...
 
 $ time body gyrometer jerk-mean()-Z                : num  -0.0741 -0.0467 -0.049 -0.0461 -0.027 ...
 
 $ time body gyrometer jerk-std()-X                 : num  -0.919 -0.992 -0.993 -0.207 -0.487 ...
 
 $ time body gyrometer jerk-std()-Y                 : num  -0.968 -0.99 -0.995 -0.304 -0.239 ...
 
 $ time body gyrometer jerk-std()-Z                 : num  -0.958 -0.988 -0.992 -0.404 -0.269 ...
 
 $ time body accelerometer magnitude-mean()         : num  -0.8419 -0.9485 -0.9843 -0.137 0.0272 ...
 
 $ time body accelerometer magnitude-std()          : num  -0.7951 -0.9271 -0.9819 -0.2197 0.0199 ...

 $ time gravity accelerometer magnitude-mean()      : num  -0.8419 -0.9485 -0.9843 -0.137 0.0272 ...
 
 $ time gravity accelerometer magnitude-std()       : num  -0.7951 -0.9271 -0.9819 -0.2197 0.0199 ...
 
 $ time body accelerometer jerk magnitude-mean()    : num  -0.9544 -0.9874 -0.9924 -0.1414 -0.0894 ...
 
 $ time body accelerometer jerk magnitude-std()     : num  -0.9282 -0.9841 -0.9931 -0.0745 -0.0258 ...
 
 $ time body gyrometer magnitude-mean()             : num  -0.8748 -0.9309 -0.9765 -0.161 -0.0757 ...
 
 $ time body gyrometer magnitude-std()              : num  -0.819 -0.935 -0.979 -0.187 -0.226 ...
 
 $ time body gyrometer jerk magnitude-mean()        : num  -0.963 -0.992 -0.995 -0.299 -0.295 ...
 
 $ time body gyrometer jerk magnitude-std()         : num  -0.936 -0.988 -0.995 -0.325 -0.307 ...
 
 $ fft body accelerometer-mean()-X                  : num  -0.9391 -0.9796 -0.9952 -0.2028 0.0382 ...
 
 $ fft body accelerometer-mean()-Y                  : num  -0.86707 -0.94408 -0.97707 0.08971 0.00155 ...
 
 $ fft body accelerometer-mean()-Z                  : num  -0.883 -0.959 -0.985 -0.332 -0.226 ...
 
 $ fft body accelerometer-std()-X                   : num  -0.9244 -0.9764 -0.996 -0.3191 0.0243 ...
 
 $ fft body accelerometer-std()-Y                   : num  -0.834 -0.917 -0.972 0.056 -0.113 ...
 
 $ fft body accelerometer-std()-Z                   : num  -0.813 -0.934 -0.978 -0.28 -0.298 ...
 
 $ fft body accelerometer jerk-mean()-X             : num  -0.9571 -0.9866 -0.9946 -0.1705 -0.0277 ...
 
 $ fft body accelerometer jerk-mean()-Y             : num  -0.9225 -0.9816 -0.9854 -0.0352 -0.1287 ...
 
 $ fft body accelerometer jerk-mean()-Z             : num  -0.948 -0.986 -0.991 -0.469 -0.288 ...
 
 $ fft body accelerometer jerk-std()-X              : num  -0.9642 -0.9875 -0.9951 -0.1336 -0.0863 ...
 
 $ fft body accelerometer jerk-std()-Y              : num  -0.932 -0.983 -0.987 0.107 -0.135 ...
 
 $ fft body accelerometer jerk-std()-Z              : num  -0.961 -0.988 -0.992 -0.535 -0.402 ...
 
 $ fft body gyrometer-mean()-X                      : num  -0.85 -0.976 -0.986 -0.339 -0.352 ...
 
 $ fft body gyrometer-mean()-Y                      : num  -0.9522 -0.9758 -0.989 -0.1031 -0.0557 ...
 
 $ fft body gyrometer-mean()-Z                      : num  -0.9093 -0.9513 -0.9808 -0.2559 -0.0319 ...
 
 $ fft body gyrometer-std()-X                       : num  -0.882 -0.978 -0.987 -0.517 -0.495 ...
 
 $ fft body gyrometer-std()-Y                       : num  -0.9512 -0.9623 -0.9871 -0.0335 -0.1814 ...
 
 $ fft body gyrometer-std()-Z                       : num  -0.917 -0.944 -0.982 -0.437 -0.238 ...
 
 $ fft body accelerometer magnitude-mean()          : num  -0.8618 -0.9478 -0.9854 -0.1286 0.0966 ...
 
 $ fft body accelerometer magnitude-std()           : num  -0.798 -0.928 -0.982 -0.398 -0.187 ...
 
 $ fft body body accelerometer jerk magnitude-mean(): num  -0.9333 -0.9853 -0.9925 -0.0571 0.0262 ...
 
 $ fft body body accelerometer jerk magnitude-std() : num  -0.922 -0.982 -0.993 -0.103 -0.104 ...
 
 $ fft body body gyrometer magnitude-mean()         : num  -0.862 -0.958 -0.985 -0.199 -0.186 ...
 
 $ fft body body gyrometer magnitude-std()          : num  -0.824 -0.932 -0.978 -0.321 -0.398 ...
 
 $ fft body body gyrometer jerk magnitude-mean()    : num  -0.942 -0.99 -0.995 -0.319 -0.282 ...
 
 $ fft body body gyrometer jerk magnitude-std()     : num  -0.933 -0.987 -0.995 -0.382 -0.392 ...
 
 
 The end.



