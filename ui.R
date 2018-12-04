library(shiny)
library(shinythemes)

shinyUI(navbarPage(theme=shinytheme("cerulean"),
                   "",
                   tabPanel("Summary",
                     mainPanel(
                       imageOutput("crime_pic"),
                       htmlOutput("report_summary")
                     )
                   ),
                #----Roy's UI------   
                 tabPanel("Highest Occuring",
                        fluidPage(
                          titlePanel(title= h1(" Seattle Crime", align = "center")),
                                 
                                 ## block of code creates " select year" drop down option 
                                 selectInput("year", label = h3("Select Year"), 
                                             choices = c("2008","2009","2010", "2011", "2012", "2013", "2014", "2015", "2016",
                                                         "2017", "2018") ,
                                             selected = "2008"),
                          mainPanel(
                            plotOutput("crime", width=750, height = 500),
                            htmlOutput("crime_summary")
                          ))),
                
                
                 #-----Josh's UI--------
                 tabPanel("By Neighborhood",
                    sidebarLayout(
                      sidebarPanel(
                        uiOutput("jyear"),
                        uiOutput("jneighborhood")
                      ),
                      mainPanel(
                        plotOutput("distPlot")
                      )
                    )
                 ),
                
                
                 #------Godgiven's UI------
                 tabPanel("Sex Crimes",
                          fluidPage(
                            
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
                                  label = ("Selected a Type of Crime"),
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
                                        style = "color:red;font-weight:bold;text-align:center")),
                                
                                # output of the plot
                                plotOutput("misdeeds_bar")
                              )
                              
                            )
                            )),
                 #-----Maxwell's UI------
                 tabPanel("Crime Over Time",

                            # Sidebar with a slider input for number of bins
                            sidebarLayout(
                              sidebarPanel(
                                uiOutput("neighborhood")
                              ),

                              # Show a plot of the generated distribution
                              mainPanel(
                                plotOutput("plot"),
                                htmlOutput("m_crime_summary")
                              )
                            )
                          ))

                        
  )
