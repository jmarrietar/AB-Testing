#MightyHive is an advertising technology company that uses 
#retargeting methods to send ads to users online.

#Call Center Remarketing, -> retarget those consumers
#online whom did not make a purchase.

setwd("C:/Users/Alfonso/Desktop/JOM/AB-Testing")

Abandoned_Data<-read.csv("Abandoned_Data_Seed.csv",header=TRUE,na.strings = "")
Reservation_Data<-read.csv("Reservation_Data_Seed.csv",header=T,na.strings = "")
###################################################################
#################DATA WRANGLING PART ##############################
###################################################################


###################################################################
########################FAILED ATEMPS##############################
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

#Lets Try with Match function. --- Kind of Failed Again
table(match(Abandoned_Data$Email, Reservation_Data$Email, nomatch = 0))
table(match(Abandoned_Data$Incoming_Phone, Reservation_Data$Incoming_Phone, nomatch = 0))

sum((match(Abandoned_Data$Incoming_Phone, Reservation_Data$Incoming_Phone, nomatch = 0))>0)

Abandoned_Data$Incoming_Phone[7393]

#------------------------%In% funtion But removing NA values. 
AData_Email<-Abandoned_Data$Email[!is.na(Abandoned_Data$Email)]
RData_Email<-Reservation_Data$Email[!is.na(Reservation_Data$Email)]

Email_matches<-AData_Email %in% RData_Email
sum(Email_matches>0)
#---------------------------------------------------------------

#######################################################################
########################SUCESSFULL ATEMPS##############################
#######################################################################
#THIS FINALLY WORKS. Cleaning NA and Finding Matches
#Clean NA rows with NA values in Incoming phones (cleaning) and then Use IN function. 
#Remove rows with NA values in Incoming Phones column!
AData<-subset(Abandoned_Data, !is.na(Incoming_Phone))
RData<-subset(Reservation_Data, !is.na(Incoming_Phone))

Incoming_Phone_matches<-AData$Incoming_Phone %in% RData$Incoming_Phone
sum(Incoming_Phone_matches>0)

#Select only the matches from the data set
AData_Clean<-AData[Incoming_Phone_matches,]

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


#Select only the matches from the data set
AData_Clean<-AData[Incoming_Phone_matches,]

#Now, We need to remove duplicated values from the Data base which the matches. 
AData_Clean_Unique<-AData_Clean[!duplicated(AData_Clean$Incoming_Phone),]

AData_Unique<-unique(AData)

###################################################################
##################### AB TESTING PART #############################
###################################################################
#Every caller that abandoned their phone call to the call center 
#was randomly split into test and control groups with an approximate 50/50 split.

#The abandoned observations in the test group were then 
#re-targeted with advertisements online for a period of 7 days.
#The control group was never shown any advertisements.

#I want to see if the Reservation rate for test group is higher than for control group. 
#Difference between Reservation rates between test group and control group. 

#If that is the case the the retargeting is sucessfull. 

#Null hypothesis: the difference of Reservation rates between test group and control is equal to 0

#Alternative hypothesis: the difference of Reservation rates between test group and control is greater than 0.
#Sample size>30 the Z test. 
#The t.test() function in R can quickly perform the statistical analysis and recognizes the greater than 30 sample size, thereby using the normal distribution.


#Count the number of matches with the label 'test' and 'control' respectively. (From Unique and Clean data base  of matches)
test_obs<-sum(AData_Clean_Unique[,12]=="test")
control_Obs<-sum(AData_Clean_Unique[,12]=="control")
##Count the number of rows the label 'test' and 'control' respectively from Unique original Abandoned data.
AData_total_test<-sum(AData_Unique[,12]=="test")
AData_total_control<-sum(AData_Unique[,12]=="control")
#Get proportion of the values above. 
test_proportion<-test_obs/AData_total_test
control_proportion<-control_Obs/AData_total_control

#Get Z statistic

#What are the ods of getting this statistic again. 

test_statistic<-test_proportion-control_proportion

#Pooled proportion 

pooled_proportion<-(sum(test_obs)+sum(control_Obs))/(AData_total_test+AData_total_control)
#Standard error<- Variability of oru test statistic inits sampling distribution. 
#This is the denominator or ecuation. 

denominator=sqrt(pooled_proportion*(1-pooled_proportion)*((1/AData_total_test)+(1/AData_total_control)))
SE=denominator
Z=test_statistic/denominator

#Z-score Is: 
#How many standard deviations our observed test statistics
#calculates assuming the null hypothesis is true. 

#Pvalue
#pnorm calculates the area under the normal curve to the right of our Z score. 
p_value<-pnorm(Z,lower.tail=F)
p_value

#Confidence intervals. 
upper_bound <- test_proportion - control_proportion + 1.96*SE
lower_bound <- test_proportion - control_proportion - 1.96*SE


