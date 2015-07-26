if("dplyr" %in% rownames(installed.packages()) == FALSE) {install.packages("dplyr")};library(dplyr)
if("tidyr" %in% rownames(installed.packages()) == FALSE) {install.packages("tidyr")};library(tidyr)

#download and unzip data, save the unzipped data folder HCI HAR Dataset to current working directory

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("UCI HAR Dataset")) {
  if (!file.exists("data")) {
    dir.create("data")
  }
  download.file(fileUrl, destfile="data/ucihardata.zip")
  unzip("data/ucihardata.zip", exdir=".")
}

# 1. Merges the training and the test sets to create one data set

## training data
trainX <- read.table("UCI HAR Dataset/train/X_train.txt", comment.char="")
trainY <- read.table("UCI HAR Dataset/train/y_train.txt", col.names=c("activity"))
trainSub <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names=c("subject"))
trainData <- cbind(trainX,trainY,trainSub)

## test data
testX <- read.table("UCI HAR Dataset/test/X_test.txt", comment.char="")
testY <- read.table("UCI HAR Dataset/test/y_test.txt", col.names=c("activity"))
testSub <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names=c("subject"))
testData <- cbind(testX,testY,testSub)

hardata<-rbind(trainData,testData)

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 

## read features
feature_list <- read.table("UCI HAR Dataset/features.txt", col.names = c("id", "name"))
features <- c(as.vector(feature_list[, "name"]), "subject", "activity")

## filter only features that has mean and std in the name
filtered_feature_ids <- grepl("mean|std|subject|activity", features) & !grepl("meanFreq", features)
filtered_data <- hardata[, filtered_feature_ids]

#3. Uses descriptive activity names to name the activities in the data set

activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("id", "name"))
for (i in 1:nrow(activities)) {
  filtered_data$activity[filtered_data$activity == activities[i, "id"]] <- as.character(activities[i, "name"])
}

# 4. Appropriately labels the data set with descriptive variable names.

## make feature names more human readble
filtered_feature_names <- features[filtered_feature_ids]
filtered_feature_names <- gsub("\\(\\)", "", filtered_feature_names)
filtered_feature_names <- tolower(filtered_feature_names)
## assign names to features
names(filtered_data) <- filtered_feature_names


# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#use dplyr and tidyr to get tidy data set

tidy_data <- tbl_df(filtered_data) %>% group_by(subject, activity) %>% summarise_each(funs(mean)) %>% gather(measurement, mean, -activity, -subject)

# Save tidy data
write.table(tidy_data, file="tidy_data.txt", row.name=FALSE)
