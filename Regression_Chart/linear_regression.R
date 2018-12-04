#SOURCE THIS FILE AND CALL THE filter_dates() FUNCTION IN YOUR FILE LIKE THIS EXAMPLE:

manipulate_date <- function(data) {
  x <- data %>%
    mutate(Month.Occurred = paste0(Year.Occurred,'.', month(Date.Occurred)))
}

source("../Filtered_data_range.R")
barely_filtered_data <- filter_dates("C:/Users/dark_/Desktop/info201/info201_TeamRepo/Crime_Data.csv") %>% manipulate_date()


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
