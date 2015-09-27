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
##Varibale present in the main_data object:
[1] "subject"                                           "activity"                                         
 [3] "time body accelerometer-mean()-X"                  "time body accelerometer-mean()-Y"                 
 [5] "time body accelerometer-mean()-Z"                  "time body accelerometer-std()-X"                  
 [7] "time body accelerometer-std()-Y"                   "time body accelerometer-std()-Z"                  
 [9] "time gravity accelerometer-mean()-X"               "time gravity accelerometer-mean()-Y"              
[11] "time gravity accelerometer-mean()-Z"               "time gravity accelerometer-std()-X"               
[13] "time gravity accelerometer-std()-Y"                "time gravity accelerometer-std()-Z"               
[15] "time body accelerometer jerk-mean()-X"             "time body accelerometer jerk-mean()-Y"            
[17] "time body accelerometer jerk-mean()-Z"             "time body accelerometer jerk-std()-X"             
[19] "time body accelerometer jerk-std()-Y"              "time body accelerometer jerk-std()-Z"             
[21] "time body gyrometer-mean()-X"                      "time body gyrometer-mean()-Y"                     
[23] "time body gyrometer-mean()-Z"                      "time body gyrometer-std()-X"                      
[25] "time body gyrometer-std()-Y"                       "time body gyrometer-std()-Z"                      
[27] "time body gyrometer jerk-mean()-X"                 "time body gyrometer jerk-mean()-Y"                
[29] "time body gyrometer jerk-mean()-Z"                 "time body gyrometer jerk-std()-X"                 
[31] "time body gyrometer jerk-std()-Y"                  "time body gyrometer jerk-std()-Z"                 
[33] "time body accelerometer magnitude-mean()"          "time body accelerometer magnitude-std()"          
[35] "time gravity accelerometer magnitude-mean()"       "time gravity accelerometer magnitude-std()"       
[37] "time body accelerometer jerk magnitude-mean()"     "time body accelerometer jerk magnitude-std()"     
[39] "time body gyrometer magnitude-mean()"              "time body gyrometer magnitude-std()"              
[41] "time body gyrometer jerk magnitude-mean()"         "time body gyrometer jerk magnitude-std()"         
[43] "fft body accelerometer-mean()-X"                   "fft body accelerometer-mean()-Y"                  
[45] "fft body accelerometer-mean()-Z"                   "fft body accelerometer-std()-X"                   
[47] "fft body accelerometer-std()-Y"                    "fft body accelerometer-std()-Z"                   
[49] "fft body accelerometer jerk-mean()-X"              "fft body accelerometer jerk-mean()-Y"             
[51] "fft body accelerometer jerk-mean()-Z"              "fft body accelerometer jerk-std()-X"              
[53] "fft body accelerometer jerk-std()-Y"               "fft body accelerometer jerk-std()-Z"              
[55] "fft body gyrometer-mean()-X"                       "fft body gyrometer-mean()-Y"                      
[57] "fft body gyrometer-mean()-Z"                       "fft body gyrometer-std()-X"                       
[59] "fft body gyrometer-std()-Y"                        "fft body gyrometer-std()-Z"                       
[61] "fft body accelerometer magnitude-mean()"           "fft body accelerometer magnitude-std()"           
[63] "fft body body accelerometer jerk magnitude-mean()" "fft body body accelerometer jerk magnitude-std()" 
[65] "fft body body gyrometer magnitude-mean()"          "fft body body gyrometer magnitude-std()"          
[67] "fft body body gyrometer jerk magnitude-mean()"     "fft body body gyrometer jerk magnitude-std()"

#Dimensions of the dataset
The dimentsions of main_data are 10299 rows and 68 columns

#Summary of the data

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
