library(markdown)
library(shiny)
library(shinyjs)
library(shinythemes)
library(shinydashboard)
shinyUI(fluidPage(headerPanel(h6("Online EarthQuake Analysis")),
                  includeCSS("new.css"),
                  titlePanel(h2('Online EarthQuake Analysis Tool',style="color:#FFFFFF")),
                  navbarPage(title =h3("HOME"),
                             
                             tabPanel(h3('EARTHQUAKE',style = "font-weight: 500; line-height: 1.1"),
                                      sidebarLayout(
                                        sidebarPanel(
                                          h3('EarthQuake Analysis for the past 30 days (updated every 15 minutes)',style = "font-weight: 500; line-height: 1.1; 
                                             color:#206085 ;"),  
                                          h3('SUMMARY'),
                                          verbatimTextOutput("summary2")
                                          ),
                                        
                                        mainPanel(
                                          h3('Significant earthquakes for the past 30 days',style = "
                                             font-weight: 500; line-height: 1.1; 
                                             color:#FFFFFF ;"),
                                          DT::dataTableOutput("table")
                                          )
                                        )
                             ),
                             navbarMenu(h3('ARIMA ANALYSIS'),
                                        tabPanel(h4('ACF AND PACF'),
                                                 sidebarLayout(
                                                   sidebarPanel(
                                                     h3('The ACF can be used to identify the possible structure of time series data.', style = "
                                                        font-weight: 500; line-height: 1.1; 
                                                        color: #6878D1;"),
                                                     h3('The PACF gives the partial correlation of the time series with its own lagged values.', style = "
                                                        font-weight: 500; line-height: 1.1; 
                                                        color: #6878D1;")
                                                     
                                                     ),
                                                   mainPanel(
                                                     "main panel",
                                                     fluidRow(
                                                       splitLayout(cellWidths = c("50%", "50%"), plotOutput("plot2"), plotOutput("plot3"))
                                                     )
                                                   )
                                                     )
                                                 ),
                                        tabPanel(h4("ARIMA Forecasting"),
                                                 titlePanel(h3("EarthQuake Prediction after every 15 minutes", style = "
                                                               font-weight: 500; line-height: 1.1; 
                                                               color: #FFFFFF;")),
                                                 
                                                 mainPanel(
                                                   h3(numericInput('b2',h3('Number of periods to do forecasting',style="color:#FFFFFF"),2,min=1)),
                                                   verbatimTextOutput("b2")
                                                 )
                                                 )
                                                 ),
                             
                             
                             navbarMenu(h3('SPECTRAL ANALYSIS'),
                                        
                                        tabPanel(h4("Periodogram"),
                                                 sidebarLayout(
                                                   sidebarPanel(
                                                     h3('A periodogram is used to identify the dominant periods of a time series.A Periodogram is similar to Fourier Transform but it is optimized for unevenly time-sampled data.', style = "
                                                        font-weight: 500; line-height: 1.1; 
                                                        color: #6878D1;")
                                                     
                                                     ),
                                                   mainPanel(
                                                     plotOutput("plot",width  = "500px",height = "400px")
                                                   )
                                                   )
                                        ),
                                        tabPanel(h4("Spectral Forecasting"),
                                                 
                                                 mainPanel(
                                                   
                                                   h3(numericInput('T', h3('Enter your Periodogram value for forecasting (location of highest peak)',style="color:#FFFFFF"),0.5,min=1)),
                                                   verbatimTextOutput("T5"))
                                                 
                                        )
                                        
                                        
                                        
                             ),
                             
                             
                             tabPanel(h3("DATASET"),
                                      mainPanel(
                                        h3('Data used from USGS',style = "
                                           font-weight: 500; line-height: 1.1; 
                                           color: #FFFFFF;" ),
                                        verbatimTextOutput("ii"),
                                        DT::dataTableOutput("tables")
                                        )
                                      )
                             
                             
                             
                  )                                  )
)
