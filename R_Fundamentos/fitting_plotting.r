library(dplyr)

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
