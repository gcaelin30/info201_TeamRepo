library(shiny)

ui <- fluidRow(
  titlePanel(title= h1(" Seattle Crime", align = "center")),
  column(3,

      ## block of code creates " select year" drop down option 
      selectInput("year", label = h3("Select Year"), 
                  choices = c("2010", "2011", "2012", "2013", "2014", "2015", "2016",
                              "2017", "2018") ,
                  selected = "2016")
    ),
    
    mainPanel(
      plotOutput("crime"),        #height = 780, width  = 980 ),
      htmlOutput("crime_summary")
    )
  )






























#ui <- fluidPage(
 # titlePanel(title= h1(" Seattle Crime", align = "center")),
  #sidebarLayout(
   # sidebarPanel(
    
    ## block of code creates " select shape " drop down option 
    #selectInput("year", label = h3("Select Year"), 
     #           choices = c("2010", "2011", "2012", "2013", "2014", "2015", "2016",
      #                      "2017", "2018") ,
       #         selected = "2016")
#  ),
  
  
  
  #mainPanel(
   # plotOutput("crime", height = 400, width  = 1000 )
  #)

#)
#)
    
    