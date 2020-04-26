#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(DT)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    tabsetPanel(tabPanel("All Data", 
                         titlePanel("Updated Covid-19 Dataset"),
                         fluidRow(column(DT::dataTableOutput("RawData"), 
                                         width = 12)
                                  )),
                tabPanel("Figure",
                         titlePanel("Top Countries with Covid-19"),
                         sidebarLayout(
                           sidebarPanel(
                             numericInput("cbarras", 
                                          "Bar Quantity", 
                                          value = 10,
                                          1, 15, 1)
                                          ), 
                          mainPanel(plotOutput("plot1"))
                           
                         )),
                tabPanel("Map", 
                         titlePanel("Covid-19 Worldwide Map"),
                         mainPanel(
                           plotlyOutput("plot2"))
                         )
                         ))
    
)
