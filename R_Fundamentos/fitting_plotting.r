library(dplyr)
library(RColorBrewer)

# Import document
orangeec <- read_csv("Orange-Economy-master/orangeec.csv")

# Fitting
orangeec <- orangeec %>%
  mutate(Crecimiento_GDP = ifelse(`GDP Growth %` >= 2.5, '2.5 o más', 'Menos 2.5%'))

orangeec <- orangeec %>%
  mutate(Anaranjados= ifelse(`Creat Ind % GDP` >= 2.5, 'Más anaranjados', 'Menos anaranjados'))

# Ranking
orangeec %>%
  arrange(desc(`Creat Ind % GDP`))

TopNaranjas <- orangeec %>%
  filter(Country %in% c('Mexico', 'Panama', 'Argentina', 'Colombia', 'Brazil'))

TopNaranjas %>% arrange(desc(`Creat Ind % GDP`))

# Facet wrap
ggplot(TopNaranjas, aes(x=`Internet penetration % population`, 
                        y=`Services % GDP`, size=`GDP PC`)) + 
  geom_point() + facet_wrap(~Country)

ggplot(TopNaranjas, aes(x=`Education invest % GDP`, 
                        y=`Creat Ind % GDP`, size=Unemployment)) + 
  geom_point() + facet_wrap(~Country)

my_colors <- brewer.pal(9, 'Reds')

ggplot(TopNaranjas, aes(x=`Internet penetration % population`,
                        y=`GDP PC`, fill=`Creat Ind % GDP`))+
  geom_tile() +
  facet_wrap(~Country) +
  scale_fill_gradientn(colors = my_colors)
