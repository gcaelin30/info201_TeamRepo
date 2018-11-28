library(magrittr)
library(dplyr)
library(lubridate)

#change filepath to fit your computer
crime_data <- read.csv(file.path("C:", "Users", "dark_","Desktop", "info201", "info201_TeamRepo", "Crime_Data.csv"))

#uses lubridate to construct a Year Occurred column
data <- 
  crime_data %>% 
  mutate(Date.Occurred = mdy(Occurred.Date)) %>% 
  select(-Occurred.Time, -Occurred.Date) %>% 
  mutate(Year.Occurred = year(Date.Occurred))

#filters the data to just 2008-2018
filtered_data <- 
  data %>% 
  filter(Year.Occurred == '2008' | Year.Occurred == '2009' | Year.Occurred == '2010' | Year.Occurred == '2011' | Year.Occurred == '2012' | Year.Occurred == '2013' | Year.Occurred == '2014' | Year.Occurred == '2015' | Year.Occurred == '2016' | Year.Occurred == '2017' | Year.Occurred == '2018')
