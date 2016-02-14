#Code Book Getting and Cleaning Data Project Data 

Source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The R code (run_analysis.R):
    Merges the training and test datasets; reads features.txt and extracts the mean and standard deviation for each measurement; reads activity_labels.txt and applies descriptive activity names to the activities in the dataset:

    walking

    walkingupstairs

    walkingdownstairs

    sitting

    standing

    laying
;
 labels the data set with descriptive names (feature names (attributes) and activity names are converted to lower case, underscores and brackets () are removed). The code creates a "clean" dataset (merged_clean_data.txt). The code creates a tidy dataset (dataset_with_averages.txt).
