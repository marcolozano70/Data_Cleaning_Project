# Introduction to the Project of Marco Lozano

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers 
on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data 
set as described below, 2) a link to a Github repository with your script for performing the analysis, 
and 3) a code book that describes the variables, the data, and any transformations or work that you 
performed to clean up the data called CodeBook.md. You should also include a README.md in the repo 
with your scripts. This repo explains how all of the scripts work and how they are connected.

This project show how apply al concepts learned in this course of Getting & Cleaning, therefor this repository contains just one R script to merge and tidy data collected from an experiment 
that was collecting data from the accelerometers Samsung Galaxy S smartphones, the script's name is run_analisis.R

# Data source provided for this project was download from this web site

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Steps carried out to complete this project were:

1. Clone this repository
2. change the working directory to getting-cleaning-data-project/ folder
3. Download the data source zip file
4. Unzip the source zip file: `unzip getdata-projectfiles-UCI\ HAR\ Dataset.zip`
5. Run run_analysis.R

Corresponding commands are:

mkdir Data_Cleaning_Project
git clone https://github.com/marcolozano70/Data_Cleaning_Project
cd Data_Cleaning_Project
wget https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
unzip getdata-projectfiles-UCI\ HAR\ Dataset.zip
R run_analysis.R


# Output

run_analysis.R generates 2 files:
* tidy_data.txt: a space-delimited value file that contains mean and standard deviation for each measurements from the train and test data,
* average_data.txt: a space-delimited value file that contains tidy data set with the average of each variable for each activity and each subject

I used default params for write.table() so space-delimited, with column names, ... To read those files, use:


read.table('tidy_data.txt')
read.table('average_data')
