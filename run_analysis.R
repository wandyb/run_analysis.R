# download link
fileUrl <-  "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile= "./zip.file", method = "curl")
file <- unzip("./zip.file")
unlink(fileUrl)

setwd("./UCI HAR Dataset")

# load libraries
library(plyr)

# load the different datasets
# load test datasets
xtest <- read.table("./test/X_test.txt", sep = "")
ytest <- read.table("./test/y_test.txt", sep = "")
subjecttest <- read.table("./test/subject_test.txt")
# load train datasets
xtrain <- read.table("./train/X_train.txt", sep = "")
ytrain <- read.table("./train/y_train.txt", sep = "")
subjecttrain <- read.table("./train/subject_train.txt", sep = "")

# load features
features <- read.table("./features.txt", sep = "")
# load THE activity labels WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
activitytypes <- read.table("./activity_labels.txt", colClasses = c("integer", "character"))

# 1. Merge the training and the test sets to create one data set
data <- rbind(xtrain, xtest)
        # add the columnnames of features
        colnames(data) <- as.character(features[ , 2])

# 2. Extract only the measurements on the mean and standard deviation for each measurement

# subset data, the new data frame meanstd only contains only the variables for mean and std 
meanstd  <- data[,grepl("mean()|std()", names(data))]

# 3. Use descriptive activity names to name the activities in the data set

        # merge the labels of test and train data, creates an integer vector
        labels <- rbind(ytrain, ytest)
        
        # merge the subject datasets of train and test
        allsubject <- rbind(subjecttrain, subjecttest)
        
        # rename colum V1 to "subject"
        colnames(allsubject) <- "subject" 
        
# 4. Appropriately labels the data set with descriptive variable names.

        # make new data frame df with labels and activity     
        df <- cbind(labels, meanstd)
        for(i in 1:length(df[ ,1])){
        df[i,1] <- activitytypes[df[i,1],2]
        }

        # merge activities and new df         
        all <- cbind(allsubject, df)
        # rename the fist two columns from in new df
        colnames(all)[1:2] <- c("subject", "activity")

# write data to file
write.table(all, file = "raw_data.txt")
print("Finished processing. The processed raw dataset is written to raw_data.txt.")
# 5. From the data set in step 4, create a second, independent tidy data set with the average of 
#    each variable for each activity and each subject.

tidy <- ddply(all, .(subject, activity), numcolwise(mean))
colnames(tidy)[3:ncol(tidy)] <- colnames(meanstd)

write.table(tidy, file = "tidy_data.txt")
print("Finished processing. The processed tidy dataset is written to tidy_data.txt.")

# remove unnessary variables to free memory
rm(xtest, ytest, subjecttest, xtrain, ytrain, subjecttrain, features, activitytypes)
print("Finished removing loaded data tables.")
