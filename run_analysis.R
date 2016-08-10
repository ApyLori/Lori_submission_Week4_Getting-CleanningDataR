# this script create a output file data_tidy.txt

# load library
library(dplyr);
library(tidyr);

# define data path and file names
dataPath <- "UCI HAR Dataset";

fileName_train_X <- paste(dataPath,"/train/X_train.txt",sep = "");
fileName_train_y <- paste(dataPath,"/train/y_train.txt",sep = "");
fileName_train_sub <- paste(dataPath,"/train/subject_train.txt",sep = "");

fileName_test_X <- paste(dataPath,"/test/X_test.txt",sep = "");
fileName_test_y <- paste(dataPath,"/test/y_test.txt",sep = "");
fileName_test_sub <- paste(dataPath,"/test/subject_test.txt",sep = "");

fileName_feature <- paste(dataPath,"/features.txt",sep = "");
fileName_activity <- paste(dataPath,"/activity_labels.txt",sep = "");

# read data into tables
data_train_X <- read.table(fileName_train_X);
data_train_Y <- read.table(fileName_train_y);
sub_train <- read.table(fileName_train_sub);

data_test_X <- read.table(fileName_test_X);
data_test_Y <- read.table(fileName_test_y);
sub_test <- read.table(fileName_test_sub);


# joint two data sets 
data_X <- rbind(data_train_X,data_test_X);
data_Y <- rbind(data_train_Y,data_test_Y);
sub <- rbind(sub_train,sub_test);
features <- read.table(fileName_feature);
actLabel <- read.table(fileName_activity);

# create activity labels 
out <- function(x){
  as.character(actLabel$V2[x]);
}
activity <- lapply(data_Y,out);

# select variables computing the mean and the std of measurements
features <- as.character(features[,2]);
idxFeaturesToKeep <- c(grep("mean",features),grep("std",features));

# change features names appropriately 
feature_mutate <- sub("\\(","",features);
feature_mutate <- sub("\\)","",feature_mutate);
feature_mutate <- sub(",","",feature_mutate);
feature_mutate <- sub("-","_",feature_mutate);
feature_mutate <- sub("-","_",feature_mutate);
features <- feature_mutate;

# create a data frame with column names as selected feature names
data_all <- cbind(sub,select(data_X,idxFeaturesToKeep),activity);
colnames(data_all) <- c("subID",features[idxFeaturesToKeep],"activity"); 

# create a tidy data set with average values of each variable for each subject in each activity
data_tidy <- group_by(data_all,subID,activity);
data_tidy_summary <- summarise_each(data_tidy,funs(mean));
write.csv(data_all,'Data_all.csv');
write.csv(data_tidy_summary,'Data_tidy_summary.csv');
write.table(data_tidy_summary, file = "data_tidy.txt", append = FALSE, quote = TRUE, sep = " ",
            eol = "\n", na = "NA", dec = ".", row.names = FALSE,
            col.names = TRUE, qmethod = c("escape", "double"),
            fileEncoding = "");

