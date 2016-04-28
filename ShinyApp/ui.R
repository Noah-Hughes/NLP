library(shiny)
library(markdown)

shinyUI(
  
  fluidPage(
    theme = "bootstrap.css",
    title = "Prediction Capstone Project",
    titlePanel(
      h1("Prediction Capstone Project")
      
    ),
    h6("Written by Noah Hughes"),
    h6("April 25th, 2015"),
      
    tabsetPanel(
      
      tabPanel("Application",
               sidebarPanel(
      textInput("mytext", "Predict current word and with a space at end predict the next word"),
      img(src="images.jpeg", height = 233, width = 216)),
      
      
      
      mainPanel(
      h3(htmlOutput("myresults")))
      ),
      tabPanel("Getting started", 
               includeMarkdown("README.md")
      )
             
    )
)
)