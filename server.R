library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
  
  library(Quandl)
  library(dplyr)
  fb <- Quandl('WIKI/FB')
  apple <- Quandl('WIKI/AAPL')
  amz <- Quandl('WIKI/AMZN')
  nf <- Quandl('WIKI/NFLX')
  goog <- Quandl('WIKI/GOOG')
  
  names(fb)[12] <- 'AdjClose'
  names(apple)[12] <- 'AdjClose'
  names(amz)[12] <- 'AdjClose'
  names(nf)[12] <- 'AdjClose'
  names(goog)[12] <- 'AdjClose'
  
  fb <- fb %>% select(Date, AdjClose)
  apple <- apple %>% select(Date, AdjClose)
  amz <- amz %>% select(Date, AdjClose)
  nf <- nf %>% select(Date, AdjClose)
  goog <- goog %>% select(Date, AdjClose)
  counters <- c('Facebook','Apple','Amazon','Netflix','Google')
  stocks <- list(fb,apple,amz,nf,goog)
  
  output$priceChart <- renderPlot({
    start <- input$dates[1]
    end <- input$dates[2]
    ind <- which(counters==input$counter)
    ts <- stocks[[ind]] %>% filter(Date >= start &  Date <= end)
    
    g <- ggplot(ts, aes(x=Date, y=AdjClose)) 
    g + geom_line()
  })
  
  startp <- reactive({
    start <- input$dates[1]
    end <- input$dates[2]
    ind <- which(counters==input$counter)
    ts <- stocks[[ind]] %>% filter(Date >= start &  Date <= end)
    ts$AdjClose[length(ts[,2])]
  })
  
  endp <- reactive({
    start <- input$dates[1]
    end <- input$dates[2]
    ind <- which(counters==input$counter)
    ts <- stocks[[ind]] %>% filter(Date >= start &  Date <= end)
    ts$AdjClose[1]
  })
  
  ror <- reactive({
    start <- input$dates[1]
    end <- input$dates[2]
    ind <- which(counters==input$counter)
    ts <- stocks[[ind]] %>% filter(Date >= start &  Date <= end)
    endp <- ts$AdjClose[1]
    startp <- ts$AdjClose[length(ts[,2])]
    endp/startp*100-100
  })
  
  output$return <- renderText({
    ror()
  })
  
  output$p1 <- renderText({
    startp()
  })
  
  output$p2 <- renderText({
    endp()
  })
  
})