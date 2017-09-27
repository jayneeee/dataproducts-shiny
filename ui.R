library(shiny)

shinyUI(fluidPage(
  titlePanel("Stock Price History"),
  # Sidebar with a slider input for dates
  sidebarLayout(
    sidebarPanel(
      selectInput('counter', '1. Select stock counter:',
                  choices=c('Facebook','Apple','Amazon','Netflix','Google')),
      sliderInput("dates","2. Select Time Period:",
                  min = as.Date('2017-01-01', '%Y-%m-%d'),
                  max = Sys.Date()-1,
                  value = c(as.Date('2017-01-01', '%Y-%m-%d'),Sys.Date()-1)
      ),
      p('Note: Price history of Facebook and Google starts in May 2012 and March 2014 respectively') 
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Please allow few seconds for the connection to set up before the graph can be showed "),
      plotOutput("priceChart"),
      h4('Start price:'),
      textOutput('p1'),
      h4('End price:'),
      textOutput('p2'),
      h4('Rate of return (%):'),
      textOutput('return')
    )
  )
))