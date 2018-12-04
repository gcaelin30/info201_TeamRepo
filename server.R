
library(shiny)
library(dplyr)
library(ggplot2)
library(shinythemes)


source("Filtered_data_range.R")



shinyServer(function(input, output) {  
  
  output$report_summary <- renderUI({
    HTML("This report was designed to serve as a tool to promote awareness",
         "and facilitate safe decision making in regards to crime trends in Seattle, Washington.<br/><br/>",
         
         "The dataset we utilized was published by the Seattle Police Department, and contains data about reported crimes",
         "over a variety of categories. We specifically focused on the time period ranging from 2008-2018, and", 
         "filtered the data accordingly.<br/><br/>",
         
         "The questions we are examining are as follows:<br/><br/>",
         
         "<ul><li>What is the highest occuring crime for a certain year?</li><br/>",
         "<li>What is the frequency of different crime categories in a certain neighborhood, in a certain year?</li><br/>",
         "<li>What is the pervasiveness of the various sexual assault crimes in Seattle during the years 2008-2018?</li><br/>",
         "<li>Where has the crime rate increased in the city since 2008?</li></ul><br/><br/>")
  })
  
#---------------Roy's code below---------------------------------

  
  filtered_data <- filter_dates("Crime_Data.csv")
  
  output$crime <- renderPlot({
    filtered_data  %>%
      filter(Year.Occurred == input$year) %>%
      group_by(Year.Occurred, Crime.Subcategory) %>%
      summarise(n = n()) %>%
      rename(total_crime = n) %>%
      ggplot(aes(x = Crime.Subcategory,y= total_crime , fill = Crime.Subcategory))+
      geom_bar(stat = "identity")+
      theme(axis.text.x = element_text(angle = 30, hjust = 1))+
      geom_text(aes(label=total_crime))+
      guides(fill=FALSE)+
      labs(title = paste0("Crime in Seattle for the year ", input$year))
  })   
  
  output$crime_summary <- renderUI({
    
    max_year <- filtered_data %>%
      filter(Year.Occurred == input$year) %>%
      summarise(n = n()) 
    
    max_crime <- filtered_data %>%
      filter(Year.Occurred == input$year) %>%
      group_by(Year.Occurred, Crime.Subcategory) %>%
      summarise(n = n()) %>%
      arrange(-n)
    
    low_crime <- filtered_data %>%
      filter(Year.Occurred == input$year) %>%
      group_by(Year.Occurred, Crime.Subcategory) %>%
      summarise(n = n()) %>%
      arrange(n)
    
    text1 <- paste0( "<div align=center><br/><b>What Questions does this data set answer</b></div><br/>",
                     "<b>What is the total number of crimes recored in the year</b> ",input$year,"<br/>",
                     max_year, "<br/><br/>",
                     "<b>What is the highest crime recorded in the year</b> ",input$year,"<br/>",
                     max_crime[[1,2]], "<br/><br/>",
                     "<b>What is the occurrences</b><br/>",
                     max_crime[[1,3]], "<br/><br/>",
                     "<b>What is the lowest crime recored in the year</b> ", input$year, "<br/>",
                     low_crime[[1,2]], "<br/><br/>", 
                     "<b>What is the occureences</b><br/>",
                     low_crime[[1,3]], "<br/>")
  
    
    HTML(paste(text1 ,sep = "<br/><br/>"))
    
  })
    
#---------------Godgiven's code below----------------------------
  
  # this will be my changing text output that corresponds
  # 
  output$Quick_Summary <- renderText({
    
    # I put it in a variable to make it easier and less redundant
    # there are multiple types of sexually related crimes, however, they just lumped em all
    # under 'sex offense' and 'aggrivated assault'
    print_this <-  paste("The crime you selected was",
                         input$crime
    )
    
  })
  
  # This plot is to render the output
  output$misdeeds_bar <- renderPlot({
    
    # one of my teammates to on the task of filtering the data so that we only had
    # 2008-2018 to sort through
    # we did this because there was already so much data dating back decades, and we decided that
    # those data points were irrelevant
    filtered_crime <- filter_dates("./Crime_Data.csv")
    
    # this is to filter specifically just the sex related crimes
    sex_crimes <- filter(filtered_crime, Crime.Subcategory == "AGGRAVATED ASSAULT" |
                           Crime.Subcategory == "AGGRAVATED ASSAULT-DV" |
                           Crime.Subcategory == "PORNOGRAPHY" |
                           Crime.Subcategory =="PROSTITUTION" |
                           Crime.Subcategory == "RAPE" |
                           Crime.Subcategory =="SEX OFFENSE-OTHER") 
    
    # this is so I can use it in the ggplot
    crime_plot <- filter(sex_crimes, sex_crimes$Crime.Subcategory==input$crime)
    
    
    #plot the data here
    ggplot(crime_plot)+
      geom_bar(mapping = aes(Year.Occurred), fill = "purple", color = "black")+
      labs(title = "Bar Graph of Types of Sexual Misconduct Cases through the years") +
      labs(x = "Years", y = "Number of Cases") +
      theme_classic()
    
    
  })
  
#---------------Maxwell's code below-----------------------------
  
  barely_filtered_data <- filter_dates("Crime_Data.csv") %>% manipulate_date()
  
  manipulate_date <- function(data) {
    x <- data %>%
      mutate(Month.Occurred = paste0(Year.Occurred,'.', month(Date.Occurred)))
  }
  
  prep_for_plotting <- function(data) {
    x <- 
      data %>% 
      group_by(Month.Occurred) %>% 
      summarize(n = n()) %>% 
      mutate("x_value" = row_number())
  }
  
  regressed_line <- function(data) {
    x <- data %>% 
      mutate('regressed_values' = predict(regression_info(data)))
  }
  
  regression_info <- function(data){
    x <- lm(n ~ data$x_value, data = data)
  }
  
  
  prep_by_neighborhood <- function(neighborhood){
    x <- 
      barely_filtered_data %>%
      filter(Neighborhood == neighborhood) %>% 
      prep_for_plotting()
  }
  

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

  output$m_crime_summary <- renderUI({
    slope <- regression_info(prep_by_neighborhood(input$neighborhood))

    text1m <- paste0( "<div align=center><br/><b>What Data does this Line Plot Represent</b></div><br/>",
                     "The black line plots the number of crime occurences per month. The red line represents a linear
                     regression of the same data. For this Neighborhood, the slope of the regressed line is </b>",
                     round(as.numeric(slope$coef[2]),2), "<b><br/>")

    HTML(paste(text1m,sep = "<br/><br/>"))
  })
  
#---------------Josh's code below--------------------------------
  
  filt_data <- filter_dates("Crime_Data.csv") %>% 
      arrange(Year.Occurred)
    
  output$jyear <- renderUI({
    selectInput(
      "jyear", 
      "year:",
      choices = unique(filt_data$Year.Occurred))
  })
  
  output$jneighborhood <- renderUI({
    selectInput(
      "jneighborhood",
      "Neighborhood:",
      choices = unique(filt_data$Neighborhood))
  })
  
  output$distPlot <- renderPlot({
    
    plot_data <- filter(filt_data, filt_data$Year.Occurred == input$jyear & filt_data$Neighborhood == input$jneighborhood)
    ggplot(plot_data, aes(plot_data$Crime.Subcategory, fill=Crime.Subcategory)) + 
      geom_bar() + 
      coord_flip() + 
      guides(fill=FALSE) + 
      xlab("") +
      ylab("Occurences")
    
  })
  
  
})