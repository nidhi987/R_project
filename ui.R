
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

ui <- fluidPage( 
  
  fluidRow(
    column(width = 12, 
           navbarPage(title = "DataAnalytics", 
                      tabPanel("Home", style = "background-color: #e6e6ff",  
                               fluidRow(
                                 column(width = 3, offset = 5, 
                                        img(src="R_LOGO.png", height = 175, width = 300)
                                 )),
                               fluidRow(              
                                 column(width = 8, offset = 2, style = "font-size: 18px; text-align: center; font-family: Lato; padding-top: 15px; padding-bottom: 15px",
                                        h3("This analytical application provide analytical view of college Finance, college Marketing, College Students data in the Graphical Form.")
                                 )),
                               fluidRow(
                                 column(width = 10, offset = 2,
                                        img(src="R_ANALYSIS.png", height = 300, width = 900))
                               )),
                      tabPanel("Analysis",  fluidRow(style = "background-color: #e6e6ff",
                                                     column(width = 3, offset = 5, 
                                                            img(src="R_LOGO.png", height = 100, width = 300)
                                                     )), 
                                      hr(),
                               
                               
                               
                               fluidRow(style = "background-color: #e6e6ff", column(width = 12, offset = 1, h3(textOutput("caption")), uiOutput("plot"))
                               ),
                               hr(),
                               fluidRow(style = "background-image:R_LOGO.png; margin-bottom: 20px; color: #1C84B4; margin-top: 20px; margin-right: 0;
                                        margin-left: 0;", width = 10,
                                        column(3, wellPanel(
                                          selectInput("dataset","Data:", 
                                                      list(Marketing = "Marketing", Finance = "Finance", StudentData = "StudentData")
                                          )
                                        )),
                                        
                                        column(3,  wellPanel(
                                          # This outputs the dynamic UI component
                                          uiOutput("variable")
                                        )),
                                        
                                        column(3,  wellPanel(
                                          # This outputs the dynamic UI component
                                          uiOutput("group")
                                        )),
                                        
                                        
                                        column(3, wellPanel(
                                          selectInput("plot.type","Plot Type:", 
                                                      list( histogram = "histogram", density = "density", bar = "bar", freqpoly = "freqpoly", dotplot = "dotplot", area = "area")
                                          )
                                        ))
                                        
                               ),
                               hr(),
                               
                               fluidRow(style = "backgraound-color:orange", column(width = 12, h2("ANALYTICAL DATA TABLE"), DT::dataTableOutput("ex2")))
                      ))
                      )))
  


