# Getting and Cleaning Data - Course Project/Read me-file

Notes:

* The original datasets should be located in your working directory.

* The following R packages should be installed on your local computer and are loaded during the script:
	* plyr
	* Hmisc

* The final tidy dataset ("projectdata.txt") can be loaded in R via:
data <- read.table("projectdata.txt", header = TRUE)

## STEP 1 - merge two datasets

### Prepare datasets

1. load datasets with read.table()
2. load the "features"-vector which later will serve as variable names; save as object of class "character"
3. now the feature-vector can be assigned as variable names
4. the ID's are saved in the "subject_test/train"-files; load these and create a new column called "id" in each dataset (train and test) which contains the respective ID's
5. similar to the ID's the activities are saved in additional files, starting with "y_"; load these and create new columns in the datasets containing the respective activities

### Merge datasets

The two datasets (testdata and traindata) now have the exactly same columns (id, activity and a number of measures).

Combine these datasets via rbind().

## STEP 2 - extract subset of values of interest

Not all of the measures are of interest, we want only those containing mean and standard deviation measures. In the "features_info.txt" we can see that these variables contain the exact characters "mean()" and alternatively "std()". The grep()-function allows us to find only those variables containing "mean()" or "std"().

We want only these variables plus the ID (column 1) and activity (column 563).

## STEP 3 - use descriptive activity names

Until now the activity-column only contains numbers. With help of the "acitivity_label.txt"-file we can attribute descriptive labels to these numbers.

Therefor we save the activity-variable as a factor and assign labels to the six levels.

## STEP 4 - assign descriptive names to variables

We have already done this as part of the data preparation in Step 1.

## STEP 5 - create new subset with means for each activity/subject

Use plyr to calculate the mean of each variable grouped by each subject and the respective activity.

## Completion

Use write.table() to export the final dataset as txt-file.

As stated in the beginning the final dataset can be loaded in R via:
data <- read.table("projectdata.txt", header = TRUE)

Use describe() (Hmisc-package required) to generate basic descriptive information about all variables.