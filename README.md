getting_and_cleaning_data
=========================

coursera course getting_and_cleaning_data week 3 course project

as instructed, the run_analysis() function is create. all the getting and cleaning data steps are placed inside this function.

Step 1 Merges the training and the test sets to create one data set
==========================================================================
First the read the following files respectively

features.txt           > 561 rows    (the 561 types of features)
activity_labels.txt    > 6 rows 	    (the 6 types of activity)

train\subject_train.txt> 7352 rows 	(identifier of the subject who carried out the experiment, range is from 1 to 30)
train\x_train 		      > 7352 rows 	(the features data, 561 columns as we have 561 types of features)
train\y_train 		      > 7352 rows 	(the 6 types of activity)

test\subject_test.txt 	> 2947 rows
test\x_test 		        > 2947 rows
test\y_test 		        > 2947 rows

The inertial signals are not used and thus ignored

Step 2 Extracts only the measurements on the mean and standard deviation for each measurement
===============================================================================================================
In the x_train and x_test data frame, only the column of 1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,345,346,347,348,349,350,424,425,426,427,428,429,503,504,516,517,529,530,542,543 are used


Step 3 Uses descriptive activity names to name the activities in the data set
===============================================================================================================
Use the content from the activity_labels.txt and merge it with y_train and y_test data frame by the id V1 and activity_code
  y_train <- merge(y_train, activity_labels, by.x = "V1", by.y = "activity_code")
  y_test  <- merge(y_test,  activity_labels, by.x = "V1", by.y = "activity_code")


Step 4 Appropriately labels the data set with descriptive variable names.
===============================================================================================================
Use the content from the features.txt as the name of the columns of x_train and x_test data frame


Step 5 Creates a second, independent tidy data set with the average of each variable for each activity and each subject
===============================================================================================================
To obtain the average of each variable for each activity and each subject, first melt the resultant data frame from step 2 by subject_identifier+activity_code+activity_desc, then dcast the molten data frame.
 
