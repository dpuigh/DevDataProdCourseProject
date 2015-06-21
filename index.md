---
title       : Understanding the U.S. Budget
subtitle    : FY 2016
author      : Darren Puigh
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [bootstrap, quiz]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

<style>
.title-slide {
  background-color: #66CCFF; /*#CBE7A5; #EDE0CF; ; #CA9F9D*/
}
</style>


## The US Budget

* The US has one of the largest and most influential economies in the world
* Each year, the Administration's budget is released
   * Offers proposals on key priorities and newly announced initiatives
* The budget process is meant to be a reflection of the values of the country
* It is important the public be informed about the President's proposals

--- &radio
## How much do you know about the US Budget?

In 2015, on what did the US spend the most money?

1. Department of Defense-Military
2. Interest on Treasury debt securities
3. Medicare
4. _Social Security_
5. General science and basic research

*** .hint 
Good guess! It involves the aging population in the US...

*** .explanation 
That's right! The US spent nearly $900 billion on Social Security.

--- .class #id 

## Visualizing the budget

We present to you a new shiny app to help you visualize the new budget proposal: https://dpuigh.shinyapps.io/shinyapp

With this shiny app, you can easily:
* explore past, present, and future government spending
* compare and contrast multiple categories
   * e.g. how has spending on general science and basic research compared to spending on farm income stabilization over the years
* correct spending values for inflation
   * you can also choose which year is used as reference
* investigate a searchable table of the data
   * e.g. allows you to quickly rank different sources for a given year
* and more!

--- .class #id 

## Summary



It is important to understand what the US spending is and will be if you want to take part in the conversation for the future. *Try our app today!*


```r
head(dd[order(dd$value,decreasing=TRUE),-1])
```

```
## Source: local data frame [6 x 3]
## 
##       subfuntitle year    value
## 1 Social security 2020 1187.701
## 2 Social security 2019 1120.347
## 3 Social security 2018 1056.699
## 4 Social security 2017  997.040
## 5 Social security 2016  944.338
## 6 Social security 2015  896.294
```

