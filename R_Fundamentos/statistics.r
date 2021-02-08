library(dplyr)
library(stringr)

# Import document
orangeec <- read_csv("Orange-Economy-master/orangeec.csv")

# General pairs 
pairs(orangeec[,2:6])
pairs(orangeec[,5:10])

# subsetting
newdata <- subset(orangeec, select=c(5, 6, 10, 11, 12, 13))

# Pairs of the subset
pairs(newdata)

# Correlation
cor(orangeec[,2,6],use= 'complete.obs')
cor(orangeec[,5,10],use= 'complete.obs')
pairs(newdata, use= 'complete.obs')

# Standard deviation
desv <- sd(orangeec$`Internet penetration % population`, na.rm = TRUE)

# Mean
prom <- mean(orangeec$`Internet penetration % population`, na.rm = TRUE)

# Variation coefficient
CoefVar <- (desv/prom)*100
