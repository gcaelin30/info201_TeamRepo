library(magrittr)
library(dplyr)
library(lubridate)


#put your file path to the Crime_Data.csv into this function to filter it to the appropriate years of interest for this project
filter_dates <- function(file_path){

crime_data <- read.csv(file_path)  
  
#uses lubridate to construct a Year Occurred column
data <- 
  crime_data %>% 
  mutate(Date.Occurred = mdy(Occurred.Date)) %>% 
  select(-Occurred.Date) %>% 
  mutate(Year.Occurred = year(Date.Occurred))

#filters the data to just 2008-2018
filtered_data <- 
  data %>% 
  filter(Year.Occurred == '2008' | Year.Occurred == '2009' | Year.Occurred == '2010' | Year.Occurred == '2011' | Year.Occurred == '2012' | Year.Occurred == '2013' | Year.Occurred == '2014' | Year.Occurred == '2015' | Year.Occurred == '2016' | Year.Occurred == '2017' | Year.Occurred == '2018')
}

#SOURCE THIS FILE AND CALL THE filter_dates() FUNCTION IN YOUR FILE LIKE THIS EXAMPLE:
#source("Filtered_data_range.R")




