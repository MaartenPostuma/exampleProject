rm(list=ls())


dataClimate<-read.csv("data/climateData.csv")
dataSoil<-read.csv("data/soilDataAll.csv")

#Get the destruction data
dataSoilTemp<-dataSoil[dataSoil$method=="destruction",]#Select rows in which dataSoil$method is destruction &
dataSoilDestruction<-dataSoilTemp[,is.na(dataSoilTemp[1,])==F] #only use columns which do not have NAs in row 1

#The soil data has 2 different depth at which measurements took place. We want to use the mean of these data points
#and afterwards combine it with the climate data

soilDataPerPop<-aggregate(.~pop2,data=dataSoilDestruction[-c(15,16)],FUN=mean)  #calculate the mean per pop with aggregate


#############Combine the data ##############

dataCombined<-merge(dataClimate,soilDataPerPop,by="pop2") #Combine data sets based on popname!
write.csv(dataCombined,"data/dataCombined.csv")
