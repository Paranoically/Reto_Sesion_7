library(DBI)

library(RMySQL)

datos <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

dbListTables(datos)

dbListFields(datos, 'CountryLanguage')

lang <- dbGetQuery(datos, "select * from CountryLanguage")
names(lang)

install.packages("dplyr")
library(dplyr)

espanol <- lang %>% filter(Language == "Spanish")
espdataframe <- as.data.frame(espanol) 

install.packages("ggplot2")
library(ggplot2)

espdataframe%>% ggplot(aes( x = CountryCode, y=Percentage, fill = IsOfficial )) + 
  geom_bin2d() +
  coord_flip()