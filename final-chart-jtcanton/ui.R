

library(shiny)


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Most frequent types of crime by year in Seattle neighborhood"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      uiOutput("year"),
      uiOutput("neighborhood")
      ),
    
    # Show a plot of the generated distribution
   mainPanel(
     plotOutput("distPlot")
    )
  )
))
