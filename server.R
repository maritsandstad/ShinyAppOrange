#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
# For nicer colours in the plot we import RColorBrewer
library(RColorBrewer)

# Define server logic required to the plot with linear model fits
shinyServer(function(input, output) {
        
  #First calculate the linear model fit for the combination 
  #of all Tree classes
  totalmodel <- lm(Orange$circumference~Orange$age)
    
  #Then get the linear model for the chosen Tree classe
  modelpred <- reactive({
        classe <- input$classes  
        age <- Orange[Orange$Tree == classe, 2]
        circ <- Orange[Orange$Tree == classe, 3]
        model <- lm(circ~age)
        model            
  }) 
  
  # Model to get the classe reactively, so we can
  # use it to modify plots
  getClasse <- reactive({
        input$classes       
  })
  
  # Then finally we make the plot
  output$OrangePlot <- renderPlot({
        #Defining a vector of the colours to be used
        cols <- brewer.pal(n = 5, name = "Set1")
        cols_Tree <- cols[as.numeric(Orange$Tree)]
        
        # Plotting the data points 
        plot(Orange$age, Orange$circumference, col = cols_Tree, 
             pch = 18, cex = 1.5, xlab = "Age", ylab = "Circumference")
        # Adding a legend to identify each Tree classe
        legend("bottomright", legend = c("1", "2", "3", "4", "5"), 
               col = cols, pch= 18, cex = 1.5)
        
        # Adding lines indicating the linear fits for the chosen
        # Tree classe
        abline(modelpred(), col = cols[getClasse()], lwd = 2)
        
        # And the total linear model prediction:
        abline(totalmodel, col = "black", lwd = 2)
        
        #Then adding a legend to the to linear fits:
        legend("topleft", legend =c(paste("Linear model for Tree: ", getClasse()),
                                    "Linear model for all Trees combined"),
               col = c(cols[getClasse()], "black"), lty = 1, lwd = 2)    
  })
  
})
