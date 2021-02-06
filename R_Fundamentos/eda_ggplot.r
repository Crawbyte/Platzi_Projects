library(dplyr)
library(readr)
library(ggplot2)

# Import document
orangeec <- read_csv("Orange-Economy-master/orangeec.csv")

#EDA Scatter Plot
plot(orangeec$Unemployment ~ orangeec$`Education invest % GDP`,
     xlab='Inversión educación (%PIB)', ylab = 'Desempleo',
     main='Relación de inversión en educación y desempleo')

plot(orangeec$`GDP PC` ~ orangeec$`Creat Ind % GDP`,
     xlab='Aporte de economía naranja al PIB', ylab = 'PIB per capita',
     main='Economía naranja en el PIB per capita')

#EDA Histogram 
ggplot()+geom_histogram(data=orangeec, 
                        aes (x=`GDP PC`), fill='blue', color='red', 
                        binwidth= 2000 )+
  labs(x='PIB per cápita', y='Cantidad de paises',
       tittle='PIB per cápita en LATAM')+
  theme(legend.position = 'none')+
  theme(panel.background = element_blank(),panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
        
 ggplot()+geom_histogram(data=orangeec, 
                        aes (x=`Creat Ind % GDP`), fill='blue', color='red', 
                        binwidth= 1 )+
  labs(x='Aporte de la economía naranja al PIB(%)', y='Cantidad de paises',
       tittle='Economía naranja al PIB en LATAM')+
  theme(legend.position = 'none')+
  theme(panel.background = element_blank(),panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
