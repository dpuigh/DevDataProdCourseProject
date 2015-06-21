library(quantmod)

if (!exists(".inflation")) {
    .inflation <- getSymbols('CPIAUCSL', src = 'FRED', 
                             auto.assign = FALSE)
}  

adjust <- function(data, year) {
    year <- max(1947,year)
    year <- min(2015,year)
    avg.cpi <- apply.yearly(.inflation, mean)
    cf <- avg.cpi/as.numeric(avg.cpi[year])
    
    custom_function <- function(x){
        if( x > 2015 ){
            x <- 2015
        }
        as.numeric(cf[as.character(x),])
    }
    data$value <- data$value * sapply(data$year,custom_function)
    data
}