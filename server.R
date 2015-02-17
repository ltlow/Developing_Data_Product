library(shiny)    #load shiny
#shiny server and input-output function
shinyServer(
  function(input, output) {
    output$x <- renderText(input$x)
    output$PredictedResult <- renderPrint({PredictedResult(input$x)})
    output$myplot <- renderPlot({Plot(input$x)}) })   

library(datasets)   #load dataset    
USPopData <- uspop

USPop <- data.frame(USPopData)  #reorganise dataset
names(USPop) <- c("Millions")
X <- 0:18
Year <- seq(1790,1970, 10)
USPop1 <- cbind(X, Year, USPop)

Y <- 19:30                    #create new dataset for prediction reference
Yr <- seq(1980,2090, 10)
PreUSPop <- data.frame(Y,Yr)

modelData <- lm(Millions~X, USPop1) #1st model

set.seed(1234)            #set seed for reproducibility

trainset = sample(1:15, replace = FALSE)  #separate data set into training and test sets
USPopTrain <- USPop1[trainset, ]
USPopTest <- USPop1[-trainset, ]

model1 <- lm(Millions~X, USPopTrain)  #2nd model from train set

predTest <- predict(model1, USPopTest, interval='prediction', level = .95 )  #on test set
round(predTest, 0)

#Prediction function
PredictedResult <- function (x) {
  z <- PreUSPop['Y'][PreUSPop$Yr==x, ]  #for prediction reference
  result <- coef(model1)[2]*z + coef(model1)[1]  #for prediction use
  result <- round(result, 0)
  result <- as.numeric(result)  
  result


}

#Plot function
Plot <- function (x) {

  z <- PreUSPop['Y'][PreUSPop$Yr==x, ]   #get data for the plot
  result <- coef(model1)[2]*z + coef(model1)[1]
  result1 <- round(result, 0)
  
  RevUSPop <- data.frame(z, x, result1)   #create new dataframe for result
  names(RevUSPop) <- c("X", "Year", "Millions")  #name the new dataframe
  RevUSPop1 <- rbind(RevUSPop, USPop1)    #rbind the new and old dataframes
  
  library(ggplot2)    #plot the graph
  ggplot(RevUSPop1, aes(x=X, y=Millions)) +  
    geom_point(shape=1) +    # Use hollow circles
    geom_smooth(method=lm,   # Add linear regression line
                se=FALSE)+    # Don't add shaded confidence region
    xlab("Year 20XX") +
    ylab("Number of Population (Millions)")
}



