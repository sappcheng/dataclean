This repo contains the R script that can be used to clean up the UCI HAR DATA set to a tidy data set for further analysis.

## How the script works

Source the file in R using the following command and it will automatically download the dataset, perform the transformation, clean and tidy the data. The result is the tidy data file `tidy_data.txt`.

```R
source("run_analysis.R")
```


## Data CodeBook

The [codebook](CodeBook.md) included in this repo describes the variables, the data, the transformations that are done and the clean up that was performed on the data.
