library(tidyverse)
library(dplyr)
library(ggplot2)
  US <- read.csv('US_Accidents.csv')
  
  ACC <- US %>% select(Severity,Start_Time,State,Temperature.F.,Humidity...,Visibility.mi.,Wind_Direction,Weather_Condition,Sunrise_Sunset)
  str(ACC)
  names(ACC)[names(ACC)=="Start_Time"]<-"Occurrence_Start"
  names(ACC)[names(ACC)=="Temperature.F."]<-"Temperature"
  names(ACC)[names(ACC)=="Humidity..."]<-"Humidity"
  names(ACC)[names(ACC)=="Visibility.mi."]<-"Visibility"
  names(ACC)[names(ACC)=="Sunrise_Sunset"]<-"Period"
  ACC <- ACC %>% mutate(Period=recode(Period, "Day" = "DayTime", "Night" = "NightTime"))
  
  ACC <- ACC %>% mutate_if(is.character,as.factor)
  ACC <- ACC %>% filter(!is.na(Severity))
  ACC <- ACC %>% filter(!is.na(Temperature))
  ACC <- ACC %>% filter(!is.na(Visibility))
  ACC <- ACC %>% filter(!is.na(Humidity))
  str(ACC)
  summary(ACC)
  
  ggplot(data = ACC,mapping = aes(x = Severity)) + 
    geom_histogram(color = "black", fill = "red") +
    ggtitle("Severity Distribution")
  ggplot(data = ACC,mapping = aes(x = Temperature)) +
    geom_histogram(color = "black", fill = "pink") +
    ggtitle("Temperature Distribution")
  ggplot(data = ACC,mapping = aes(x = Visibility)) +
    geom_histogram(color = "black", fill = "orange") +
    ggtitle("Visibility Distribution")
  ggplot(data = ACC,mapping = aes(x = Humidity)) +
    geom_histogram(color = "black", fill = "blue") +
    ggtitle("Humidity Distribution")
  
  ACC %>% filter(Period!="") %>% ggplot() +  geom_bar(aes(x = Severity, fill = Period), position = "dodge")
  ggplot(ACC) + geom_bar(aes(x = Severity, fill = State), position = "stack")
  ACC %>% filter(Period!="") %>% ggplot() + geom_bar(aes(x = Severity,fill = Period), position = "fill")
+  