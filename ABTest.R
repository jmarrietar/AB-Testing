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

#Hypothesis Testing 
#Examine random sample of population
#Here you test a clain abaout a population parameter.

#The null hypothesis -> Statement abaout population assumed to be true

#Performing the Z-test

#Our sample statistic we now must normalize it. 
#This is done by converting it to a z-score. 
#Normal distribution is also known as Z-score. 

#There is a formula to calculate a Z score for two proportions. 

#p1: the conversion rate of our test landing page B
#p2: the conversion rate of our control landing page A
#Y1: the number of successes in our test landing page B
#Y2: the number of successes in our control landing page A
#n1: total sample size of A
#n2: total sample size of B
#p: pooled proportion


#The test statistic is the observed difference between the test conversion and the 
#control conversion. p1-p2

 #p1 p2 proportion of 1s in the two columns respectively. 
a_obs<-na.omit(conversion_data$a)

b_obs<-conversion_data$b

a_proportion<-sum(a_obs)/length(a_obs)
b_proportion<-sum(b_obs)/length(b_obs)

#What are the ods of getting this statistic again. 

test_statistic<-b_proportion-a_proportion

#Pooled proportion 

pooled_proportion<-(sum(a_obs)+sum(b_obs))/(length(a_obs)+length(b_obs))

#Standard error<- Variability of oru test statistic inits sampling distribution. 
#This is the denominator or ecuation. 

denominator=sqrt(pooled_proportion*(1-pooled_proportion)*((1/length(a_obs))+(1/length(b_obs))))

Z=test_statistic/denominator

#Z-score Is: 
#How many standard deviations our observed test statistics
#calculates assuming the null hypothesis is true. 

#Pvalue
#pnorm calculates the area under the normal curve to the right of our Z score. 
p_value<-pnorm(Z,lower.tail=F)
p_value

#Confidence Intervals for the Difference Between Proportions. 

###############################
###############################
#USING R FUNCTION FOR T STATISTICS. 

t.test(b_obs,a_obs)

#This is a two sided test so the p value must be divided by 2



