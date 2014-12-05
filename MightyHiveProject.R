#MightyHive is an advertising technology company that uses 
#retargeting methods to send ads to users online.

#Call Center Remarketing, -> retarget those consumers
#online whom did not make a purchase.

setwd("C:/Users/Alfonso/Desktop/JOM/AB-Testing")

Abandoned_Data<-read.csv("Abandoned_Data_Seed.csv",header=TRUE)
Reservation_Data<-read.csv("Reservation_Data_Seed.csv",header=T)
###################################################################
#################DATA WRANGLING PART ##############################
###################################################################

#Important
#DIDNT WORK WITH %IN% command because NA values!!. 
#I IMplemented MATCH() function insted. 

#------------------ %in% function failed because of NA values in data set. 
Email_matches<-Abandoned_Data$Email %in% Reservation_Data$Email
Zipcode_matches<-Abandoned_Data$Zipcode %in% Reservation_Data$Zipcode
length(Email_matches)
length(Zipcode_matches)
#--------------------------------------------------------------------

#Lets Try with Match function. 
table(match(Abandoned_Data$Email, Reservation_Data$Email, nomatch = 0))
sum((match(Abandoned_Data$Contact_Phone, Reservation_Data$Contact_Phone, nomatch = 0))>0)

length(which(Reservation_Data$Test_Contro=='test'))

#Every caller that abandoned their phone call to the call center 
#was randomly split into test and control groups with an approximate 50/50 split.


#The abandoned observations in the test group were then 
#re-targeted with advertisements online for a period of 7 days.

#The control group was never shown any advertisements.

#How many more conversions (if any) occured in the test group?
#Rta/ first determining the number of individuals whom exist in both datasets. This match indicates a caller who abandoned their
#purchase but then came back and made a reservation.

#If an Abandoned client made  a purchase then his mail will appear in the reservation data.
#I create matches between emails. 

#Data cleaning: 
#The effectiveness of MightyHive's retargeting product is 
#qualified only by the conversion of a customer the first time and not any additional reservations.

#WE NEED TO REMOVE DUPLICATE in Reservation Data. 

# Original data with repeats removed. These do the same:
unique(Reservation_Data)
Abandoned_Data_Clean<-Abandoned_Data[!duplicated(Abandoned_Data$Contact_Phone),]
Reservation_Data_Clean<-Reservation_Data[!duplicated(Reservation_Data$Contact_Phone),]



Email_matches<-Abandoned_Data_Clean$Email %in% Reservation_Data_Clean$Email
Email_matches2<-Abandoned_Data$Email %in% Reservation_Data_Clean$Email
Zipcode_matches<-Abandoned_Data_Clean$Zipcode %in% Reservation_Data_Clean$Zipcode
Contact_Phone_matches<-Abandoned_Data_Clean$Contact_Phone %in% Reservation_Data_Clean$Contact_Phone

length(Contact_Phone_matches)






#AB testing phase: 
# I want to see if the Reservation rate for test group is higher than for control group. 
#Difference between Reservation rates between test group and control group. 

#If that is the case the the retargeting is sucessfull. 

#Null hypothesis: the difference of Reservation rates between test group and control is equal to 0

#Alternative hypothesis: the difference of Reservation rates between test group and control is greater than 0.
#Sample size>30 the Z test. 
#The t.test() function in R can quickly perform the statistical analysis and recognizes the greater than 30 sample size, thereby using the normal distribution.

#Seria contar los que comprar test/ Total de los de Test y compraron control/ Total de control


#NOTE: There is an ERROR in the submission checking. It says WRONG!: 



