# Getting and Cleaning Data Project Assignment

Repo for the submission of the course project for the Coursera Getting and Cleaning Data course.

## Overview

This project serves to demonstrate the collection and cleaning of a tidy data set that can be used for subsequent analysis.

You can find information about the data in CodeBook.md.

The data are downloaded from the following source:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The code run_analysis.R will download the data from the web, process the data and generate two separate text files named "raw_data.txt" and "tidy_data.txt". The "tidy_data.txt" represents a subset of "raw_data.txt", with the average of each variable for each activity and each subject from the raw data.

## Project Summary

The The following is a summary description of the project instructions: 
1. Merging the training and the test sets to create one data set.
2. Extracting only the measurements on the mean and standard deviation for each measurement.
3. Using descriptive activity names to name the activities in the data set.
4. Appropriately labeling of the data set with descriptive variable names.
5. Creating a second, independent tidy data set, from the data in step 4, with the average of each variable for each activity and each subject.

## Required R Packages

The R package plyr is required to run this script. This maybe installed with,

install.package("pylr")
