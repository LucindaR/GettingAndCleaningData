# project data source: 
#     https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#setwd("~/Coursera/GettingAndCleaningData/Data/UCI HAR Dataset/") 
# This code will:

# Merge the training and the test data together

    tmpTrain <- read.table("train/subject_train.txt")
    tmpTest <- read.table("test/subject_test.txt")
    S <- rbind(tmpTrain, tmpTest)

    tmpTrain <- read.table("train/X_train.txt")
    tmpTest <- read.table("test/X_test.txt")
    X <- rbind(tmpTrain, tmpTest)

    tmpTrain <- read.table("train/y_train.txt")
    tmpTest <- read.table("test/y_test.txt")
    Y <- rbind(tmpTrain, tmpTest)
    
# Extract the mean & st dev for each measurement
    features <- read.table("features.txt")
    indices_of_good_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
    X <- X[, indices_of_good_features]
    names(X) <- features[indices_of_good_features, 2]
    names(X) <- gsub("\\(|\\)", "", names(X))
    names(X) <- tolower(names(X))
    
# Use descriptive activity names to name the activities in the dataset
    activities <- read.table("activity_labels.txt")
    activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
    Y[,1] = activities[Y[,1], 2]
    names(Y) <- "activity"

# Label dataset with descriptive activity names
    names(S) <- "subject"
    cleaned <- cbind(S, Y, X)
    write.table(cleaned, "merged_clean_data.txt")

# Create a tidy dataset with the average of each variable for each activity and each subject
    uniqueSubjects = unique(S)[,1]
    numSubjects = length(unique(S)[,1])
    numActivities = length(activities[,1])
    numCols = dim(cleaned)[2]
    result = cleaned[1:(numSubjects*numActivities), ]
    row = 1
    for (s in 1:numSubjects) {
        for (a in 1:numActivities) {
        result[row, 1] = uniqueSubjects[s]
        result[row, 2] = activities[a, 2]
        tmp <- cleaned[cleaned$subject==s & cleaned$activity==activities[a, 2], ]
        result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
        row = row+1
        }
    }
write.table(result, "dataset_with_averages.txt", row.name=FALSE)