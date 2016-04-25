library(shiny)

shinyUI(
  
  fluidPage(
    
      h3("Prediction Capstone Project"),
      h6("Written by Noah Hughes"),
      h6("April 25th, 2015"),
      textInput("mytext", "Input goes here"),
      textInput("myresults", "Best guess", "Initial value")
    )
)