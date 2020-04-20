##DOWNLOAD FILE
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD&bom=true&format=true"
download.file(fileUrl,"./data/baltimore fixed speed cameras dataset/cameras.csv",method = "curl")



##XML Parsing

library(XML)
library(RCurl)
fileURL <- "https://www.w3schools.com/xml/simple.xml"
xData <- getURL(fileURL)
doc <- xmlParse(xData)

#to get the root node with its all childrens
rootNode <- xmlRoot(doc)
#to get name of root node
xmlName(rootNode)
#to get name of all the nested nodes(only one level nested)
names(rootNode)

##DIRECT ACCESS TO PARTS OF XML DOCUMENT

#1
#it will return the 1st nested element of the document
rootNode[[1]]
####OUTPUT
# <food>
#   <name>Belgian Waffles</name>
#   <price>$5.95</price>
#   <description>Two of our famous Belgian Waffles with plenty of real maple syrup</description>
#   <calories>650</calories>
#   </food> 

  
  
#2
#it will return the 1st element in that parent node
rootNode[[1]][[1]]
####OUTPUT
#name>Belgian Waffles</name> 

#it will return the 2nd element in that parent node
rootNode[[1]][[2]]
####OUTPUT
#<price>$5.95</price> 


#3
#it will print all the data insides the node
xmlSApply(rootNode,xmlValue)



##XML PATH FUNCTIONS
#1
xpathSApply(rootNode,"//name",xmlValue)

##OUTPUT
# [1] "Belgian Waffles"            
# [2] "Strawberry Belgian Waffles" 
# [3] "Berry-Berry Belgian Waffles"
# [4] "French Toast"               
# [5] "Homestyle Breakfast" 


#2
xpathSApply(rootNode,"//price",xmlValue)

##OUTPUT
#[1] "$5.95" "$7.95" "$8.95" "$4.50" "$6.95"




##JSON reading
library(jsonlite)

jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)


#converting data to JSON
myjson <- toJSON(iris,pretty = TRUE)
myjson


#back to orginal form from JSON
iris2 <- fromJSON(myjson)
head(iris2)




##DATA.TABLE package

library(data.table)
DT=data.table(x = rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(DT,4)

#subsetting rows in table
DT[2,]

#subsetting where y=a
DT[DT$y=="a",]

#Using function in index
DT[,list(mean(x),sum(z))]

#Adding new columns
DT[,w:=z^2]       ##it will add column to the table without replicating the orignal table as data.frame doesn't

#Assigning data to new variable
DT2 <- DT       ##any changes occur in DT will reflect in DT2
                ##to stop this use copy function to copy data to another variable

#MULTIPLE OPERATION
DT[,m:={tmp <- (x+z); log2(tmp+5)}]

#plyr like operation
DT[,a:=x>0]

##by=a means grouped by a
DT[,b:=mean(x+w),by=a]

DT1 <- data.table(x=sample(letters[1:3],1E5,TRUE))
##.N counts the number of times grouped by varaible by x
DT1[,.N,by=x]


##KEYS

DT2 <- data.table(x = rep(c("a","b","c"),each = 100),y = rnorm(300))
setkey(DT2,x)
DT2['a']


##JOINS USING KEYS

DT1 <- data.table(x = c('a','a','b','dt1'),y = 1:4)
DT2 <- data.table(x = c('a','b','dt2'),z = 5:7)
setkey(DT1,x)
setkey(DT2,x)
merge(DT1,DT2)

