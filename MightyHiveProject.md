MightyHiveProject
========================================================

Slides at -> https://docs.google.com/presentation/d/19r8WcwQ9JJEmJ7KaFPnsjeKM_o9GyptDmru_s2iFWQ0/pub?start=false&loop=false&delayms=3000

MightyHive is an advertising technology company that uses retargeting methods to send ads to users online.

One product, Call Center Remarketing, uses call center log data to retarget those consumers online whom did not make a purchase.

## Data

The results of the advertising campaign for Martin's Travel Agency are given in the following two datasets:

The Abandoned Dataset: 

Observations in the Abandoned Dataset are individuals who called into Martins Travel Agency's call center but did not make a purchase.
The Reservation Dataset: 

Observations in the Reservation Dataset are the customers who called into Martins Travel Agency's call center and made a reservation.
The schema for both of the datasets is provided below:

Caller_ID - A unique ID generated for every incoming phone call to the call center
Session - The Year/Month/Day/Time of each incoming phone call to the call center
Incoming_Phone - Phone number identified using caller indentification
Contact_Phone - Phone number the caller submits
Test_Control - Experiment tag

## Load Data


```r
setwd("C:/Users/Alfonso/Desktop/JOM/AB-Testing")
Abandoned_Data <- read.csv("Abandoned_Data_Seed.csv", header = TRUE, na.strings = "")
Reservation_Data <- read.csv("Reservation_Data_Seed.csv", header = T, na.strings = "")
```



## Data Wrangling 
*Matches = People that abandoned but reserved later ( could have been retargeted or not).

*Select matches rows in database by Incoming_Phone Column. [Remove rows with NA values in column]

*Clean NA rows with NA values in Incoming phones (cleaning) and then Use IN function. 
Remove rows with NA values in Incoming Phones column!


```r
AData <- subset(Abandoned_Data, !is.na(Incoming_Phone))
RData <- subset(Reservation_Data, !is.na(Incoming_Phone))

Incoming_Phone_matches <- AData$Incoming_Phone %in% RData$Incoming_Phone
sum(Incoming_Phone_matches > 0)
```

```
## [1] 327
```



### Data cleaning: 
The effectiveness of MightyHive's retargeting product is qualified only by the conversion of a customer the first time and not any additional reservations.

*Create new DataBase with these matches and Remove duplicated data [AData_Clean_Unique].


```r
# Select only the matches from the data set
AData_Clean <- AData[Incoming_Phone_matches, ]

# Now, We need to remove duplicated values from the Data base which the
# matches.
AData_Clean_Unique <- AData_Clean[!duplicated(AData_Clean$Incoming_Phone), ]

AData_Unique <- unique(AData)
```



## AB TESTING
We need to know if there is a statistical difference between the persons that reserved from the test group and the ones from the control group.  We need an A/B Test. 

If that is the case the the retargeting is sucessfull. 

*Null hypothesis: the difference of Reservation rates between test group and control is equal to 0

*Alternative hypothesis: the difference of Reservation rates between test group and control is greater than 0.


```r
# Count the number of matches with the label 'test' and 'control'
# respectively. (From Unique and Clean data base of matches)
test_obs <- sum(AData_Clean_Unique[, 12] == "test")
control_Obs <- sum(AData_Clean_Unique[, 12] == "control")

## Count the number of rows the label 'test' and 'control' respectively
## from Unique original Abandoned data.
AData_total_test <- sum(AData_Unique[, 12] == "test")
AData_total_control <- sum(AData_Unique[, 12] == "control")
```


*Test Reservation rate = Matches with Test attribute / Total number of people in test group from  abandoned data. 
*Control Reservation rate = Matches with control attribute / Total number of people in control  group from  abandoned data

```r
# Get proportion of the values above.
test_proportion <- test_obs/AData_total_test
control_proportion <- control_Obs/AData_total_control
```


*Get Z statistic
A Z test would be appropriate Because Sample size>30.

```r
# What are the ods of getting this statistic again.
test_statistic <- test_proportion - control_proportion

# Pooled proportion
pooled_proportion <- (sum(test_obs) + sum(control_Obs))/(AData_total_test + 
    AData_total_control)
# Standard error<- Variability of oru test statistic inits sampling
# distribution.  This is the denominator or ecuation.

denominator = sqrt(pooled_proportion * (1 - pooled_proportion) * ((1/AData_total_test) + 
    (1/AData_total_control)))
SE = denominator
Z = test_statistic/denominator
```




*Z-score Is: 


```r
# How many standard deviations our observed test statistics calculates
# assuming the null hypothesis is true.
Z
```

```
## [1] 10.17
```


Pvalue

```r
# pnorm calculates the area under the normal curve to the right of our Z
# score.
p_value <- pnorm(Z, lower.tail = F)
p_value
```

```
## [1] 1.324e-24
```


Confidence intervals. 

```r
upper_bound <- test_proportion - control_proportion + 1.96 * SE
lower_bound <- test_proportion - control_proportion - 1.96 * SE
```


## Final observations

* P value  1.324094e-24 almost zero , so there is very little chance to be wrong if we reject the null hypothesis. 
* Therefore there is an difference of reservation rate between test group and control group. 
-shortfalls: 
* There are very blank spaces and NA values in the data sets. The db had to be  cleaned and get rid of a lot of rows.  
* The same client might have called from different phones and might be counted twice. 

## Conclusion 
The retargeting strategy was sucessfull! . 

