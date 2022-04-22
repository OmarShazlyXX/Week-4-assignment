# Course Project Codebook
This is a codebook describing the final project of getting and cleaning data course, the run_analysis.R script 
is a code that downloads a data set and performs some cleaning to achieve a tidy data set and below are the steps done:
1) Downloading the data:
- The data is found in a zip format, so it will be downloaded and unzipped where it's called "UCI HAR Dataset"

2) Creating the data frames:
- features <- features.txt (561 rows, 2 columns)
features that come from acceloremeter and gyroscope 3 axial raw signals
- activities <- activity_labels.txt (6 rows, 2 columns)
List of activities performed and their corresponding code
- x_train <- train/X_train.txt (7352 rows, 561 columns)
the train data recorded features
- y_train <- train/y_train.txt (7352 rows, 1 column)
the train data of activities code
- subject_train <- train/subject_train.txt (7352 rows, 1 column)
contains train data of 21/30 volunteer subjects being observed
- x_test <- test/X_test.txt (2947 rows, 561 columns)
the test data recorded features
- y_test <- test/y_test.txt (2947 rows, 561 columns)
the test data of activities code
- subject_test <- test/subject_test.txt (2947 rows, 1 column)
contains test data of 9/30 volunteer test subjects being observed

3) Merging the test and training sets together:
- x_bind (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() 
- y_bind (10299 rows, 1 column) is created by merging y_train and y_test using rbind() 
- subject_bind (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() 
- binded (10299 rows, 563 columns) is created by merging binded, y_bind and x_bind using cbind() 

4) Converting to data table for dplyr operations:
- binded_df <- binded (10299 rows, 563 columns)

5) Selecting the mean and standard deviation readings only:
- binded_req (10299 rows, 88 columns) is created by subsetting binded_df,selecting only columns: subject, code, 
and the measurements on the mean and standard deviation (std) for each measurement

6) Uses descriptive activity names to name the activities in the data set:
- merged (10299 rows, 89 columns) entire numbers in code column of the binded_req is used to merge the corresponding
activity taken from second column of the activities variable

7) Appropriately labels the data set with descriptive variable names:
- All Acc in column’s name replaced by Accelerometer
- All Gyro in column’s name replaced by Gyroscope
- All BodyBody in column’s name replaced by Body
- All Mag in column’s name replaced by Magnitude
- All start with character f in colmn’s name replaced by Frequency
- All start with character t in column’s name replaced by Time
- All Freq in column’s name replaced by Frequency
- All std in column’s name replaced by STD
- All tbody in column’s name replaced by TimeBody

8) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each
activity and each subject:
- final (180 rows, 88 columns) is created by sumarizing TidyData taking the means of each variable for each activity and
each subject, after groupped by subject and activity.
- Export FinalData into final.txt file.
