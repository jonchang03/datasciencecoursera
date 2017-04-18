#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

celsius <- function(fahrenheit) (fahrenheit - 32) * (5/9)


shinyServer( function(input, output) {
    output$inputValue <- renderPrint({input$fahrenheit})
    output$prediction <- renderPrint({celsius(input$fahrenheit)})
})