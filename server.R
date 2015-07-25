library(shiny)
library(ggplot2)

setwd("C:/Users/E551910/Desktop/DevelopingDataProducts/DevelopingDataProducts/")

dataset <-  read.csv(file="./summarydata.txt", sep="\t",head=TRUE)
dataset$EntityName <- as.character(dataset$EntityName)
dataset$DepartmentSubdivision <- as.character(dataset$DepartmentSubdivision)

# calc the mean overtime and mean total wage for all conties and depts

meanOTMedian <- mean(dataset$medianOT, na.rm = TRUE)

meanTotWageMedian <- mean(dataset$medianTotalPay, na.rm = TRUE)


## Define server logic required to generate and plot a random distribution
shinyServer(function(input,output) {
      
  set <- reactive({
    subset(dataset, EntityName == input$x)
  })
  
  output$counts <- renderPlot({
    set <-     subset(dataset, EntityName == input$x)
    ggplot(set, aes(medianOT, medianTotalPay, label= DepartmentSubdivision, size = count)) +
      geom_vline(xintercept = meanOTMedian, color = "red") + 
      geom_hline(yintercept = meanTotWageMedian, color = "blue" ) +
      annotate("text", label = paste("Average of median state overtime is ", 
                                     prettyNum(round(meanOTMedian,0), 
                                               big.mark=","), 
                                     "USD in 2013", sep = " "), 
               x = meanOTMedian, y = 150, 
               hjust=0, vjust=1.10, angle = 90, size = 4, colour = "red") +
      annotate("text", label = paste("Average of median state total wage is ", 
                                     prettyNum(round(meanTotWageMedian,0), 
                                               big.mark=","),
                                     "USD in 2013", sep = " "), 
               x = 150, y = meanTotWageMedian, 
               hjust=0, vjust=1.10, angle = 0, size = 4, colour = "blue") +
      geom_point( shape=21) +
      theme_minimal() +
      geom_text(aes(), size= 4, hjust=0, vjust=0) +
      scale_y_continuous("Median total pay (log scale)", 
                         trans=log_trans(), 
                         breaks=c(500,1000,5000,10000,25000,50000,
                                  100000,200000,300000,
                                  400000,480000,560000),
                         labels = dollar) +
      scale_x_continuous("Median overtime (log scale)", 
                         trans=log_trans(), 
                         breaks=c(100,500,1000,5000,10000,25000,
                                  50000,100000), 
                         labels = dollar) +
      theme(legend.position="bottom")
    
    
  })

  output$highestWageDept <- renderText({
    set()$DepartmentSubdivision[which.max(set()$medianTotalPay)]
    
  })
  
  output$highestWage <- renderText({
    paste0(prettyNum(set()$medianTotalPay[which.max(set()$medianTotalPay)],big.mark=",")," USD")
  })
  
  output$highestOTWageDept <- renderText({
    set()$DepartmentSubdivision[which.max(set()$medianOT)]
    
  })
  
  output$HighestOTWage <- renderText({
    paste0(prettyNum(set()$medianOT[which.max(set()$medianOT)],big.mark=",")," USD")  
    
  })
  
})