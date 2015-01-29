#This dataset and problems are based off 
#of the take-home portion of an interview
#for an analyst position in New York.
setwd("C:/Users/Alfonso/Desktop/JOM/AB-Testing")

Delivery_Data<-read.csv("Delivery_Data_problem.csv",header=T,)

#What is the most popular business in terms of delivery frequency?
sort(table(Delivery_Data$pickup_name))

#What is the zipcode of the most popular location for that business?
Safeway<-subset(Delivery_Data, pickup_name=="Safeway")
sort(table(Safeway$pickup_zipcode))

#What is the second most popular business in terms of delivery frequency?
#What is the zipcode of the most popular location for that business?
Whole_Foods_Market<-subset(Delivery_Data, pickup_name=="Whole Foods Market")
sort(table(Whole_Foods_Market$pickup_zipcode))

Pizzeria_Delfina<-subset(Delivery_Data, pickup_name=="Pizzeria Delfina")
sort(table(Pizzeria_Delfina$pickup_zipcode))

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

######################################################################
######################################################################

#Using gsub() functions. 
Delivery_Data$pickup_name<-gsub('Safeway','Safeway-H1',Delivery_Data$pickup_name,fixed=TRUE)
Delivery_Data$pickup_name<-gsub('Whole Foods Market','Whole Foods Market-H2',Delivery_Data$pickup_name,fixed=TRUE)
Delivery_Data$pickup_name<-gsub('Pizzeria Delfina','Pizzeria Delfina-H3',Delivery_Data$pickup_name,fixed=TRUE)

#What is the total number of deliveries identified as coming from a 'hotspot' labeled business?
Delivery_Data$pickup_name[grep('[[:alpha:]]+\\-+[H]+[[:digit:]]',Delivery_Data$pickup_name)]


#Weekend late-night deliveries
#These deliveries are defined as anytime between 11PM and 3:59AM on Fridays and Saturdays

str(Delivery_Data$date_created_local)

mydate <- factor("2014-03-01 00:01:44.538420-08:00")

