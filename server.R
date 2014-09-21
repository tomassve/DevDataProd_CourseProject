library(shiny)


# Define server logic
shinyServer(function(input, output) {

  # - - - Reactive expressions
  getRegressionModel <- reactive({
    lm(getFormula() , mtcars)
  })
  
  getFormula <- reactive({
    if (is.null(input$predictors)) {
      fo <- mpg ~ 1
    }
    else if ("no intercept" %in% input$predictors) {
      fo <- formula(paste("mpg ~", paste(input$predictors[-1], collapse = "+"), "- 1"))
    }
    else {
      fo <- formula(paste("mpg ~", paste(input$predictors, collapse = "+")))
    }
    fo
  })
  # - - - -
  
  # - - - Plots
  output$regPlot <- renderPlot({
    par(mfrow = c(1,2))
    res <- resid(getRegressionModel())
    fit <- fitted(getRegressionModel())
    with(mtcars,plot(mpg, ylim=range(mpg, res, fit), col="black",
         ylab = "Miles per Gallon"))
    points(fit, col="red")
    legend("bottomright", c("mpg","prediction"), bty = "n",
           col=c("black","red"), pch=c(1,1))
    plot(res, ylab="Residuals", ylim=range(mtcars$mpg, res, fit))
    par(mfrow = c(1,1))
  })
  
  output$pairsPlot <- renderPlot({
    pairs(mtcars)
  })
   
  output$diagPlots <- renderPlot({
    par(mfrow = c(2,2))
    plot(getRegressionModel())
    par(mfrow = c(1,1))
  })
  # - - - -
  
  # - - - Prints
  # Generate a summary of the model
  output$model <- renderPrint({
    print(getFormula(), showEnv = FALSE)
  })
  
  output$model1 <- renderPrint({
    print(getFormula(), showEnv = FALSE)
  })
  
  output$summary <- renderPrint({
    summary(getRegressionModel())
  })
  # - - - -
  
  
  # - - - Tables
  # Generate an HTML table view of the data
  output$table <- renderTable({
    mtcars
  })
  # - - - -
  
})
