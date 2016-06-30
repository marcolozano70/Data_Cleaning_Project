## Program name: run_analisis.R
## Course: Getting and Cleaning -- Coursera
## Objetives to reach:

### 1. Merges the training and the test sets to create one data set.
### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
### 3. Uses descriptive activity names to name the activities in the data set
### 4. Appropriately labels the data set with descriptive activity names.
### 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## check if the "data.table" package is installed
if (!require("data.table")) {
  install.packages("data.table")
}

## check if the "reshape2" package is installed
if (!require("reshape2")) {
  install.packages("reshape2")
}

## charge the packages into memory
require("data.table")
require("reshape2")

# change me if needed - this folder is created when unzipping data source into the repo
dataFolder = "UCI HAR Dataset/"

getFilePath <- function(filepath) {
  paste(dataFolder, filepath, sep="")
  
}

# First: Merge training and the test files: 
# - X
# - Y
# - subject

XTrain <- read.table(getFilePath("train/X_train.txt"))
XTest <- read.table(getFilePath("test/X_test.txt"))
XData <- rbind(XTrain, XTest)

# to optimize memory clean vars that are no longer required
rm(XTrain, XTest)

YTrain <- read.table(getFilePath("train/y_train.txt"))
YTest <- read.table(getFilePath("test/y_test.txt"))
YData <- rbind(YTrain, YTest)

# to optimize memory clean vars that are no longer required
rm(YTrain, YTest)

subjectTrain <- read.table(getFilePath("train/subject_train.txt"))
subjectTest <- read.table(getFilePath("test/subject_test.txt"))
DataOrigin <- rbind(subjectTrain, subjectTest)

# to optimize memory clean vars that are no longer required
rm(subjectTrain, subjectTest)

# #2: We should only keep mean and standard deviation for each measurement.

features <- read.table(getFilePath("features.txt"))
keptMesurePositions <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
XData <- XData[, keptMesurePositions]

# we set and clean column names
names(XData) <- features[keptMesurePositions, 2]

# we remove unwanted characters from column names
names(XData) <- gsub("\\(|\\)", "", names(XData))
names(XData) <- tolower(names(XData))

# th sane I to cleanup no longer required variables
rm(keptMesurePositions, features)

# #3: have a descriptive activity column, based on activity_labels.txt
activityLabels <- read.table(getFilePath("activity_labels.txt"))

# clean activity names (one line this time!)
activityLabels[, 2] = gsub("_", "", tolower(as.character(activityLabels[, 2])))
YData[,1] = activityLabels[YData[,1], 2]

# name that new column
names(YData) <- "activity"

# label DataOrigin
names(DataOrigin) <- "subjectnumber"

# Then: Time to merge everthing together and save into a file: XData, YData, DataOrigin
# I write the out put to a file.txt

merged <- cbind(DataOrigin, YData, XData)
write.table(merged, "tidy_data.txt")

# #5: "Creates a 2nd data set with the average of each variable for each activity and each subject."

subjects <- unique(DataOrigin)[,1]
nbSubjects <- length(subjects)
nbActivities <- length(activityLabels[,1])
nbCols <- dim(merged)[2]
result <- merged[1:(nbSubjects*nbActivities), ]

# Now try to use functional programming functions (apply...)
row = 1
for (s in 1:nbSubjects) {
  for (a in 1:nbActivities) {
    result[row, 1] = subjects[s]
    result[row, 2] = activityLabels[a, 2]
    tmp <- merged[merged$subject==s & merged$activity==activityLabels[a, 2], ]
    result[row, 3:nbCols] <- colMeans(tmp[, 3:nbCols])
    row = row+1
  }
}
write.table(result, "average_data.txt")
