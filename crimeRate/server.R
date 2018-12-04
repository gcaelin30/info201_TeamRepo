
library(shiny)
library(ggplot2)
library(dplyr)
library(magrittr)
library(plyr)
# sourcing the main function to work with our sorted data
source("../Filtered_data_range.R")

# Writing out logic here
server <- function(input, output) {
  
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
}
  

