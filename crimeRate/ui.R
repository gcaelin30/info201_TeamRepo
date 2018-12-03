ui <- fluidPage(
  
  # the title summarize the point of the histogram, which is to show the highest type of sexual
  # misdeed of that certain year.
  # this is to learn whether a certain type of sexual related crime was higher or lower in that year
  titlePanel("Select a Year to View the Highest Type of Sexual Related
             Crime of That Year"),
  sidebarLayout(
    
    # this is my side panel
    sidebarPanel(
      
      # this one is a drop down of the specific years to choose from
      
      selectInput(
        "crime",
        label = h3("Selected a Type of Crime"),
        choices = list("Aggravated Assault" = "AGGRAVATED ASSAULT",
                       "Domestic Violence"= "AGGRAVATED ASSAULT-DV",
                       "Pornography" = "PORNOGRAPHY",
                       "Prostitution"="PROSTITUTION",
                       "Rape"= "RAPE",
                       "Other Sex Offense" ="SEX OFFENSE-OTHER"), 
        selected = "Aggravated Assault")
    ),
    
    # this is my main manel where my histogram will plot out
    mainPanel(
      
      # textoutput here, made the font bigger by using h3
      # changed font color to purple
      # weighted font in bold
      # text aligned to center
      h3(span(textOutput("Quick_Summary"), 
              style = "color:purple;font-weight:bold;text-align:center")),
      
      # output of the plot
      plotOutput("misdeeds_bar")
    )
    
  )
)