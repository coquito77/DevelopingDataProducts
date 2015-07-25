library(shiny)
library(RCurl)
library(ggplot2)
library(tidyr)
library(dplyr)
library(scales)

## Get the data

setwd("C:/Users/E551910/Desktop/DevelopingDataProducts/DevelopingDataProducts/")

dataset <-  read.csv(file="./data/summarydata.txt", sep="\t",head=TRUE)

dataset$EntityName <- as.character(dataset$EntityName)

title <- "Wage earnings for California counties in 2013"

## Define UI for application that plots random distributions

shinyUI(pageWithSidebar(
  
  ## Application title
  headerPanel(title),
  
  ## Sidebar with a slider input for number of observations
  
  sidebarPanel (
    
    selectInput('x','County Name', unique(dataset$EntityName)),
    "Deparment with the highest median wage",
    h1(textOutput("highestWageDept")),

    "Highest median wage",
    h1(textOutput("highestWage")),
    
    "Deparment with the highest median overtime wage",
    h1(textOutput("highestOTWageDept")),
    
    "Highest median overtime wage",
    h1(textOutput("HighestOTWage"))

    
  ),
  
  ## Show a plot of the generated distribution
  
  
  mainPanel(plotOutput("counts",height="700px"))
  
  
)

)