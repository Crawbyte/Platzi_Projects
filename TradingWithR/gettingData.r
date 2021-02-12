# Library to use
install.packages("quantmod")
install.packages("PerformanceAnalytics")
install.packages("dplyr")
install.packages("caret")
install.packages("tidyverse")
install.packages("tibble")
install.packages("xts")

library(quantmod)
library(PerformanceAnalytics)
library(dplyr)
library(caret)
library(tidyverse)
library(tibble)
library(ggplot2)
library(xts)

#Import data of AT&T from Yahoo Finance

Date <- '2019-2-10'
t <- getSymbols.yahoo('T', from = date, env = .GlobalEnv)
tClose <- getSymbols.yahoo('T', from=date, auto.assign=F)[,6]
tRets <- na.omit(dailyReturn(tClose, type = 'log'))
chartSeries(tRets)

'T' <- read.csv("/cloud/project/T.csv")
T <- mutate(T, company='AT&T', Company_ticker='T')
T_2 <- T[, c(9,8,1,2,3,4,5,6,7)]

#Import data of Netflix, Inc from Yahoo Finance
Date <- '2019-2-10'
nflx <- getSymbols.yahoo('NFLX', from = date, env = .GlobalEnv)
nflxClose <- getSymbols.yahoo('NFLX', from=date, auto.assign=F)[,6]
nflxRets <- na.omit(dailyReturn(nflxClose, type = 'log'))
chartSeries(nflxRets)

'NFLX' <- read.csv("/cloud/project/NFLX.csv")
NFLX <- mutate(NFLX, company='Netflix', Company_ticker='NFLX')
NFLX_2 <- T[, c(9,8,1,2,3,4,5,6,7)]

# Basic analitycs
## Big Dataset
GEI_Index <-rbind(T_2, NFLX_2)
GEI_Index$Open = gsub(',','',
                      GEI_Index$Open)%>%
  as.numeric()
summary(GEI_Index)
sd(GEI_Index$Adj.Close)

## T Coefficient 
meanT <- mean(T$Adj.Close)
sdT <- sd(T$Adj.Close)
coefT <- (sdT/meanT)*100 

## NFLX Coefficient
meanNFLX <- mean(NFLX$Adj.Close)
sdNFLX <- sd(NFLX$Adj.Close)
coefNFLX <- (sdNFLX/meanNFLX)*100 

## 
dates <- '2019-2-10'
tickers <- c('T', 'NFLX')

portfolioPrices <- NULL 
for(ticker in tickers){
  portfolioPrices <- cbind(portfolioPrices,
                          getSymbols.yahoo(ticker,
                                           from='2019-2-10',
                                           periodicity ="daily", auto.assign=FALSE)[,6])
}
portfolioPrices <- as.data.frame(portfolioPrices)
portfolioPrices <- rownames_to_column(portfolioPrices, var='date')

df <- portfolioPrices %>%
  select(date, T.Adjusted, NFLX.Adjusted) %>%
  gather(key='var', value='value', -date)

# Graphics
ggplot(df, aes(x=df$date, y=df$value)) +
  geom_line(aes(group=var, linetype= var)) +
  labs(title='Adjusted price fluctuation')

## AT&T Daily Return
TClose <- getSymbols.yahoo("T", from=Date, auto.assign = F)[,6]
Trets <- na.omit(dailyReturn(TClose, type="log")) 
chartSeries(Trets)

### Candle chart
getSymbols( Symbols="T", src="yahoo",
            from = Date,
            to = "2020-02-10")

barChart(T, theme = "white")  

### Histogram 
hist(T$T.Close, breaks= 60, col="blue")    

## Netflix Daily Return
NFLXClose <- getSymbols.yahoo("NFLX", from=Date, auto.assign = F)[,6]
NFLXrets <- na.omit(dailyReturn(NFLXClose, type="log")) 
chartSeries(NFLXrets)

### Candle chart
getSymbols( Symbols="NFLX", src="yahoo",
            from = Date,
            to = "2020-02-10")

barChart(NFLX, theme = "white")  

### Histogram 
hist(NFLX$NFLX.Close, breaks= 60, col="blue")   

# Technical analysis AT&T
T %>% Ad() %>% chartSeries()
T %>% chartSeries(TA='addBBands();addVo();addMACD();addRSI();
                  addATR()',
                  subset='2020')  

# Technical analysis NFLX
NFLX %>% Ad() %>% chartSeries()
NFLX %>% chartSeries(TA='addBBands();addVo();addMACD();addRSI();
                  addATR()',
                  subset='2020')
