library(shiny)

shinyUI
(fluidPage(
# Application title
titlePanel(title = "The Predictor of US Population"),
sidebarLayout(
      sidebarPanel(

  p("Information: This application is using R dataset 'uspop' with the population of the United States (in millions) as recorded in the decennial census for the period 1790-1970."),
  br(),
  p("Please click on 'Year of Prediction', follow by 'Submit' button."),
  br(),
  p("Click on 'Numeric' to show the numerical prediction, and click on 'Graphic' to show the graphical prediction."),
  br(),
  
  selectInput("x", "Year of Prediction", c("2020", "2030", "2040", "2050", "2060", "2070","2080", "2090"), selected="2020"),

  submitButton('Submit')
  

                   ),


 mainPanel(

  tabsetPanel(type="tab",
              
              tabPanel("Graphic", plotOutput("myplot")),              
              
              tabPanel("Numeric",
                       ("Year entered:"),
                       verbatimTextOutput("x"),
                       
              ("Predicted size of US population for year x (millions):"),
              verbatimTextOutput("PredictedResult"))
              

              ) 
          ) 

            )
        )
)
