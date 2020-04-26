#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(plotly)

dataset <- read_csv("covid-19.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    output$RawData <- DT::renderDataTable(
        DT::datatable({dataset},
                      options = list(lengthMenu = list(c(5,15,-1), c('5', '15', 'All')), pageLength = 15),
                      filter = "top",
                      selection = 'multiple',
                      style = 'bootstrap'
        )
    )
    
    output$plot1 <- renderPlot({
        countries <- head(dataset[c('countriesAndTerritories', 'cases')], input$cbarras)
        
        countries %>% ggplot(aes(x = reorder(countriesAndTerritories, -cases), y = cases))+
            geom_bar(stat = "identity", fill = 'lightblue') + 
            theme_minimal() +
            xlab("Country") +
            ylab("Nº of Cases")
    })
    
    output$plot2 <- renderPlotly({
        fig <- dataset
        
        fig <- fig %>%
            plot_ly(
                lat = ~lat,
                lon = ~lng,
                size = ~cases,
                sizes = c(10, 100),
                marker = list(color = 'blue', opacity = 0.5, sizemode = 'diameter'),
                type = 'scattermapbox',
                hovertext = paste(fig$countriesAndTerritories, '\n Confirmed Cases: ', fig$cases)
            ) 
        
        fig <- fig %>%
            layout(
                title = 'How Covid-19 is today',
                mapbox = list(
                    style = 'open-street-map',
                    zoom =2.5,
                    center = list(lon = -70, lat = -33)),
                autosize = FALSE, 
                width = 1200, 
                height = 800)
        
        fig
    })

})