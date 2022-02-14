####Data exploration ##################################

#Goal look at differences between meta population in 


############################

rm(list=ls()) #This clears all data from the environment ensuring you do not accidently use data or functions from other scripts in this script




#Load packages ##################
library(ggplot2) #Load packages makes plots
library(reshape2) #Reshape2 contains melt()


#load data ##########################

dataSoil<-read.csv("data/soilDataAll.csv") #Load soil data
dataClimate<-read.csv("data/climateData.csv") #Load climate data

#Look in to data ################

View(dataSoil) #Opens data in another tab
View(dataClimate) 
str(dataSoil) #Shows the data structure
str(dataClimate) 
head(dataSoil) #Prints the first lines of a data.frame
head(dataClimate)


#####Subset the soildata to only contain destruction

dataSoilDestruction<-dataSoil[dataSoil$method=="destructie",]


#Combine data ####################################

#We have two raw data sets which we want to combine (dataClimate,dataSoilDestruction)
#One data set concerns soil conditions at certain locations, the other climate data. But the populations are the same. 
#The climate data also contains the population.size for each population

dataCombined<-merge(dataClimate,dataSoilDestruction,by="pop2") #Combine data sets based on popname!
dataCombined

dataCombined
ggplot(dataCombined,aes(x=Fe,y=population.size,col=meta.population))+ #Plot population size  as a function of 
  geom_point()                                                  #one of the variables

#Notice something fishy going on with population sizes
#The ">5000" causes it to be read as character instead of numeric

dataCombined$population.size[dataCombined$population.size==">5000"]<-5000 #Change the character in to a number
dataCombined$population.size<-as.numeric(dataCombined$population.size)

ggplot(dataCombined,aes(x=Fe,y=population.size,col=meta.population))+ #Plot population size  as a function of 
  geom_point()                                                  #one of the variables


#For loop example over all populations:


newData<-data.frame()
for(i in 1:length(unique(dataSoil$pop2))){
  print(i)
  newData[i,1]<-mean(dataSoil$pH[i],na.rm=T)
}
newData



newData<-data.frame()
for(i in 1:length(unique(dataSoil$pop2))){
  print(i)
  newData[i,1]<-mean(dataSoil$pH[i],na.rm=T)
}
newData
