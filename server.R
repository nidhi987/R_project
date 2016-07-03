library(shiny)
library(ggplot2)
library(DT)
library(datasets)
myData1 <- read.csv("E:/RStudio/final8/Data/Marketing.csv")
myData2 <- read.csv("E:/RStudio/final8/Data/Finance.csv")
myData3 <- read.csv("E:/RStudio/final8/Data/StudentData.csv")

Finance <- myData2
Marketing <- myData1
StudentData <- myData3

shinyServer(function(input, output, session) {
  
 
  output$variable <- renderUI({ 
    obj<-switch(input$dataset,
                "Finance" = myData2,
                "Marketing" = myData1,
                "StudentData" = myData3
               )	 
    var.opts<-colnames(obj)
    selectInput("variable","Variable:", var.opts) # uddate UI 				 
  }) 
  
  output$group <- renderUI({ 
    obj<-switch(input$dataset,
                
                "Finance" = myData2,
                "Marketing" = myData1,
                "StudentData" = myData3)	 
    var.opts<-colnames(obj)
    selectInput("group","Groups:", var.opts) # uddate UI 				 
  }) 
  
  output$caption<-renderText({
    switch(input$plot.type,
           "boxplot" 	= 	"Boxplot",
           "histogram" =	"Histogram",
           "density" 	=	"Density plot",
           "bar" 		=	"Bar graph",
           "freqpoly" = "Freqpoly",
           "dotplot" = "Dot plot",
           "area" = "Area plot")
  })
  
  
  output$plot <- renderUI({
    plotOutput("p", height = 400, width = 1100)
  })
  
  #plotting function using ggplot2
  output$p <- renderPlot({
    
    plot.obj<<-list() # not sure why input$X can not be used directly?
    plot.obj$data<<-get(input$dataset) 
    plot.obj$variable<<-with(plot.obj$data,get(input$variable)) 
    plot.obj$group<<-with(plot.obj$data,get(input$group)) 
    
    #dynamic plotting options
    plot.type<-switch(input$plot.type,
                      pie <- ggplot(mtcars, aes(x = factor(1), fill = factor(cyl))) +
                        geom_bar(width = 1),
                      
                      "boxplot" 	= 	geom_boxplot(),
                      "histogram" =	geom_histogram(alpha=0.75,position="identity",stat = "bin"),
                      "density" 	=	geom_density(kernel = "gaussian"),
                      "bar" 		=	geom_bar(position="dodge"),
                      "freqpoly" = geom_freqpoly(binwidth = 500),
                      "dotplot" =  geom_dotplot(),
                      "area" =  geom_area(stat = "bin")
                     
    )
    
    require(ggplot2)
    #plotting theme
    .theme<- theme(
      axis.line = element_line(colour = 'gray', size = .75), 
      panel.background = element_blank(),  
      plot.background = element_blank()
    )	 
    
    
    if(input$plot.type=="boxplot")	{		#control for 1D or 2D graphs 
      p<-ggplot(plot.obj$data, 
                aes(
                  x 		= plot.obj$group, 
                  y 		= plot.obj$variable,
                  fill 	= as.factor(plot.obj$group)
                )
      ) + plot.type
      
      if(input$show.points==TRUE)
      { 
        p<-p+ geom_point(color='black',alpha=0.5, position = 'jitter')
      }
      
    } else {
      
      p<-ggplot(plot.obj$data, 
                aes(
                  x 		= plot.obj$variable,
                  fill 	= as.factor(plot.obj$group),
                  group 	= as.factor(plot.obj$group),
                  color 	= as.factor(plot.obj$group)
                )
      ) + plot.type
    }
    
    p<-p+labs(
      fill 	= input$group,
      x 		= "",
      y 		= input$variable
    )  +
      .theme
    print(p)
  }) 
  
   
      output$ex2 <- DT::renderDataTable(
        if(input$dataset=="Marketing"){
        DT::datatable(myData1, options = list(pageLength = 25))
        }
        else if(input$dataset=="Finance"){
          DT::datatable(myData2, options = list(pageLength = 25))
        }
        else
          DT::datatable(myData3, options = list(pageLength = 25))
          )
    
    
  })
  
  
  
 # output$summary <- renderPrint({
    #summary(myData1)
  #})
  
