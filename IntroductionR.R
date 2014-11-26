startup_data<-read.csv('crunchbase_monthly_export.csv',header=T,stringsAsFactors=F)
head(startup_data)
tail(startup_data)
nrow(startup_data)
ncol(startup_data)
colnames(startup_data)

#Vector Operations. 
my_vector<-c(2,14,10,15,3)
my_vector

my_vector*2

my_vector+my_vector
my_vector[1]
my_vector[1:3]

my_vector[-2]
my_vector[my_vector>2]


#byrow=True means fill the matrix by rows. 

my_matrix<-matrix(1:6,ncol=3,nrow=2,byrow=TRUE)


my_matrix[,1:2]

is.data.frame(startup_data)
is.matrix(startup_data)



startup_data$name[1:50]

young_startups<-startup_data$founded_year>2012

young_startups[1:10]
startup_data$founded_year[1:10]

sum(young_startups,na.rm=TRUE)
startup_data$name[1]

sum(young_startups$,na.rm=TRUE)

colnames(startup_data)

sum(startup_data$state_code=="NY")

sum(startup_data[1:50,]$funding_rounds)

hist(startup_data$funding_rounds,main="Series A crunch",xlab="Fuding Rounds",ylab="# of startups",xlim=c(1,15))

par(bg="#36394A",col="white",fg="white",col.axis="white",col.lab="white",col.main="white",family="Verdana")

############## Data Munging #####################
class_data<-read.csv('classes.csv',header=T,stringsAsFactors=F)
head(class_data)
str(class_data)

#The match function is used to determine matched values between vectors or data frames.
#To find the students who are in both class A and class B and return 0 if no match:


match(class_data$A,class_data$B,nomatch=0)

class_data$A[14]
class_data$A[23]
class_data$B[29]
class_data$B[20]

#You can also use the syntax 
#%in% which checks for a match 
#and returns a logical vector. 
#The logical vector matches is FALSE for values
#with no match and TRUE for values with a match.

matches<-class_data$A %in% class_data$B
matches
class_data$A[matches]

quiz_class_data<-read.csv('classes_test.csv',header=T, stringsAsFactors=F)

head(quiz_class_data)

quiz_class_data[quiz_class_data$A=="Trina",]

match(quiz_class_data$A,quiz_class_data$B,nomatch=0)

quiz_class_data$A[36]
quiz_class_data$B[12]