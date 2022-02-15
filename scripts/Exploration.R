rm(list=ls()) #This clears all data from the environment ensuring you do not accidently use data or functions from other scripts in this script
#Load packages ##################
library(ggplot2) #Load packages makes plots
library(reshape2) #Reshape2 contains melt()
#Create functions ############################
SEM<-function(x){sd(x)/sqrt(length(x))}
#load data ##########################
data<-read.csv("data/soilDataAll.csv")
dataClimate<-read.csv("data/climateData.csv")




#######What does this code do ########################
d<-read.csv("data/soilDataAll.csv")
d2<-d[d[,23]=="destruction",is.na(d[d[,23],][1,])==F]
#Quite an extreme example 


############### This is much more clear! ############################
dataSoil<-read.csv("data/soilDataAll.csv")
dataSoilTemp<-dataSoil[dataSoil$method=="destruction",]#Select rows in which dataSoil$method is destruction &
dataSoilDestruction<-dataSoilTemp[,is.na(dataSoilTemp[1,])==F] #only use columns which do not have NAs in row 1

#Use variable names/data frame names that make sense
#Annotate to show what lines of code do
#Sometimes it is is better to split up code in multiple lines/steps to show what it does
#Shorter code may look fancy but is not always more understandable (Although code golf can be fun ;))

############# wrangle the data ###############

#The soil data has 2 different depth at which measurements took place. We want to use the mean of these data points
#and afterwards combine it with the climate data

soilDataPerPop<-aggregate(.~pop2,data=dataSoilDestruction[-c(15,16)],FUN=mean)  #calculate the mean per pop with aggregate
                                                                                #I removed the 15th and 16th column as
                                                                                #these were not numeric

#Combine data ####################################
dataClimate<-read.csv("data/climateData.csv") #Load climate data

#One data set concerns soil conditions at certain locations, the other climate data. But the populations are the same. 

dataCombined<-merge(dataClimate,soilDataPerPop,by="pop2") #Combine data sets based on popname!


#Explore the data make a plot! ####################
#Make a first plot to look at where to populations are and their locations
ggplot(dataCombined,aes(x=latitude,y=longitude,col=meta.population))+ #Plot the populations locations
  geom_point(size=4)
ggsave("scratch/popLocations.png")


#Combined data has everything we want! we can now write it as a new data file
write.csv(dataCombined,"data/dataCombined.csv")

#Take a look at what code is necessary to get to this point! And recreate this in a new script to generate the dataCombined


