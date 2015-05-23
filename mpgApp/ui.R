library(shiny)
mpgData <<- mtcars
mpgData$am <<- factor(mpgData$am, labels = c("Automatic", "Manual"))
names(mpgData) <<- c("Miles_per_gallon", "Number_of_cyllinders", "Displacement",
                     "Horsepower", "Rear_axle_ratio", "Weight", "Time_Acc", "VS",
                     "Transmission", "Gears", "Caburetors" )
# Define UI for miles per gallon application
shinyUI(fluidPage(
        
        # Application title
        titlePanel("Dataset mtcars"),
        
        # Sidebar with controls to select the variable to plot against
        # mpg and to specify whether outliers should be included
        sidebarLayout(
                sidebarPanel(
                        selectInput("variable1", "Variable 1:",
                                    names(mpgData)),
                        selectInput("variable2", "Variable 2:",
                                    c("VS","Transmission"))
                ),
                
                # Show the caption and plot of the requested variable against
                # mpg
                mainPanel(
                        h3(textOutput("caption")),
                        
                        plotOutput("mpgPlot"),
                        h3("T-test:"),
                        textOutput("ttest"),
                        h3("Adjusted R-Square:"),
                        textOutput("adjrsquare"),
                        h3("Residuals Analysis:"),
                        plotOutput("PlotRes")
                )
        )
))