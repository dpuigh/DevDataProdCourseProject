library(shiny)
require(rCharts)
library(dplyr)
library(tidyr)
source("adjust.R")

# value initially in thousands of dollars
# data from https://raw.githubusercontent.com/WhiteHouse/2016-budget-data/master/data/outlays.csv
outlays <- read.csv("outlays.csv")

dfl <- outlays %>% gather(ffy, value, starts_with("x"))
vnames <- c("agcode", "agname", "burcode", "burname", "acctcode", "acctname", "treasagcode", "subfuncode", "subfuntitle",
            "beacat", "grantng", "onoffbud", "TQ", "year", "value")

cbind(vnames, names(dfl))
vdefs <- data.frame(vnames=vnames, longnames=names(dfl))
names(dfl) <- vnames
dfl$year <- as.numeric(substr(dfl$year, 2, 5))
dfl$value <- as.numeric(gsub(",","", dfl$value))
dfl$subfuncode <- factor(dfl$subfuncode)

d <- dfl %>% 
    group_by(subfuncode, subfuntitle, year) %>% 
    summarise(value=sum(value, na.rm=TRUE)/1e6) %>% 
    arrange(year)

rm(outlays, dfl)

shinyServer(function(input, output) {
    
    output$inflation <- renderPrint({input$adjust})
    output$fyref <- renderPrint({input$year})
    
    dataInput <- reactive({  
        subset(d, subfuntitle %in% input$variable)
    })
    
    finalInput <- reactive({
        if (!input$adjust) return(dataInput())
        adjust(dataInput(),input$year)
    })
    
    finalInputAll <- reactive({
        if (!input$adjust) return(d)
        adjust(d,input$year)
    })
    
    output$myChart <- renderChart({
        r1 <- rPlot( value ~ year, data=finalInput(), color="subfuntitle", type="point")
        r1$addParams(dom = 'myChart')
        return(r1)
    })

    output$mytable = renderDataTable({
        finalInputAll()[,-1]
    })
})
