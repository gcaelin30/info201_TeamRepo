
library(dplyr)


# Author: Joshua Canton
#
# In this file I do all my data manipulation in order to pass it to the Shiny app to be visualized

source("../Filtered_data_range.R")
filtered_data <- filter_dates("../Crime_Data.csv") %>% 
  arrange(Year.Occurred)


x <- filtered_data %>% 
  filter(Year.Occurred == 2008) %>% 
  group_by(Year.Occurred, Crime.Subcategory) %>% 
  summarise(n = n()) %>% 
  arrange(-n)
