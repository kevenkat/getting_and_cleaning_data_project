# Getting and Cleaning Data - Course Project
#Author : kevenkat

This is my course project assignment for the Getting and Cleaning Data Coursera course.
The code assumes the dataset is already downloaded and extracted in to working directory.
The code contained in "run_analysis.R", does the following:

1. Loads the training and test data for  x, y and subject data in to memory objects.
2. Merges the data training and test data for x, y and subject data.
3. Extracts only the columns with mean or Standard Deviation data for each measurement.
4. Set decriptive activity names to corresponding activity codes in dataset, from activity list 
5. Set meaningful label for column headings 
6. create a second, independent tidy data set with the average of each variable for each activity and each subject.

The end result is shown in the file `tidy_data.txt`.