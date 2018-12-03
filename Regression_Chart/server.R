#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$neighborhood <- renderUI({
    selectInput(
      "neighborhood",
      "Neighborhood:",
      choices = unique(barely_filtered_data$Neighborhood))
  })
  
  output$plot <- renderPlot({
    plot_data <- prep_by_neighborhood(input$neighborhood)

    ggplot(data = plot_data, aes(x=Month.Occurred, y=n, group =1)) +
      geom_line()+
      geom
    
  })
  
})
