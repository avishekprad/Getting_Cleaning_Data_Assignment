# CodeBook 
## Avishek

##Variables
- the datasets are downloaded into the variables activityDesc, selectedFeatures, subject_test, x_test, y_test,
  subject_train, x_train,y_train.
- The mergeTrainData variable combines the training data under one variable by binding subject_train,y_train,x_train variables.
- The mergeTestData variable combines the training data under one variable by binding subject_tese,y_test,x_test variables. 
-mergeData combines mergeTrainData and mergeTestData


Extracting the required columns
- mean_std_Features includes only those columns which have a mean or a std. this is used to subset mergeData
- mean_std_dataset_with_meanfreq is a subset of mergeData and includes only the mean and std measurements. This is achieved by using the grep function. However columns which have a *meanFreq* are also included. They need to be removed.
- mean_std_dataset does not contain columns with 'meanFreq'

Use descriptive activity names
- The activity data set (activityDesc) is merged with mean_std_dataset using column ActivityID as the common column
- This dataset is saved as merged_mean_std_dataset

Tidy set
-Using ddply function the average of the measurement columns ( with mean() or std() ) is calculated.
-The result dataset is saved under 'theDataSet'
- theDataSet is then written to an external .txt file