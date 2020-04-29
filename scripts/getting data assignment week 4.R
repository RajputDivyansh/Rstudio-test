library(reshape2)

filename <- "getdata_dataset.zip"

## Download and unzip the dataset
if(!file.exists(filename)) {
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, filename,method = "curl")
}

if(!file.exist("UCI HAR Dataset")) {
    unzip(filename)
}


##Load activity labels + features
activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])


##Extract only the data on mean and standard deviation
features <- read.table("./data/UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2]) 
featuresWanted <- grep("-(mean|std).*",features[,2])
featuresWanted.names <- features[featuresWanted,2]
featuresWanted.names <- gsub("-mean","Mean",featuresWanted.names)
featuresWanted.names <- gsub("mean","Mean",featuresWanted.names)
featuresWanted.names <- gsub("[()-]","",featuresWanted.names)


##Load the datasets
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")[featuresWanted]
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
train <- cbind(subject_train,y_train,x_train)


x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")[featuresWanted]
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
test <- cbind(subject_test,y_test,x_test)


##merge datasets and add label
data <- rbind(train,test)
colnames(data) <- c("subject","activity",featuresWanted.names)


##turn activities & subjects into factors
data$activity <- factor(data$activity,levels = activityLabels[,1], labels = activityLabels[,2])
data$subject <- as.factor(data$subject)

data.melted <- melt(data, id = c("subject","activity"))
data.mean <- dcast(data.melted, subject + activity ~ variable, mean)

write.table(data.mean,"tidy.txt",row.names = FALSE, quote = FALSE)