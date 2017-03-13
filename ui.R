#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a plot of Orange Tree
# Circumference versus Age. The user chooses a Tree class for
#which a linear model is fit and displayed
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Linear modelling of Orange Tree Circumference"),
  
  # Sidebar with a slider input for the Tree Class to model on 
  sidebarLayout(
    sidebarPanel(
        h3("Pick which tree to model"),
       sliderInput("classes",
                   "Choose tree:",
                   min = 1,
                   max = 5,
                   value = 3)
    ),
    
    # Show a plot of all Orange Trees with circumference versus age.
    # Each Tree class is colour coded. In addition a linear model fit
    # for Trees of the slider chosen Tree class is displayed 
    mainPanel(
        tabsetPanel(
                tabPanel("Plot", 
                         h3("Orange Tree Circumference as function of tree age"),
                         plotOutput("OrangePlot")),
                tabPanel("Documentation", 
                         h3("Linear modelling of the Orange dataset"),
                         "The Orange dataset consist of 35 measurements of age an circumference for
                         5 different orange trees. As we expect orange trees to grow over time, we might
                         want to construct a linear model of orange tree circumference as a function of tree age.
                         However, different trees might grow at different paces making each tree's growth
                         deviate from the total growth model. In the plot panel for this app, we display the observations
                         for all the trees' circumferences and ages, with observations of each individual tree 
                         shown in a different colour. Overlayed is the linear model for growth extracted from 
                         all the observations. In the sidepanel the user is encouraged to choose one of the five 
                         individual trees, to display the linear model of circumference as a function of age for just 
                         this tree. This will be displayed with a line in the colour of the chosen tree's observations. 
                         Hopefully, this can help the user explore the difference between the average growth pattern and the growth 
                         patterns for each individual tree."
                         )
        )
    )
  )
))
