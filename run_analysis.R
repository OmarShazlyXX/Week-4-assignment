if(!file.exists("data.zip")){
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "data.zip", method = "curl")}
if(!file.exists("UCI HAR Dataset")){
unzip("data.zip")}
library(dplyr)
features <- read.table("UCI HAR Dataset/features.txt",
                       col.names = c("n","cfeatures"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt",
                         col.names = c("n","activity"))
x_train <- read.table("UCI HAR Dataset/train/X_train.txt",
                      col.names = features$cfeatures)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt",
                      col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",
                            col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt",
                     col.names = features$cfeatures)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", 
                     col.names = "code")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",
                           col.names = "subject")
x_bind <- rbind(x_test, x_train)
y_bind <- rbind(y_test, y_train)
subject_bind <- rbind(subject_test, subject_train)
binded <- cbind(x_bind, y_bind, subject_bind)
binded_df <- tbl_df(binded)
binded_req <- select(binded_df, subject, code, contains("mean"), contains("std"))
merged <- merge(binded_req, activities, by.x = "code", by.y = "n", all = TRUE)
merged <- relocate(merged, activity, .after = code)
names(merged) <- gsub("Acc", "Accelerometer", names(merged))
names(merged) <- gsub("Gyro", "Gyroscope", names(merged))
names(merged) <- gsub("Mag", "Magnitude", names(merged))
names(merged) <- gsub("Freq", "Frequency", names(merged))
names(merged) <- gsub("BodyBody", "Body", names(merged))
names(merged) <- gsub("std", "STD", names(merged))
names(merged) <- gsub("^t", "Time", names(merged))
names(merged) <- gsub("^f", "Frequency", names(merged))
names(merged) <- gsub("tbody", "TimeBody", names(merged))
final <- group_by(merged, activity, subject) %>%
summarise_all(mean)
write.table(final, file = "final.txt",row.name = FALSE,col.names = TRUE)