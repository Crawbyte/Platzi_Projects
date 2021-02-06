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

#EDA Boxplot
economy <- mean(orangeec$`GDP PC`)
orangeec <- orangeec %>%
  mutate(Strong_economy = ifelse(`GDP PC` <economy,
                                 'Por debajo del promedio PIB per cápita',
                                 'Sobre el promedio PIB per cápita'))
ggplot(orangeec, aes(x=`Strong_economy`, y=`Creat Ind % GDP`,
                     fill=`Strong_economy`)) +
  geom_boxplot(alpha=0.4) +
  labs(x='Tipo de país', y='Aporte de economía naranja',
       tittle='Aporte economía naranja en PIB de paises de LATAM con alto y bajo PIB per cápita') +
  theme(legend.position = 'none')+
  theme(panel.background = element_blank(),panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

ggplot(orangeec, aes(x=`Strong_economy`, y=`Internet penetration % population`,
                     fill=`Strong_economy`)) +
  geom_boxplot(alpha=0.4) +
  labs(x='Tipo de país', y='Penetración de internet (%)',
       tittle='Penetración de internet en paises de LATAM con alto y bajo PIB per cápita') +
  theme(legend.position = 'none')+
  theme(panel.background = element_blank(),panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
