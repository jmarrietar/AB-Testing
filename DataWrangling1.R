#This dataset and problems are based off 
#of the take-home portion of an interview
#for an analyst position in New York.
setwd("C:/Users/Alfonso/Desktop/JOM/AB-Testing")

Delivery_Data<-read.csv("Delivery_Data_problem.csv",header=T,)

sort(table(Delivery_Data$pickup_name))

Safeway<-subset(Delivery_Data, pickup_name=="Safeway")

sort(table(Safeway$pickup_zipcode))

Whole_Foods_Market<-subset(Delivery_Data, pickup_name=="Whole Foods Market")

sort(table(Whole_Foods_Market$pickup_zipcode))

colnames(Delivery_Data)
#What is the average delivery duration time for customer ratings of 5? Round to a whole number.
mean((Delivery_Data[Delivery_Data[,15]=="5",])[,12])

mean((Delivery_Data[Delivery_Data[,15]=="1",])[,12])

#Find the additional duration time on average that is incurred 
#when a delivery is reassigned once or more.
(mean((Delivery_Data[Delivery_Data[,13]>0,])[,12]) - mean((Delivery_Data[Delivery_Data[,13]==0,])[,12]))/60


#What is the average rating by customer of the people that were reassigned? 
#Round to the nearest hundreth.
#First Convert None to NA
Delivery_Data$rating_by_customer[Delivery_Data$rating_by_customer=="None"] <- NA

mean(as.integer((Delivery_Data[Delivery_Data[,13]>0,])[,15]),na.rm=TRUE)

#What is the average rating by customer of the people that were not reassigned?
#Round to the nearest hundreth.

mean(as.integer((Delivery_Data[Delivery_Data[,13]==0,])[,15]),na.rm=TRUE)

