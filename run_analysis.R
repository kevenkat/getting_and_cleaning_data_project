# Course Project Assignment - Getting and Cleaning Data

# Goal : Create a tidy data set


# Precondition : Data to be analysed is already downloaded, saved and unzipped in to 
# working directory under folder "UCI HAR Dataset"

###############################################################################
# 1.Merge the training and test sets to create one data set
##############################################################################

#Read x, y and suject data from train folder
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

#Read x, y and suject data from test folder
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# create merged x data set
x_mdata <- rbind(x_train, x_test)

# create merged y data set
y_mdata <- rbind(y_train, y_test)

# create merged subject data set
subject_mdata <- rbind(subject_train, subject_test)

#######################################################################################
# 2.Extract only the measurements on the mean and standard deviation for each measurement. 
#######################################################################################

#Read features list
features <- read.table("UCI HAR Dataset/features.txt")

# search and extract only names matching mean or std 
ms_features <- grep("-(mean|std)\\(\\)", features[, 2])

# subset the merged data with only mean and std  columns
x_mdata <- x_mdata[, ms_features]

# update the column names with ms names
names(x_mdata) <- features[ms_features, 2]


#######################################################################################
# 3.Uses descriptive activity names to name the activities in the data set 
#######################################################################################
#Read activity list
act_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

# update merged y code values with  corresponding activity names
y_mdata[, 1] <- act_labels[y_mdata[, 1], 2]

# set the column name 
names(y_mdata) <- "activity"

#######################################################################################
# 4.Appropriately labels the data set with descriptive variable names. 
#######################################################################################

#set the column name for subject data
names(subject_mdata) <- "subject"

# combine all the x, y and subject data in a single data set joining columns
combined_data <- cbind(x_mdata, y_mdata, subject_mdata)

#set meaningful column names : t-Time, f-Frequency, Acc- Accelerometer,Mag - Magnitude 
names(combined_data)<-gsub("^t", "Time", names(combined_data))
names(combined_data)<-gsub("^f", "Frequency", names(combined_data))
names(combined_data)<-gsub("Acc", "Accelerometer", names(combined_data))
names(combined_data)<-gsub("Mag", "Magnitude", names(combined_data))


#######################################################################################
# 5.create a second, independent tidy data set with the average of each variable for each activity and each subject. 
#######################################################################################
# names(combined_data)
# of the 68 columns 67 - activity, 68 - subject

library(plyr);
# apply average for each activity and subject
tidy_data <- ddply(combined_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

#Write result to text file
write.table(tidy_data, "tidy_data.txt", row.name=FALSE)





