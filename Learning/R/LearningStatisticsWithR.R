ls()
rm(list=ls())

1:10
seq(1,10)
seq(1,10,1)
seq(from=1, to=10, by=1)
seq(from = 1, to = 10, by = 0.5)
library(dplyr)
library(ggplot2)
x=seq(1,100)
y=x*x
qplot(x,y)

x=seq(-50,50)
y=x*x
qplot(x,y)

x=seq(0,8*pi, 0.1) 
y=sin(x)
qplot(x,y, geom = "line") 


x <- rnorm(1000)
qplot(x)

setwd("/home/trung/DATA/Learning/R")
getwd()
list.files("Data")
compensation <- read.csv("~/DATA/Learning/R/Data/compensation.csv")
file.choose()

names(compensation)
head(compensation)
str(compensation)
dim(compensation)
glimpse(compensation)
tbl_df(compensation)



nasty.format <- read.csv("Data/nasty format.csv")
str(nasty.format)
nasty.format <- filter(nasty.format, Bottle != "")
glimpse(nasty.format)

library(tidyr)
tidy_data <- gather(nasty.format, Date, Abundance, 4:11)
glimpse(tidy_data)

library(stringr)
tidy_data <- mutate(tidy_data, Date = substr(Date, 2, 20))
glimpse(tidy_data)

unique(tidy_data$Date)

library(lubridate)
tidy_data <- mutate(tidy_data, Date = dmy(Date))

ggplot(data = tidy_data, aes(x=Date, y=Abundance)) +
  geom_point() +
  facet_wrap(~Bottle)

ggplot(data = tidy_data, aes(x=Temp, y=Abundance)) +
  geom_point() +
  facet_wrap(~Bottle)

ggplot(data = tidy_data, aes(x=Bottle, y=Abundance)) +
  geom_point() +
  facet_wrap(~Temp)


################################################################################################################
################################################################################################################
################################################################################################################
################################################################################################################
# get summary statistics for the compensation variables
summary(compensation)
#dplyr verbs: select(), slice(), filter(), arrange(), and mutate()
#All dplyr functions do one thing, and one thing very fast and very effectively.
#The first arguments in the dplyr "verbs" is the data frame

select(compensation, Fruit) 
select(compensation, -Root)

slice(compensation, 2)
slice(compensation, 2:10)
slice(compensation, c(2, 3, 10))

with(compensation, Fruit > 80)

filter(compensation, Fruit > 80)
filter(compensation, Fruit > 80 | Fruit < 20)

compensation <- mutate(compensation, logFruit = log(Fruit))

head(compensation)

arrange(compensation, Fruit)

select(filter(compensation, Fruit > 80), Root)
filter(compensation, Fruit > 80) %>% select(Root)
compensation %>% filter(Fruit > 80) %>% select(Root)

mean.fruit <- summarise(
  group_by(compensation, Grazing),
  meanFruit = mean(Fruit))



################################################################################################################
################################################################################################################
################################################################################################################
################################################################################################################

# χ2 (chi-square) contingency table analysis is an analysis of count data
# It is essentially a test of association among two or more categorical variables.
# My First Chi-square contingency analysis
# Clear the decks
rm(list = ls())
# libraries I always use.
library(dplyr)
library(ggplot2)
# import the data
lady <- read.csv("Data/ladybirds_morph_colour.csv")
glimpse(lady)

totals <- lady %>% group_by(Habitat, morph_colour) %>% summarise(total.number)
totals

ggplot(totals, aes(x=Habitat, y=total.number, fill = morph_colour)) + geom_bar(stat='identity', position='dodge')

ggplot(totals, aes(x = Habitat, y = total.number,
                   fill = morph_colour)) +
  geom_bar(stat = 'identity', position = 'dodge') +
  scale_fill_manual(values = c(black = "black", red = "red"))

tmp=as.matrix(totals)

lady.mat <- xtabs(number ~ Habitat + morph_colour,
                  data = lady)
lady.mat
chisq.test(lady.mat)


################################################################################################################
################################################################################################################
################################################################################################################
################################################################################################################
# two-sample t-test
ozone <- read.csv("Data/ozone.csv")
glimpse(ozone)
ozone

with(ozone, Garden.location=="West")
west_ozone <- ozone %>% filter(Garden.location=="West") %>% select(Ozone)
east_ozone <- ozone %>% filter(Garden.location=="East") %>% select(Ozone)

qplot(west_ozone)

ggplot(ozone, aes(x = Ozone)) +
  geom_histogram(binwidth = 10) +
  facet_wrap(~ Garden.location, ncol = 1) +
  theme_bw()


t.test(Ozone ~ Garden.location, data = ozone)












