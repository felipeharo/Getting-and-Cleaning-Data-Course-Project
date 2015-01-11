READ ME
==============================

## Content
This repository contains:  
- **codebook.pdf**: The codebook containing the explanation for all the variables present in tidy_data.txt  
- **tidy_data.txt**: The dataset which is a result of the data processing and cleaning. This is the output file of run_analysis.R  
- **run_analysis.R**: an R file containing a function that reads the raw data, clean it and process it. The output of this function is a file named tidy_data.txt which contains the tidy data.  

## Preparing your working directory
To be able to use run_analysis.R you need to clone this repository or download that file into your computer. You will also need to download the raw data. You can download the raw data in the following link:  
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)  
The zip file containing the raw data contains a folder called "UCI HAR Dataset". the run_analysis.R file and the unzipped folder with that exact name must be in the same directory for the function to work. Be sure to make that directory the working directory in RStudio or RConsole to avoid errors. This is done using the setwd() function.

## Running the function
To use the function you will need to install 3 R packages. You can do this with the following code:
```
# Required packages. 
install.packages("data.table")  
install.packages("plyr")  
install.packages("dplyr")  
```
Once you have the folder and run_analysis.R in the same folder and set up your working directory if needed, you must source the function to be able to run run_analysis(). This function will load the required packages for you.    
This function will read all the raw data and output a file called "tidy_data.txt". You can read that data by doing the following 
```
tidy_data<-read.table("tidy_data.txt",header=TRUE)
```
You can use the tidy_data variable to check how amazingly tidy the data is, following all the principles of tidy data.  

ENJOY!!!