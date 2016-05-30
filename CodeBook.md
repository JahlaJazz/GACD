
# CodeBook.md : Getting and Cleaning Data Course Project


### Purpose:
- Demostrate the ability to collect, work with and create a tidy data set

### Data Source
- info source:	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
- data source:	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Background information about the experiment 
The  following info was taken directly from the "readme.txt" file

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 	

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 										

### Data Files Used in Analysis
- activity_labels.txt : list of activities performed by each population particpant
- features.txt : list of names for observed value
- subject_test.txt and subject_train txt : identification label for each of the test/train particpants
- x_test.txt and x_train.txt : the observed values for each test/train participants
- y_test.txt and y_train.txt : the activities performs by each of the participant in the test/train group

### Nomenclature for the features is  : prefixSignal-Statistic-axials	
* 1. prefix used are t for time and f for frequency
     + a. Time signals : time domin signals were captured at a rate of 50 Hz and filters were applied to remove noise
     + b. Frequecny signals : was determined based upon a Fast Fourier Transform ( FFT )
* 2. Signal are derived from the Samsung Galaxy II smartphone   
     + a. Raw signals: The basis for the features come from the accelerometer and gyroscope 3-axial raw signals tAcc-xyz and tGyro-xyz
	      1.) the accelerometer provide information for acceleration signals ( tAcc-xyz)
	      2.) the gyroscope component provide information on angular velocity ( tGyro-xyz )
	      3.) tAcc-xyz was decomposed into linear body accelaration ( tBodyAcc-xyz) and gravity acceleration (tGravityAcc-xyz) signals
	   + b. Jerk  signals:  derived from linear accleration (tBody-xyz) and and angular velocity( tBodyGyro-xyz )
	   + c. Magnitude signal : the impact of the xyz signals was calculated using Euclidean norm
* 3. Statistic : these are standard statistical measures and are contained in the features-info.txt
* 4. axials denotes whether the measures are along a particular axial or not
 
### Label the data set with descriptive variable names	
-	replaced "t" and "f" prefixes with "Time" and "Frequency", respectively
-	replaced "Acc" and "Gyro" with "Accelerometer" and "Gyroscope", respectively
-	replaced "Mag" and "BodyBody" with "Magnitude" and "Body", respectively
-	replaced "-mean" and "-std" with "_Mean" and "_StdDev", respectively
-	replaced "-X" with "along x-axis"
-	replaced "-Y" with "along y-axis"
-	replaced "-Z" with "along z-axis"
-	replaced "()" with no space ""
-	used descriptive activity names for the various activity levels 1 - 6

### Main concepts in the transformation process	
1. Merging the test and train sample observations into one data set
2. Extracting the statistical variable of the mean and standard deviation for each applicable signal
3. Using descriptive labels for both the activity levels and the data set variable names
4. Create a tidy data set with the mean for the relevant signals, for each sample participant and activity level
	
### How the above was implemented in the script file (ie, run_analysis)	
* 1. Clean the workspace, set the working directory and load libraries ( dplyr, tidyr and reshape2 )
* 2. Manually download the zip file and unzipping in the working directory
* 3. Reading in the required files
      + activity levels and names
      + the attribute for each observation as reflected in the features file
      + the identification and activities of each participant in the test and train sample populations
      + the observed data for each participant in the test and train sample population
* 4. Created one dataset, based upon the files read in ( CombinedDataSet) ; this completes task 1
      + this completes task1 and the resulting object is named, CombinedDataSet
* 5. Extract only statistical measurement of the mean and standard deviation for each relevant signal
      + this completes task2 and the resulting object is named MiniCombinedDataSet
* 6. Used descriptive activity name for each activity level in the data set
      + this completes task3 
* 7. Labeled the data set with the descriptive variable labels, as reflected above
      + this completes task4
* 8. Created a tidy data set, named tidydata and printed the result to a file
      + at this point the process is complete



