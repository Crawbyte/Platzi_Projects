# Library to use
install.packages("quantmod")
install.packages("PerformanceAnalytics")
install.packages("dplyr")
install.packages("caret")
install.packages("tidyverse")

library(quantmod)
library(PerformanceAnalytics)
library(dplyr)
library(caret)
library(tidyverse)

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
GEI_Index <-rbind(T_2, NFLX_2)
