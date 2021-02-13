#Library to use
install.packages("quantmod")
install.packages("PerformanceAnalytics")
install.packages("dplyr")
install.packages("caret")
install.packages("tidyverse")
install.packages("tibble")
install.packages("xts")
install.packages("PortfolioAnalytics")
install.packages("GenSA")
install.packages("Quandl")
install.packages("scales")
install.packages("gridExtra")
install.packages("TTR")
install.packages("jsonlite")
install.packages("xtable")
install.packages("gtable")
install.packages("grid")
install.packages("httr")
install.packages("readxl")
install.packages("lubridate")
install.packages("reshape2")
install.packages("tidyquant")

library(quantmod)
library(PerformanceAnalytics)
library(dplyr)
library(caret)
library(tidyverse)
library(tibble)
library(ggplot2)
library(xts)
library(PortfolioAnalytics)
library(GenSA)
library(Quandl)
library(scales)
library(gridExtra)   
library(TTR)
library(jsonlite)
library(xtable)
library(gtable)
library(grid)
library(httr)
library(readxl)
library(lubridate)
library(reshape2)
library(tidyquant)

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

#Basic analitycs
##Big Dataset
GEI_Index <-rbind(T_2, NFLX_2)
GEI_Index$Open = gsub(',','',
                      GEI_Index$Open)%>%
  as.numeric()
summary(GEI_Index)
sd(GEI_Index$Adj.Close)

##T Coefficient 
meanT <- mean(T$Adj.Close)
sdT <- sd(T$Adj.Close)
coefT <- (sdT/meanT)*100 

##NFLX Coefficient
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

#Graphics
ggplot(df, aes(x=df$date, y=df$value)) +
  geom_line(aes(group=var, linetype= var)) +
  labs(title='Adjusted price fluctuation')

##AT&T Daily Return
TClose <- getSymbols.yahoo("T", from=Date, auto.assign = F)[,6]
Trets <- na.omit(dailyReturn(TClose, type="log")) 
chartSeries(Trets)

###Candle chart
getSymbols( Symbols="T", src="yahoo",
            from = Date,
            to = "2020-02-10")

barChart(T, theme = "white")  

###Histogram 
hist(T$T.Close, breaks= 60, col="blue")    

##Netflix Daily Return
NFLXClose <- getSymbols.yahoo("NFLX", from=Date, auto.assign = F)[,6]
NFLXrets <- na.omit(dailyReturn(NFLXClose, type="log")) 
chartSeries(NFLXrets)

###Candle chart
getSymbols( Symbols="NFLX", src="yahoo",
            from = Date,
            to = "2020-02-10")

barChart(NFLX, theme = "white")  

###Histogram 
hist(NFLX$NFLX.Close, breaks= 60, col="blue")   

#Technical analysis AT&T
T %>% Ad() %>% chartSeries()
T %>% chartSeries(TA='addBBands();addVo();addMACD();addRSI();
                  addATR()',
                  subset='2020')  

#Technical analysis NFLX
NFLX %>% Ad() %>% chartSeries()
NFLX %>% chartSeries(TA='addBBands();addVo();addMACD();addRSI();
                  addATR()',
                  subset='2020')

##Profitability
tickers <- c('T', 'NFLX')      

weights <- c(.20, .20)     

portfolioPrices <- NULL
for(ticker in tickers) {
  portfolioPrices <- cbind(portfolioPrices, getSymbols.yahoo(ticker,
                                                             from=Date, periodicity="daily",auto.assign=FALSE)[,6])  
}

#Rate of change
portfolioReturns <- na.omit(ROC(portfolioPrices))  

#Benchmark: con IXP> iShares Global Comm Services ETF

benchmarkPrices <- getSymbols.yahoo('IXP',
                                    from=Date, periodicity='daily', auto.assign=FALSE)[,6]

benchmarkReturns <- na.omit(ROC(benchmarkPrices))     

portfolioReturns <- Return.portfolio(portfolioReturns)

#ROC' graphs
portfolioReturns %>% chartSeries(TA="addROC()",subset="2020")
benchmarkReturns %>% chartSeries(TA="addROC()",subset="2020")

#Profitability according to expected return and risk
CAPM.beta(portfolioReturns, benchmarkReturns, .035/252)     

#Annual return       
table.AnnualizedReturns(portfolioReturns)

#Portfolio optimization
portf <- portfolio.spec(colnames(portfolioReturns))

portf <- add.constraint(portf, type="weight_sum", min_sum=1,
                        max_sum=1)
portf <- add.constraint(portf, type="box", min=.10, max=.40)
portf <- add.objective(portf, type="return", name="mean")
portf <- add.objective(portf, type="risk", name="StdDev")

optPortfolio <- optimize.portfolio(portfolioReturns, portf, 
                              optimize_method ="GenSA")

##Add Quandl Key
Quandl.api_key("GJ4uw-bpN2R9HkqSEfZM")

#Long and short evaluation for trading signal
PFL <- getSymbolsYahoo("T") %>%
  filter(date >= '2019-2-10')

