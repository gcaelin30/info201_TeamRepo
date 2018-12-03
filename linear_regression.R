#SOURCE THIS FILE AND CALL THE filter_dates() FUNCTION IN YOUR FILE LIKE THIS EXAMPLE:

source("Filtered_data_range.R")
library('Deriv')

?Deriv
data <- filter_dates("C:/Users/dark_/Desktop/info201_TeamRepo/Crime_Data.csv")

#data %>% 
#  mutate(Month.Occurred = paste0(Year.Occurred,'.', month(Date.Occurred)) %>% 
#  filter(Neighborhood == 'CAPITOL HILL') %>% 
 # group_by(Year.Occurred) %>% group_by(Neighborhood, add = TRUE) %>% group_by(Month.Occurred, add = TRUE) %>% summarize(n()) %>% View()


cap_hill_data <- data %>%mutate(Month.Occurred = paste0(Year.Occurred,'.', month(Date.Occurred))) %>% 
  filter(Neighborhood == 'CAPITOL HILL') %>% 
  group_by(Month.Occurred) %>% summarize(n = n()) %>% mutate("x_value" = row_number())



View(cap_hill_data)
loessMod50 <- loess(n ~ Month.Occurred, data=cap_hill_data, span=0.10) # 50% smoothing span
smoothed50 <- predict(loessMod50) 

linear_reg <- lm(n ~ x_value, data=cap_hill_data)
View(linear_reg)


smoothed_linear <- predict(linear_reg)
View(smoothed_linear)
plot(cap_hill_data$n, x=cap_hill_data$Month.Occurred, type="l", main="Loess Smoothing and Prediction", xlab="Month", ylab="n_crimes")

lines(smoothed_linear, x=cap_hill_data$Month.Occurred, col="purple")

lines(smoothed50, x=cap_hill_data$Month.Occurred, col="blue")
