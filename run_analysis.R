#Create the environment:
library(dplyr)

if (!file.exists("./data")) {
        dir.create("./data")
}
# Download and unzip the raw data files
print("Downloading raw data....")

if (!file.exists("./data/smartphone.zip")) {
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./data/smartphone.zip", method = "curl")
}
if (!file.exists("UCI HAR Dataset")) {
unzip("./data/smartphone.zip")
}

#Create the column names from the file features.txt
features <- read.table("./UCI HAR Dataset/features.txt")
features <- as.character(features$V2)
#Find the indices of the mean and std column
mean_std <- grep("-(mean|std)\\(\\)", features) 

#==========Build the test data DF:=================
print("Building the test data frame.....")

#Read in the file of observations from test data then add the column names using features 
test_data <- read.table("./UCI HAR Dataset/test/X_test.txt")
names(test_data) <- features

#select only the columns with mean() and std() in the column names
test_data <- test_data[,mean_std]
#Read in the subject variable
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(subject_test)<- "subject"
#Read in the activity variable
activity_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
names(activity_test) <- "activity"
#Combine the Subject, Activity and test data
test_data <- cbind(subject_test, activity_test, test_data)

#==========Build the train data DF:=================

#Do the same for the train data DF as for the test data above
print("Building the train data frame.....")
train_data <- read.table("./UCI HAR Dataset/train/X_train.txt")
names(train_data) <- features
train_data <- train_data[,mean_std]
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(subject_train)<- "subject"
activity_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
names(activity_train) <- "activity"
train_data <- cbind(subject_train, activity_train, train_data)

#==========Build the single tidy data DF called main_data:=================

#Combine the two sets of observations into a single data frame
print("Building the tidy data frame main_data....")
main_data <- rbind(test_data, train_data)

#Add the meaningful activity descriptions
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
activities <- as.character(activities$V2)
main_data$activity <- activities[main_data$activity]

#===========Change the column names to plain English============
#Use gsub to change parts of the column names and build up a better description
names(main_data) <- gsub("tBodyAcc", "time body accelerometer", names(main_data))
names(main_data) <- gsub("tGravityAcc", "time gravity accelerometer", names(main_data))
names(main_data) <- gsub("tBodyGyro", "time body gyrometer", names(main_data))
names(main_data) <- gsub("fGravityAcc", "fft body accelerometer", names(main_data))
names(main_data) <- gsub("fBodyAcc", "fft body accelerometer", names(main_data))
names(main_data) <- gsub("fBodyGyro", "fft body gyrometer", names(main_data))
names(main_data) <- gsub("fBodyBodyGyro", "fft body body gyrometer", names(main_data))
names(main_data) <- gsub("fBodyBodyAcc", "fft body body accelerometer", names(main_data))

names(main_data) <- gsub("Jerk", " jerk", names(main_data))
names(main_data) <- gsub("Mag", " magnitude", names(main_data))

#===========Create the grouped and summarised DF using dplyr and create the txt file==================
print("Building the summary tidy data frame mean_readings....")
mean_readings <- group_by(main_data, subject, activity)
mean_readings <- summarise_each(mean_readings, funs(mean))
#Amend the column names to reflect that they are mean readings
for(i in 3:ncol(mean_readings)){
        colnames(mean_readings)[i] <- paste("mean of measurements for: ", colnames(mean_readings)[i])
}
write.table(mean_readings, file = "./data/mean_readings.txt", row.name = FALSE)


#===========tidy up the environment===========
#just leave the main_data and mean_readings DFs
rm(activities, features, activity_test, activity_train, subject_test, subject_train, test_data, train_data, mean_std, i)

