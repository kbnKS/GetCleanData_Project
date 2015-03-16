# Getting and Cleaning Data - Course Project

# set working directory to the folder, where the data is
setwd("*path to your working directory here")


## STEP 1 - merge two datasets

#load datasets
testdata <- read.table("X_test.txt")
traindata <- read.table("X_train.txt")


# load vector with feature names (soon to be variable names)
features <- read.table("features.txt")
features <- as.character(features[, 2])

# assign feature-names as column-names to datasets
names(testdata) <- features
names(traindata) <- features
rm(features)


# add "ids" of subjects
testid <- read.table("subject_test.txt")
testdata <- cbind(testid, testdata)
names(testdata)[1] <- "id"
trainid <- read.table("subject_train.txt")
traindata <- cbind(trainid, traindata)
names(traindata)[1] <- "id"
rm(testid, trainid)


# add activity classes
testactivity <- read.table("y_test.txt")
testdata <- cbind(testdata, testactivity)
names(testdata)[563] <- "activity"
trainactivity <- read.table("y_train.txt")
traindata <- cbind(traindata, trainactivity)
names(traindata)[563] <- "activity"
rm(testactivity, trainactivity)


# merge the two datasets
combined <- rbind(testdata, traindata)
rm(testdata, traindata)


## STEP 2 - extract subset of values of interest

# find columns we are interested in
meanc <- grep("mean()", names(combined), fixed = TRUE)
stdc <- grep("std()", names(combined), fixed = TRUE)

# generate subset
subset <- combined[, c(1, 563, meanc, stdc)]

rm(combined, meanc, stdc)


## STEP 3 - use descriptive activity names

# activity names are found in the "activity_labels.txt" file

subset$activity
class(subset$activity)


# save activity variable as a factor with descriptive names
subset$activity <- factor(subset$activity,
                          levels = c(1:6),
                          labels = c("Walking",
                                     "Walking_up",
                                     "Walking_down",
                                     "Sitting",
                                     "Standing",
                                     "Laying"))


## STEP 4 - assign descriptive names to variables

names(subset)
# already done in step 1


## STEP 5 - create new subset with means for each activity/subject

library(plyr)

final <- ddply(subset, .(id, activity),
               colwise(mean))


## Completion

# Export final data set

write.table(final,
            file = "projectdata.txt",
            row.names = FALSE)


# Descriptive variable information

library(Hmisc)

describe(final)
