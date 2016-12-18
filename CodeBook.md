#Introduction

##After loading the necessary packages-which will be used to execute the script-, the script `run_analysis.R` performs the steps given below.,
* Firstly, the working directory is checked for the data-set, necessary to perform the cleaning and reshaping of data.
* If the dataset is present, then it is loaded into the workspace. However, if the data-set is absent then it is downloaded from the specified source-url-and then loaded into the working environment of R studio.
* To load the datasets in the from of unique variables, the script performs loading and merging the datasets, together.
* Three variables-`x,y,subject_dat`-are initialized. Then a character vector,`a` which has two values ie., `train` and `test` is created. This character vector is used to initialize a `for` loop. Inside the `for` loop, first, the name of the files in the subfolder(s) `test` and `train` is read, then the corresponding label and feature data-of that subfolder-is read. Each is assigned a variable names.
* To load the three primary datasets i.e. `x,y,subject-_dat`, three different for loops are used-within the primary loop. The search function, `grepl` is used for loop iteration.
* Using `cbind` function, the three primary data sets are merged together.
* Concecutively, using `merge` function, the binded datasets are merged with the label-data by using the activity number-present in both, the label data and the subject data.
* Following these steps, using the `select` function, and passing `grepl` as its search-string-argument, the columns with mean and standard deviation are extracted and formed into a new separate dataset. However lable and subject columns are also selected.
* Then `aggregate` is used to aggregate or arrange the mean values of each column, first by activity name, and then by subject number.
* Finally, using `write.table`, the final dataset is written into a .txt format file.

#Variables

##Apart from the variables specified above, the program uses the following instance variables.
* The variables used to store the file names, label data and the feature data are `FileNames`,`FeatureDat`,`LabelDat`.
* `MergedData` is the variable used to represent the complete dataset with all the given data.
* `MergedDataAct` is a variable representing the complete dataset with each activity named, by using the activity number present in `MergedData` and `LableDat`.
* `MeanStdMergedDat` is the penultimate dataset which is made by extracting the mean, standard deviation, activity name and the subject number from `MergedDataAct` dataset, by using `select` function as described previously.
* Finally, `AvgByActAndSub`-the required dataset- is obtained using the `aggregate` function.
* Lastly this dataset is written to a seperate file which is named as `Tidy.txt`.