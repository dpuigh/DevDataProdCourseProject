library(ggplot2)
library(dplyr)
library(tidyr)
require(rCharts)

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

shinyUI(fluidPage(
    headerPanel("U.S. Budget Data (2015)"),
    
    sidebarPanel(
        helpText("Explore past, present, and future government spending. 
                    Allows you to compare and contrast multiple categories, 
                    e.g. how has spending on general science and basic research 
                    compared to spending on farm income stabilization over the years. 
                    User has option to correct spending for inflation and to choose
                    which year is used as reference. Also included is a table of the data
                    through which the user can search. Spending values past 2015 are projections.
                    Data from [1]."),
        selectInput(inputId = "year",
                    label = "Choose Year",
                    choices = unique(d$year),
                    selected = 2015),
        checkboxInput("adjust", 
                      "Adjust prices for inflation", value = FALSE),
        checkboxGroupInput("variable", "Subfunction:",
                           unlist(as.character(unique(d$subfuntitle))),
                           selected="Department of Defense-Military")
    ),
    mainPanel(
        h2('Amount of money spent (in billions of USD) per subfunction per year'),
        showOutput("myChart", "polycharts"),
        h4('Adjusting for inflation?'),
        verbatimTextOutput("inflation"),
        h4('If inflation corrected, all dollar values are with respect to year'),
        verbatimTextOutput("fyref"),
        h2('Table of outlays'),
        dataTableOutput('mytable'),
        h2('Reference'),
        p("Data for the The President's Fiscal Year 2016 Budget"),
        p("[1] https://github.com/WhiteHouse/2016-budget-data")
    )
))