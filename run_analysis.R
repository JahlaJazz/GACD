## Purpose for this script is to complete the following tasks:
## Task1. Merges the training and the test sets to create one data set.
## Task2.Extracts only the measurements on the mean and standard deviation for each measurement. 
## Task3.Uses descriptive activity names to name the activities in the data set
## Task4.Appropriately labels the data set with descriptive variable names. 
## Task5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Initial setup ; clean worksheet, set working directory, retrieve the data sets and upzip locally
rm(list=ls())                  # clean workspace
setwd("C:/AAA/gacd")            # set working directory
library(dplyr); library(tidyr) ; library(reshape2)   

## manually downloaded and unzipped in the working directory
## get a listing of the files in the unzipped folder
datafolder <- "UCI HAR Dataset"

unzippedfiles <- list.files(paste0(getwd(),"/", datafolder), recursive=TRUE) # list of all files provided
filestouse <- unzippedfiles[ c(1:2, 14:16, 26:28) ]  # listing of the file relevant for this project

# read the activities files ; 6 acivity levels
ActivityLevels <- read.csv(paste0(getwd(),"/", datafolder, "/", filestouse[1]), header = FALSE, sep = " ", col.names = c("ActivityId", "ActivityName"))

# read the features colnames  
Features <- read.csv(paste0(getwd(),"/", datafolder, "/", filestouse[2]), header = FALSE, sep = " ", col.names = c("FeatureId", "FeatureName"))
 
# the population of 30 participate was divided into two subpopulations ( test = 30% and train = 70%)
# read the activities performed by the test population
ActivityTest <- read.csv(paste0(getwd(),"/", datafolder, "/", filestouse[5]), header = FALSE, sep = " ", col.names = "ActivityId")

# read the activities performed by the train population
ActivityTrain <- read.csv(paste0(getwd(),"/", datafolder, "/", filestouse[8]), header = FALSE, sep = " ", col.names = "ActivityId")
 
# read in the id label for the test population
SubjectTestId <- read.csv(paste0(getwd(),"/", datafolder, "/", filestouse[3]), header = FALSE, sep = " ", col.names = "SubjectId")

#read in the id label for the training population
SubjectTrainId <- read.csv(paste0(getwd(),"/", datafolder, "/", filestouse[6]), header = FALSE, sep = " ", col.names = "SubjectId")

# read in the feature data for the test population
TestData <- read.table(paste0(getwd(),"/", datafolder, "/", filestouse[4]), header = FALSE, stringsAsFactors = FALSE, col.names = Features$FeatureName)

# read in the feature data for the training population
TrainData <- read.table(paste0(getwd(),"/", datafolder, "/", filestouse[7]), header = FALSE, stringsAsFactors = FALSE, col.names = Features$FeatureName)

#####   Task1 <=> Create one Data set

CombinedDataSet  <- rbind(cbind(SubjectTestId, ActivityTest, TestData),cbind(SubjectTrainId, ActivityTrain, TrainData))

##### Task2 <=>  Extracts only the measurements on the mean and standard deviation for each measurement. <=> "MiniCombinedDataSet"

findex <- grep("mean\\()|std\\()",Features[,2]) # index from Features object
fnames <- as.character(Features[findex,2])  # corresponding character names  
sindex <- c( 1, 2, (findex+2))
snames <- c("SubjectId", "ActivityId", fnames)

MiniCombinedDataSet <- select(CombinedDataSet, sindex)

##### Task3 <=> Uses descriptive activity names to name the activities in the data set

MiniCombinedDataSet$ActivityId <- ActivityLevels[MiniCombinedDataSet$ActivityId,2]

##### Task4 <=> Appropriately labels the data set with descriptive variable names. 

snames <- gsub("^t","Time",snames)
snames <- gsub("^f","Frequency",snames)
snames <- gsub("Acc","Accelerometer",snames)
snames <- gsub("Gyro","Gyroscope",snames)
snames <- gsub("Mag","Magnitude",snames)
snames <- gsub("BodyBody","Body",snames)
snames <- gsub("-mean","_Mean",snames) 
snames <- gsub("-std","_StdDev",snames) 
snames <- gsub("-X"," along x-axis",snames)
snames <- gsub("-Y"," along y-axis",snames)
snames <- gsub("-Z"," along z-axis",snames)
snames <- gsub("[()]","",snames)
colnames(MiniCombinedDataSet) <- snames

##### Task5 <=> From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
datamelt <- melt(MiniCombinedDataSet, id = snames[1:2], measure.vars = snames[3:68])
tidydata <- dcast(datamelt, SubjectId + ActivityId ~ variable, mean)
#write.csv(tidydata,"tidydata.csv")
write.table(tidydata,"tidydata.txt", row.names = FALSE)

   