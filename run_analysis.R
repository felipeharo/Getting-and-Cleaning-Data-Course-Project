# this function reads the samsung data, cleans the data and writes a new file with
# the average values for the mean and standard deviation measurements
# the function requires to have the "UCI HAR Dataset" folder with all the raw data
# in the same directory as this file (this directory beeing the working directory)

run_analysis<-function(){
  library(data.table)
  library(plyr)
  library(dplyr)
  
  # start reading all the files we care about
  # base files
  activity_labels<-fread("UCI HAR Dataset/activity_labels.txt")
  features<-fread("UCI HAR Dataset/features.txt")
  # train files
  subject_train<-fread("UCI HAR Dataset/train/subject_train.txt")
  X_train<-as.data.table(read.table("UCI HAR Dataset/train/X_train.txt"))
  Y_train<-fread("UCI HAR Dataset/train/y_train.txt")
  # test files
  subject_test<-fread("UCI HAR Dataset/test/subject_test.txt")
  X_test<-as.data.table(read.table("UCI HAR Dataset/test/X_test.txt"))
  Y_test<-fread("UCI HAR Dataset/test/y_test.txt")
  
  # Adding a column to identify subject and activity
  X_test[,subject:=subject_test]
  X_test[,activity:=Y_test]
  X_train[,subject:=subject_train]
  X_train[,activity:=Y_train]
  
  # 1. Merges the training and the test sets to create one data set.
  data<-rbind(X_train,X_test)
  
  
  
  # 2. Extracts only the measurements on the mean and standard deviation for each measurement.
  setnames(data,names(data)[1:561],features$V2)
  data<-cbind(select(data,contains("mean()")), select(data,contains("std()")),select(data,contains("subject")),select(data,contains("activity")))
  
  # 3. Uses descriptive activity names to name the activities in the data set
  data$activity<-as.factor(data$activity)
  data$activity<-revalue(data$activity, c("1"="WALKING", "2"="WALKING_UPSTAIRS", "3"="WALKING_DOWNSTAIRS", "4"="SITTING", "5"="STANDING", "6"="LAYING"))
  
  
  # 4. Appropriately labels the data set with descriptive variable names
  aux<-gsub("-", "_", names(data)[1:dim(data)[2]])
  aux<-gsub("log(", "", aux, fixed="TRUE")
  aux<-gsub("(", "", aux, fixed="TRUE")
  aux<-gsub(")","",aux)
  setnames(data,names(data)[1:68],aux) 
  
  # 5. creates data set with the average of each variable for each activity and each subject.
  data2<-data %>%
    group_by(subject,activity) %>%
    summarise_each(funs(mean)) 

  # write the final table
  write.table(data2,file="tidy_data.txt",row.name=FALSE)
}

