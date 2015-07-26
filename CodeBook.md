CodeBook for Tidy UCI HAR Dataset
=================================

## What does it do?

This CodeBook describes the data contained in the output of the `run_analysis.R` script contained in this repository and the tidy text file can be read using `data.table` to create a data table for further analysis.

```R
tidy_data <- data.table("tidy_data.txt")
```

The script creates a tidy, condensed version of the University of California Irvine's (UCI's) dataset for Human Activity Recognition (HAR) using smartphones that can be used for further research and analysis. 

It generates a combined subset of the original data by extracting the mean and standard deviation features for each of the 33 processed signals, for a total of 66 features (out of the 561 available features from the original feature vector). This combined subset contains 10299 observations of 68 variables, with activity and subject appended to the 66 features.

The combined subset is further reduced by calculating the mean of the observations by activity and subject pair to generate 180 observations (6 activities * 30 subjects) of the same 68 variables. This dataset is tidied to generate a narrow and lean dataset containing 11880 observations with 4 variables each and is saved as a text file in the current working directory with the name `tidy_data.txt`

## Variable name cleanup

As part of the _tidying_ process the variable names are cleaned up using the following transformations and finally all variable names are converted into lowercase.

```R
filtered_feature_names <- gsub("\\(\\)", "", filtered_feature_names)
filtered_feature_names <- tolower(filtered_feature_names)
```


## Description of the UCI HAR variables

The Tidy dataset consists of 11880 observations summarized by activity (6 categories) and subject (30 volunteers) pairs. For each observation (row) in the Tidy dataset, the following 4 columns are provided:

- subject
- activity
- measurement
- mean

### subject

A numeric identifier (1-30) of the subject who carried out the experiment.

### activity

The activity name with the following possible values.
- 'laying',
- 'sitting',
- 'standing',
- 'walking',
- 'walking_downstairs'
- 'walking_upstairs'

### measurement

The name of the measurement for which the mean is calculated. Please refer the codebook with the original dataset for the explanation of these different variables.


### mean

The mean of the measurements.
