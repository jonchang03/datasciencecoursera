#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(
    pageWithSidebar(
        # Application title
        headerPanel("Convert Fahrenheit to Celsius"),
        sidebarPanel(
            numericInput('fahrenheit', 'degrees Fahrenheit', 0, min = 0, max = 220, step = 1),
            submitButton('Submit')
        ),
        mainPanel(
            h3('Result of conversion'),
            h4('You entered:'),
            verbatimTextOutput("inputValue"),
            h4('Which resulted in the following degrees Celsius:'),
            verbatimTextOutput("prediction")
        ) )
)
