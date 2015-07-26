library(shiny)
library(RCurl)
library(ggplot2)
library(tidyr)
library(dplyr)
library(scales)

## This code loads in the data. the data is in the data file

# setwd("C:/Users/E551910/Desktop/DevelopingDataProducts/DevelopingDataProducts/")

dataset <-  read.csv(file="./data/summarydata.txt", sep="\t",head=TRUE)

dataset$EntityName <- as.character(dataset$EntityName)
dataset$DepartmentSubdivision <- as.character(dataset$DepartmentSubdivision)
