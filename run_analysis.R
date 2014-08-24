run_analysis<-function(){
  
  #1 Merges the training and the test sets to create one data set.
  #2 Extracts only the measurements on the mean and standard deviation for each measurement.
  #3 Uses descriptive activity names to name the activities in the data set
  #4 Appropriately labels the data set with descriptive variable names.
  #5 Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
  #features.txt           > 561 rows    (the 561 types of features)
  #activity_labels.txt    > 6 rows 	    (the 6 types of activity)
  #
  #train\subject_train.txt> 7352 rows 	(identifier of the subject who carried out the experiment, range is from 1 to 30)
  #train\x_train 		      > 7352 rows 	(the features data, 561 columns as we have 561 types of features)
  #train\y_train 		      > 7352 rows 	(the 6 types of activity)
  #train\inertial signals	> 7352 rows 	(128 values per row as 128 readings/window) (not used, just ignore this dataset)
  #
  #test\subject_test.txt 	> 2947 rows
  #test\x_test 		        > 2947 rows
  #test\y_test 		        > 2947 rows
  #test\inertial signals 	> 2947 rows
  #
  
  ###############################################################
  # 1 read from UCI HAR Dataset\test train
  if (!exists("activity_labels")){
    activity_labels<-read.table('UCI HAR Dataset\\activity_labels.txt');
    names(activity_labels)<-c("activity_code", "activity_name");
  }
  if (!exists("features")){
    features<-read.table('UCI HAR Dataset\\features.txt');
    names(features)<-c("features_code", "features_name");
  }
  ###############################################################
  if (!exists("subject_train")){
    subject_train<-read.table('UCI HAR Dataset\\train\\subject_train.txt');
    names(subject_train)<-c("subject_identifier");
  }
  if (!exists("x_train")){
    x_train<-read.table('UCI HAR Dataset\\train\\x_train.txt');
    #step 4 Appropriately labels the data set with descriptive variable names.
    names(x_train)<-features[,2];
    #step 2 Extracts only the measurements on the mean and standard deviation for each measurement.
    x_train<-x_train[,c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,345,346,347,348,349,350,424,425,426,427,428,429,503,504,516,517,529,530,542,543)] 
  }
  if (!exists("y_train")){
    y_train<-read.table('UCI HAR Dataset\\train\\y_train.txt');
    #step 3 Uses descriptive activity names to name the activities in the data set
    y_train <- merge(y_train, activity_labels, by.x = "V1", by.y = "activity_code")
    names(y_train)<-c("activity_code", "activity_desc");
  }
  
  if (!exists("subject_test")){
    subject_test<-read.table('UCI HAR Dataset\\test\\subject_test.txt');
    names(subject_test)<-c("subject_identifier");
  }
  if (!exists("x_test")){
    x_test<-read.table('UCI HAR Dataset\\test\\x_test.txt');
    #step 4 Appropriately labels the data set with descriptive variable names.
    names(x_test)<-features[,2];
    #step 2 Extracts only the measurements on the mean and standard deviation for each measurement.
    x_test<-x_test[,c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,345,346,347,348,349,350,424,425,426,427,428,429,503,504,516,517,529,530,542,543)]
  }
  if (!exists("y_test")){
    y_test<-read.table('UCI HAR Dataset\\test\\y_test.txt');
    #step 3 Uses descriptive activity names to name the activities in the data set
    y_test <- merge(y_test, activity_labels, by.x = "V1", by.y = "activity_code")
    names(y_test)<-c("activity_code", "activity_desc");
  }
  
  ###############################################################
  if (!exists("BigTable")){
    BigTable1<-cbind(subject_test, y_test, x_test);
    BigTable2<-cbind(subject_train, y_train, x_train);
    BigTable<-rbind(BigTable1, BigTable2);
    BigTable1<-NULL;
    BigTable2<-NULL;
  }  
  BigTable
}

#step 5
library(reshape2)
BigTable_Melt <- melt(BigTable,id=c("subject_identifier", "activity_code", "activity_desc"))
head(BigTable_Melt)
tail(BigTable_Melt)
result <- dcast(BigTable_Melt, subject_identifier+activity_code+activity_desc~variable, mean)
write.table(result, file="step5result.txt",row.name=FALSE)
