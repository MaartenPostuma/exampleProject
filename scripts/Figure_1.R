rm(list=ls())
#Analysis! #####################
library(ggplot2)
#Read the combined data
dataCombined<-read.csv("data/dataCombined.csv")

#Make the plot! 
ggplot(dataCombined,aes(x=Na,y=Al))+geom_point(size=4,aes(col=meta.population))+theme_bw()
ggsave('results/Figures/Figure_1.png')


#Do the statistics
summary(lm(Na~Al,dataCombined))
  
