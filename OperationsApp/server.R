library(shiny)
Station = c("a","b","c","d","e","f")

shinyServer(
        function(input, output) {
                wage <<- reactive({input$pay})
                
                ProcessingTime <- c(44,40,55,60,50,40)  ## seconds
                Capacity = round(1/ProcessingTime, 3)
                bottleneck = min(Capacity)
                bottleneckS = max(ProcessingTime)
                cap_hr = bottleneck*(60*60)
                station_bottleneck <- which.min(Capacity)
                cycle_time <- 1/bottleneckS
                IdleTime <- bottleneckS-ProcessingTime
                labor_util <- ((sum(ProcessingTime)) / ((sum(ProcessingTime)+sum(IdleTime))))
                Utilization <- round(bottleneck/Capacity, 3)
                #direct_labor_cost_perRazor <- (6*(wage)) / ((60*60)*bottleneck)
                table <- cbind(Station,ProcessingTime,Utilization,IdleTime)
                
                output$table <- renderTable({table})       
                
                output$stationbottleneck <- renderPrint({
                        station_bottleneck
                })
                output$processcapacity <- renderPrint({
                        cap_hr
                })
                output$directlaborcost <- renderPrint({
                        round(((6*(input$pay)) / ((60*60)*bottleneck)),2)
                })
                output$avglaborutil <- renderPrint({
                        round(labor_util, 3)
})
})