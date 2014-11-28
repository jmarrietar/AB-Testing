setwd("C:/Users/JosePortatil/Dropbox/Data Science/Team_Leada/AB_Testing")

conversion_data<-read.csv('landing_page_data.csv',header=TRUE)

#We want to determine if the convertion rate 
#for landing page B is higher than the rate for A

sum(conversion_data$b)

sum(conversion_data$a,na.rm=T)

#Z-test and T-Test

#Z-test
#The two samples must be indepedent. 
#The samples sizes must be large enough(>30) for the normal
#distribution to apply. 
#samples randomly selected. 



