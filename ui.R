library(shiny)

# Define UI 
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Prediction of the fuel consumption in the mtcars data set"),
  
  # Sidebar with controls to select the predictors in the regression model
  sidebarLayout(
    sidebarPanel(      
      checkboxGroupInput("predictors", label = h4("Predictors"), 
                         choices = list("no intercept", "cyl", "disp", "hp", "drat", "wt", 
                                        "qsec", "vs", "am", "gear", "carb"),
                         selected = "cyl"),
      br(),
      br(),
      br(),
      br(),
      p("Course Project, Developing Data Products, John Hopkins, 2014"),


      p(em("Documentation:",a("MPG prediction",href="index.html")))
    ),
    
    # Define tabset
    mainPanel(
      tabsetPanel(type = "tabs", selected = "Data set",
                  tabPanel("Data set", h4("Motor Trend Car Road Tests"),
                           p("The data was extracted from the 1974", tags$i("Motor Trend US"), 
                             "magazine, and comprises fuel consumption and 10 aspects 
                                     of automobile design and performance for 32 automobiles 
                                     (1973-–74 models)." ),
                           tableOutput("table")),
                  tabPanel("Pairs plot", 
                           p("Below is a matrix of scatterplots that can be used 
                                              to explore correlation between predictors and ",
                             tags$i("mpg")),                 
                           plotOutput("pairsPlot")), 
                  tabPanel("Prediction plot", 
                           h4("Model"), verbatimTextOutput("model1"),
                           plotOutput("regPlot")), 
                  tabPanel("Model summary", 
                           h4("Model"), verbatimTextOutput("model"),
                           br(), 
                           verbatimTextOutput("summary")), 
                  tabPanel("Diagnostic plots", plotOutput("diagPlots"))
                  
      )
    )
  )
))
 
