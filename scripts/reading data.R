##R HDF5 PACKAGES

#installing package through bioconductor
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install(version = "3.10")  #for version 3.10

BiocManager::install("rhdf5")

library(rhdf5)
#creating hdf5 file
created = h5createFile("hdf5 example.h5")


 #creating groups inside the file
created = h5createGroup("hdf5 example.h5","foo")
created = h5createGroup("hdf5 example.h5","baa")
created = h5createGroup("hdf5 example.h5","foo/foobaa")
#listing out the component of file
h5ls("hdf5 example.h5")


#writing to groups
A = matrix(1:10,nrow = 5 ,ncol = 2)
h5write(A,"hdf5 example.h5","foo/A")
B = array(seq(0.1,2.0,by = 0.1),dim = c(5,2,2))
attr(B,"scale") <- "liter"
h5write(B,"hdf5 example.h5","foo/foobaa/B")
#listing out the component of file
h5ls("hdf5 example.h5")


#write data set
df = data.frame(1L:5L,seq(0,1,length.out = 5),
                c("ab","cde","fghi","a","s"),stringsAsFactors = FALSE)

h5write(df,"hdf5 example.h5","df")
#listing out the component of file
h5ls("hdf5 example.h5")


#reading data
readA = h5read("hdf5 example.h5","foo/A")
readB = h5read("hdf5 example.h5","foo/foobaa/B")
readdf = h5read("hdf5 example.h5","df")
readA


#writing and reading in chunks
h5write(c(12,13,14),"hdf5 example.h5","foo/A",index = list(1:3,1))
h5read("hdf5 example.h5","foo/A")





##SCRAPING DATA/ READING FROM THE WEB

con <- url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode <- readLines(con)
close(con)
htmlCode


#Using XML
library(XML)
library(RCurl)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
Data <- getURL(url)
html <- htmlParse(Data)

xpathSApply(html,"//title",xmlValue)


#using httr package
library(httr)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- GET(url)
data <- content(html,as = "text")
parsedHTML =htmlParse(html,asText=TRUE)
xpathSApply(parsedHTML,"//title",xmlValue)


#accessing websites with passwords
pg2 = GET("http://httpbin.org/basic-auth/user/passwd",authenticate("user","passwd"))
pg2
names(pg2)


#using handles to store authentication
google = handle("http://google.com")
pg1 <- GET(handle = google,path = "/")
pg2 <- GET(handle = google,path = "search")





##READING FROM API's

myapp <- oauth_app("openstats@123",key = "HsQGthxWni8TEBBvirv8Nvycu",
                   secret = "ZSYaagHiRjCBuAZmeDezeBUAMErpREp9XmBEd52m3vGQsGZ4IQ")
sig <- sign_oauth1.0(myapp,token = "1252593782845046784-bJcRLYOccI73DwqS8CBLf51FIm2dWD",
                     token_secret = "54b35wub1t3KYXZcN6iy9FAmw39V71buGstRnDqRANrj2")

homeTL <- GET("https://api.twitter.com/1.1/statuses/home_timeline.json",sig)

#converting the json object
library(jsonlite)
json1 = content(homeTL)
json2 = fromJSON(toJSON(json1))
json2[1,1:4]
