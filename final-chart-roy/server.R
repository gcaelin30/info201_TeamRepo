library(shiny)
library(dplyr)
library(ggplot2)
library(lubridate)
library(rsconnect)


source("../Filtered_data_range.R")

sever <- function(input, output) {

filtered_data <- filter_dates("../Crime_Data.csv")

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
 
HTML(paste(text1,sep = "<br/><br/>"))
})

}
