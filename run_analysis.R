library(plyr)
##download file
if(!file.exists("./data")){dir.create("./data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file(fileUrl,destfile = "./data/dataset.zip", method="curl")

install.packages("downloader")
library(downloader)
unzip("./data/dataset.zip", exdir ="./data")



##read files 
activityDesc <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header = FALSE, col.names = c("ActivityID", "ActivityName"))
selectedFeatures <- read.table("./data/UCI HAR Dataset/features.txt", header = FALSE)

subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE, col.names = c("SubjectID"))
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE, col.names = selectedFeatures[,2])
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE, col.names = c("ActivityID"))

subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE, col.names = c("SubjectID"))
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE, col.names = selectedFeatures[,2])
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE, col.names = c("ActivityID"))



mergeTrainData <- cbind(subject_train,y_train,x_train)
mergeTestData<- cbind(subject_test,y_test,x_test)

mergeData <- rbind(mergeTestData,mergeTrainData)



##Extracts only the measurements on the mean and standard deviation for each measurement
mean_std_Features <- grep("mean()|std()",names(mergeData))

mean_std_dataset_with_meanfreq <- mergeData[,c(1,2,mean_std_Features)] ##still contains cols with meanfreq. needs to be removed
##head(mean_std_dataset_with_meanfreq,1)

mean_std_dataset <- mean_std_dataset_with_meanfreq [,!grepl("Freq",names(mean_std_dataset_with_meanfreq))]

## Uses descriptive activity names to name the activities in the data set
merged_mean_std_dataset <- merge(mean_std_dataset,activityDesc,by="ActivityID");str(merged_mean_std_dataset)

##head(merged_mean_std_dataset[merged_mean_std_dataset$SubjectID==1 & merged_mean_std_dataset$ActivityID==1,])

##creates a second, independent tidy data set with the average of each variable for each activity and each subject.
theDataSet <- ddply(merged_mean_std_dataset,c("SubjectID", "ActivityID"),function(x) colMeans(x[,3:68]))

#theDataSet[theDataSet$SubjectID==1,] ; str(theDataSet)

write.table(theDataSet,"./data/tidyDataSet.txt", row.names = FALSE, quote = FALSE)


