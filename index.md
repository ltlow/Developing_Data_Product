---
title       : Developing Data Products
subtitle    : The Predictor of US Population
author      : 
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

##  About "The Predictor of US Population""

The Predictor of US Population is a shiny apps designed to predict the population size in the United States based on the dataset 'uspop' provided in R. The dataset gives the population of the United States (in millions) recorded by the  decennial census for the period 1790-1970. 

The application can be accessed by following link: 

https://r14327.shinyapps.io/The_Predictor_of_US_Population/


##  How to use it?

Choose a year in the drop-down menu to predict the US population size for the year and the result will be displayed.  To see the graph, click on the "Graphic" tab.

Note that the years are set in 10-year interval from 2020 to 2090 for the prediction.

Eg. To predict the population size for year 2020, simply select 2020 in the drop-down menu and the result will be shown, then click on the plot tab to view the graph.





--- .class #id

##  How it is built?

The full codes in server.r and ui.r can be obtained from the github with the following link:

https://github.com/14327/Developing_Data_Product

The main program:

```r
  library(datasets)     #load dataset
  USPopData <- uspop
  USPop <- data.frame(USPopData)  #re-organise dataset
  names(USPop) <- c("Millions") 
  X <- 0:18                     
  Year <- seq(1790,1970, 10)
  USPop1 <- cbind(X, Year, USPop)
  Y <- 22:30                      #create new dataset for prediction reference
  Yr <- seq(2010,2090, 10)
  PreUSPop <- data.frame(Y,Yr)
  modelData <- lm(Millions~X, USPop1)  #1st model
```

--- .class #id


```r
  x=2020
  
  set.seed(1234)        #set seed for reproducibility
  
  trainset = sample(1:15, replace = FALSE)  #separate data set into training and test sets
  USPopTrain <- USPop1[trainset, ]
  USPopTest <- USPop1[-trainset, ]
  
  model1 <- lm(Millions~X, USPopTrain)  #2nd model from train set
  
  predTest <- predict(model1, USPopTest, interval='prediction', level = .95 ) #on test set
  
  z <- PreUSPop['Y'][PreUSPop$Yr==x, ] #for reference

  result <- coef(model1)[2]*z + coef(model1)[1]    #for prediction use
  result1 <- round(result, 0)
  result1
```

```
##   X 
## 179
```



--- .class #id

##  Summary

The Predictor of US Population is an app designed to predict the population size for the United States. It is  based on the dataset provided in R for the period from 1790 to 1970.

It may be more accurate in the prediction if the dataset can be refreshed with more recent data.




