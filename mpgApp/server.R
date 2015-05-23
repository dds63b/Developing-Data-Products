library(shiny)
library(datasets)

# We tweak the "am" field to have nicer factor labels. Since
# this doesn't rely on any user inputs we can do this once at
# startup and then use the value throughout the lifetime of the
# application
mpgData <<- mtcars
mpgData$am <<- factor(mpgData$am, labels = c("Automatic", "Manual"))
names(mpgData) <<- c("Miles_per_gallon", "Number_of_cyllinders", "Displacement",
                    "Horsepower", "Rear_axle_ratio", "Weight", "Time_Acc", "VS",
                    "Transmission", "Gears", "Caburetors" )


# Define server logic required to plot various variables
shinyServer(function(input, output) {
        
        # Compute the formula text in a reactive expression since it is
        # shared by the output$caption and output$mpgPlot functions
        formulaText <- reactive({
                paste(input$variable1, " ~", input$variable2)
        })
        
        # Return the formula text for printing as a caption
        output$caption <- renderText({
                formulaText()
        })
        
        # Generate a plot of the requested variable against mpg
        output$mpgPlot <- renderPlot({
                boxplot(as.formula(formulaText()),
                        data = mpgData, col="orange")
        })
        output$ttest <- renderPrint({
                t.test(as.formula(formulaText()),
                       data = mpgData, conf.level=0.95)
        })
        
        output$adjrsquare <- renderPrint({
                summary(lm(formula = as.formula(formulaText()),
                           data = mpgData))$adj.r.squared
        })
        output$PlotRes <- renderPlot({
                par(mfrow = c(2,2))
                plot(lm(formula = as.formula(formulaText()),
                        data = mpgData))
        })
})