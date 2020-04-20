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
