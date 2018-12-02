data %>% 
  mutate(Month.Occurred = paste0(Year.Occurred,'.', month(Date.Occurred)) %>% 
  filter(Neighborhood == 'CAPITOL HILL') %>% 
  group_by(Year.Occurred) %>% group_by(Neighborhood, add = TRUE) %>% group_by(Month.Occurred, add = TRUE) %>% summarize(n()) %>% View()


cap_hill_data <- data %>%mutate(Month.Occurred = paste0(Year.Occurred,'.', month(Date.Occurred))) %>% 
  filter(Neighborhood == 'CAPITOL HILL') %>% 
  group_by(Month.Occurred) %>% summarize(n = n())


loessMod50 <- loess(n ~ Month.Occurred, data=cap_hill_data, span=0.10) # 50% smoothing span

linear_reg <- lm(n ~ Month.Occurred, data=cap_hill_data)

smoothed_linear <- predict(linear_reg)

smoothed50 <- predict(loessMod50) 


plot(cap_hill_data$n, x=cap_hill_data$Month.Occurred, type="l", main="Loess Smoothing and Prediction", xlab="Month", ylab="n_crimes")

lines(smoothed_linear, x=cap_hill_data$Month.Occurred, col="purple")

lines(smoothed50, x=cap_hill_data$Month.Occurred, col="blue")