IXP <- getSymbolsYahoo("IXP") %>% 
  filter(date >= '2019-2-10')

PFL <- PFL %>%
  mutate(signal = ifelse(as.numeric(format(date, "%m")) <= 9,1,-1), ticker = "M01")

PFL <- PFL %>%
  mutate(daily_return = ifelse(row_number() == 1, 0, adjusted_close / lag(adjusted_close, 1) - 1), 
         signal_return = daily_return * signal, 
         cum_return = cumprod(1 + signal_return) - 1, 
         cum_return_3m = (cum_return + 1) / lag(cum_return + 1, 63) - 1, 
         cum_return_12m = (cum_return + 1) / lag(cum_return + 1, 252) - 1, 
         drawdown = (cum_return + 1) / cummax(cum_return + 1) - 1, 
         sd_12m = runSD(signal_return, n = 252)*sqrt(252), 
         sharpe_12m = SMA(cum_return_12m / sd_12m), 252)

IXP <- IXP %>% 
  mutate(daily_return = ifelse(row_number() == 1, 0, adjusted_close / lag(adjusted_close, 1) - 1), 
         cum_return = cumprod(1 + daily_return) - 1, 
         cum_return_3m = (cum_return + 1) / lag(cum_return + 1, 63) - 1, 
         cum_return_12m = (cum_return + 1) / lag(cum_return + 1, 252) - 1, 
         drawdown = (cum_return + 1) / cummax(cum_return + 1) - 1, 
         sd_12m = runSD(daily_return, n = 252)*sqrt(252), 
         sharpe_12m = SMA(cum_return_12m / sd_12m), 252)

combined <- bind_rows(PFL, IXP)

#Plot equity curve vs benchmark.
(p1 <- ggplot(combined, aes(x = date, y = cum_return)) + 
    geom_line(aes(colour = ticker)) + 
    labs(title = "Equity Curve vs Benchmark", 
         subtitle = "Strategy performance evaluation", 
         y = "Cumulative Return", 
         x = "Date") + 
    geom_hline(yintercept = 0) + 
    theme_alphaplot())

(p2 <- ggplot(PFL, aes(x = date, y = signal)) + 
    geom_line(size = 1, colour = "blue") + 
    labs(title = "Trading Signal", 
         subtitle = "Strategy signal", 
         y = "Position", 
         x = "Date") + 
    geom_hline(yintercept = 0) + 
    theme_alphaplot())

(p3 <- ggplot(PFL, aes(x = date, y = adjusted_close)) + 
    geom_line(aes(colour = signal)) + 
    scale_colour_gradient(low = "red") +
    labs(title = "PFL Closing Price with Trading Signal", 
         subtitle = "in short and long", 
         y = "Adjusted close", 
         x = "Date") + 
    geom_hline(yintercept = 0) + 
    theme_alphaplot())

(p4 <- ggplot(combined, aes(x = date, y = cum_return_3m)) + 
    geom_line(aes(colour = ticker)) + 
    labs(title = "Rolling Returns", 
         y = "Return", 
         x = "Date") + 
    scale_y_continuous(labels = percent, limits = c(-0.5, 0.75)) + 
    geom_hline(yintercept = 0) + 
    theme_alphaplot())

(p5 <- ggplot(combined, aes(x = date, y = drawdown)) + 
    geom_line(aes(colour = ticker)) + 
    labs(title = "Drawdown", 
         subtitle = "Frequency of falls, size of maximum falls and recovery time", 
         y = "Drawdown %", 
         x = "Date") + 
    scale_y_continuous(labels = percent) + 
    geom_hline(yintercept = 0) + 
    theme_alphaplot())

(p6 <- ggplot(combined, aes(x = date, y = sharpe_12m)) + 
    geom_line(aes(colour = ticker)) + 
    labs(title = "Sharpe Ratio", 
         subtitle = "Returns per unit of risk", 
         y = "Sharpe Ratio", 
         x = "Date") + 
    geom_hline(yintercept = 0) + 
    theme_alphaplot())

#Evaluate profitability
stocks <- c("T", "NFLX")

stock_data <- tq_get(stocks,
                     get = "stock.prices",
                     from = Sys.Date() - months(12),
                     to = Sys.Date())

init.investment <- 1000
growth <- mo_returns %>% arrange(date) %>%
  mutate(final_value = init.investment * cumprod(1 + returns)) %>%
  arrange(desc(final_value))
growth %>% filter(date == max(date)) %>% select(-date)

growth %>% ggplot(aes(x = date, y = final_value, color = symbol)) +
  geom_line() +
  labs(
    title = "Comparing US1000 Growth",
    subtitle = "Performance",
    x = "",
    y = "Investment value"
  ) +
  theme_tq() + theme(legend.position = "right") +
  scale_y_continuous(labels = scales::dollar)

growth %>% ungroup() %>% filter(date == max(date)) %>% 
  mutate(rank = row_number()) %>% top_n(5, final_value) %>% 
  select(rank, symbol, final_value)     
