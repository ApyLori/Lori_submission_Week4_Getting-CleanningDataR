README.md

===========================================

The script works as described below: 

Reading original data from directory and save the data into different data frames

- read in the train and test data files from the <UCI HAR Dataset> directory
- read in subject information from the train and test directory
- read in features.txt and activity_levels.txt 

Joint the train and test data set

Create activity labels for data frame according to activity_levels.txt

Select features of mean and std of the measurements and rename the variable names
- remove '(',')' and replace '-' with '_' in the variable names

Create data frame data_all with 79 selected mean and std variables, add subject ID (subID) and activity label (activity) to the data frame

Group the data frame by 'subID' and 'activity' to data_tidy

Summarise the mean of each variables in the grouped data frame data_tidy_summary

Write data_tidy_summary to data_tidy.txt 


