
library(shiny)
library(dplyr)
library(ggplot2)

source("../Filtered_data_range.R")
filtered_data <- filter_dates("../Crime_Data.csv") %>% 
  arrange(Year.Occurred)


shinyServer(function(input, output) {
  
  output$year <- renderUI({
    selectInput(
      "year", 
      "year:",
      choices = unique(filtered_data$Year.Occurred))
  })
  
  output$neighborhood <- renderUI({
    selectInput(
      "neighborhood",
      "Neighborhood:",
      choices = unique(filtered_data$Neighborhood))
  })
  
  output$distPlot <- renderPlot({
    
    plot_data <- filter(filtered_data, filtered_data$Year.Occurred == input$year & filtered_data$Neighborhood == input$neighborhood)
    
    ggplot(plot_data, aes(plot_data$Crime.Subcategory, fill=Crime.Subcategory)) + geom_bar() + coord_flip() + guides(fill=FALSE)
  })
  
})
