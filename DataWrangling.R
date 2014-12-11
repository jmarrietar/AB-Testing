quiz_class_data<-read.csv('classes_test.csv',header=TRUE)
class_data<-read.csv('classes.csv',header=TRUE)
#List of students that are not in both Classes

my_vector<-c(1,2,3,4,5)
my_logical_vector<-c(TRUE,TRUE,FALSE,FALSE,FALSE)

my_vector[my_logical_vector]

#Note-> The vector index and the logical vector must be the same length. 

quiz_matches<-quiz_class_data$A %in% quiz_class_data$B

quiz_class_data$A[!quiz_matches]

#Which() Explained 
#Select indices of a true condition. 

#Select class A of the Data set. 

class_A<-quiz_class_data[,c(1,2)]
class_B<-quiz_class_data[,c(3,4)]

soph_rows<-which(class_A$A.Year=='Sophomore')

#We can use the index returned to return only the sophomores in the class. 

sophomores <- class_A[soph_rows,]

which(class_A$A.Year=='Junior' | class_A$A.Year=='Senior')


JunB<-which(class_B$B.Year=='Junior')
LenJB<-nrow(class_B[JunB,])

JunA<-which(class_A$A.Year=='Junior')
LenJA<-nrow(class_A[JunA,])

LenJA-LenJB

length(which(class_A$A.Year=='Junior'))-length(which(class_B$B.Year=='Junior')
                                               
#DUPLICATE() EXPLAINED

#Determines which elements of a vector or data frame
#are duplicated and returns a logical vector. 

duplicates<-duplicated(class_data$A.Year)
duplicates[1:10]



# A sample data frame:
df <- read.table(header=T, text='
                 label value
                 A     4
                 B     3
                 C     6
                 B     3
                 B     1
                 A     2
                 A     4
                 A     4
                 ')


# Is each row a repeat?
duplicated(df)
# FALSE FALSE FALSE  TRUE FALSE FALSE  TRUE  TRUE

# Show the repeat entries
df[duplicated(df),]
# label value
#     B     3
#     A     4
#     A     4

# Show unique repeat entries 
unique(df[duplicated(df),])
# label value
#     B     3
#     A     4

# Original data with repeats removed. These do the same:
unique(df)
df[!duplicated(df),]
# label value
#     A     4
#     B     3
#     C     6
#     B     1
#     A     2
                                               