I first download the data set and unzip the files.
I import the X,Y, and subjext tables for both the training and testing data set.
I import the features table to assign the appropriate column names to the x data set
By referencing the feature files, I can subset the desired columns of the two x data sets (only keeping means and standard deviations).
I use cbind to combine the x,y and subject tables for both training and testing sets.
This creates Utrain and Utest.

I split both of these based on Activity and replace the numbers with the descriptive activity names (Walking, etc.)
This produces the NUTrain and NUTest data frames which are appropriately named.
I use rbind on NUTrain and NUTest and reorder by subject number to create a unified data.frame called "together"
Step 5 is all that remains.

I split the data by subject, and then again by activity to create a matrix of 180 data.frames accounting for every possible combination of subject and activity.
I use one for loop to take all the column means for every combination and another to get the subject and activity names.
I did this separately, because I couldn't apply colMeans to the non-numeric activities.
I used cbind to combine this into one tidy data.frame (called "tidy") with 180 rows describing the mean measurements for every subject and activity combination
