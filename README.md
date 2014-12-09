AB-Testing
==========

My first course on TeamLeada. 

The project in this course was about MightyHive. 

MightyHive is an advertising technology company that uses retargeting methods to send ads to users online.
One product, Call Center Remarketing, uses call center log data to retarget those consumers online whom did not make a purchase.

DATA

The results of the advertising campaign for Martin's Travel Agency are given in the following two datasets:

The Abandoned Dataset: Download here

Observations in the Abandoned Dataset are individuals who called into Martins Travel Agency's call center but did not make a purchase.
The Reservation Dataset: Download here

Observations in the Reservation Dataset are the customers who called into Martins Travel Agency's call center and made a reservation.
The schema for both of the datasets is provided below:

Caller_ID - A unique ID generated for every incoming phone call to the call center
Session - The Year/Month/Day/Time of each incoming phone call to the call center
Incoming_Phone - Phone number identified using caller indentification
Contact_Phone - Phone number the caller submits
Test_Control - Experiment tag

EXPERIMENT DETAILS
Every caller that abandoned their phone call to the call center was randomly split into test and control groups with an approximate 50/50 split.

The abandoned observations in the test group were then re-targeted with advertisements online for a period of 7 days.

The control group was never shown any advertisements.
