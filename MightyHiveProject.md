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








