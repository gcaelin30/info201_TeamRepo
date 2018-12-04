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

    ggplot() +
      geom_line(data = plot_data , aes(x = Month.Occurred, y = n, group = 1)) +
      geom_line(data = regressed_line(plot_data), aes(x = Month.Occurred, y = regressed_values, group = 1), col = 'red') +
      theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
      labs(
        title = 'Crimes Committed and Regression Plot',
        x = "Date in Months from 2008-2018",
        y = 'Number of Crimes Per Month')
    
      
  })
  
  output$crime_summary <- renderUI({
    slope <- regression_info(prep_by_neighborhood(input$neighborhood))

    text1 <- paste0( "<div align=center><br/><b>What Data does this Line Plot Represent</b></div><br/>",
                     "The black line plots the number of crime occurences per month. The red line represents a linear
                     regression of the same data. For this Neighborhood, the slope of the regressed line is </b>",
                     round(as.numeric(slope$coef[2]),2), "<b><br/>")
    
    HTML(paste(text1,sep = "<br/><br/>"))
  })
  
  
})


#plot_data <- prep_by_neighborhood('CAPITOL HILL')
#regression_for_plotting(plot_data) %>% View()
