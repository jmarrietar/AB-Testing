#This dataset and problems are based off 
#of the take-home portion of an interview
#for an analyst position in New York.
setwd("C:/Users/Alfonso/Desktop/JOM/AB-Testing")

Delivery_Data<-read.csv("Delivery_Data_problem.csv",header=T)

sort(table(Delivery_Data$pickup_name))

sort(table(Delivery_Data$dropoff_zipcode))

sort(table(Delivery_Data[Delivery_Data[,18]=="Safeway",][,14]))
colnames(Delivery_Data)
#What is the average delivery duration time for customer ratings of 5? Round to a whole number.
mean((Delivery_Data[Delivery_Data[,15]=="5",])[,12])

mean((Delivery_Data[Delivery_Data[,15]=="1",])[,12])

#Find the additional duration time on average that is incurred 
#when a delivery is reassigned once or more.
(mean((Delivery_Data[Delivery_Data[,13]>0,])[,12]) - mean((Delivery_Data[Delivery_Data[,13]==0,])[,12]))/60

#What is the average rating by customer of the people that were reassigned? 
#Round to the nearest hundreth.
mean(as.integer((Delivery_Data[Delivery_Data[,13]>0,])[,15]),na.rm=TRUE)

#What is the average rating by customer of the people that were not reassigned?
#Round to the nearest hundreth.

mean(as.integer((Delivery_Data[Delivery_Data[,13]>0,])[,15]))
