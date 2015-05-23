shinyUI(pageWithSidebar(
        headerPanel("Johns Happy Sandwiches"),
        sidebarPanel(
                sliderInput("pay", 
                            "Wage:", 
                            min = 10, max = 50, value = 30)
        ),
        mainPanel(
                h3("Process table"),
                h4("(times notes in seconds)"),
                tableOutput("table"),
                h3('Station bottleneck'),
                textOutput('stationbottleneck'),
                h3('Process capacity (per hour)'),
                textOutput('processcapacity'),
                h3('Direct labor cost per unit (USD)'),
                textOutput('directlaborcost'),
                h3('Average labor utilization'),
                textOutput('avglaborutil')
        )
))