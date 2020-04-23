##ORDERING WITH plyr
x <- data.frame("var1" = sample(1:5),var2 = sample(6:10),
                "var3" = sample(11:15))
x <- x[sample(1:5),]
x$var2[c(1,3)] = NA

library(plyr)
arrange(x,var1)
arrange(x,desc(var1))

#adding new colomn to the data frame
x$var4 <- rnorm(5)

#using cbind

y <- cbind(x,rnorm(5))




##SUMMARIZING THE DATA

fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile = "./data/baltimore restaurants dataset/restaurants.csv",method = "curl")
data <- read.csv("./data/baltimore restaurants dataset/restaurants.csv")

head(data,n = 3)
tail(data,n = 3)

summary(data)

#quantiles of quantitative variable
quantile(data$councilDistrict,na.rm = TRUE)
quantile(data$councilDistrict,probs = c(0.5,0.75,0.9))

#make table
table(data$zipCode,useNA = "ifany")

#2d table
table(data$councilDistrict,data$zipCode)

#checking for missing value
sum(is.na(data$councilDistrict))

#if any value is NA
any(is.na(data$councilDistrict))

#check if all values >0
all(data$zipCode>0)

colSums(is.na(data))

all(colSums(is.na(data))==0)


#value with specific characterstics
table(data$zipCode %in% c("21212"))

table(data$zipCode %in% c("21212","21213"))

data[data$zipCode %in% c("21212","21213"),]


#cross tabs
data(UCBAdmissions)
df = as.data.frame(UCBAdmissions)
summary(df)

xt <- xtabs(Freq ~ Gender + Admit,data = df)
xt

#flat table
ftable(xt)



#SIZE OF DATASET
fakeData = rnorm(1e5)
object.size(fakeData)

#to change the unit of size
print(object.size(fakeData),units = "Mb")



#CREATING SEQUENCE

s1 <- seq(1,10,by = 2); s1
s2 <- seq(1,10,by = 3); s2
x <- c(1,3,8,2,5); seq(along = x)

#creating categorical variables
data$zipGroups = cut(data$zipCode,breaks = quantile(data$zipCode))
table(data$zipGroups)
table(data$zipGroups,data$zipGroups)


#Easier cutting
library(Hmisc)
data$zipGroups = cut2(data$zipCode,g=4)
table(data$zipGroups)


#creating factor variables
data$zcf <- factor(data$zipCode)
data$zcf[1:10]


#levels of factor variable
yesno <- sample(c("yes","no"),size = 10,replace = TRUE)
yesnofac = factor(yesno,levels = c("yes","no"))
relevel(yesnofac,ref = "yes")

as.numeric(yesnofac)






##RESHAPING DATA

library(reshape2)
head(mtcars)


#melting data
dup_mtcars <- mtcars
dup_mtcars$carname <- rownames(mtcars)
carMelt <- melt(dup_mtcars,id = c("carname","gear","cyl"),measure.vars = c("mpg","hp"))   #it is used to group the data according to measure.vars
head(carMelt,4)



#casting data frames  
#1.it will dcast molten data e.g on left side cylinder and to the right it ill give the count of mpg and hp
cylData <- dcast(carMelt,cyl ~ variable)    
cylData

###############OUTPUT###################
#    cyl mpg hp
# 1   4  11 11
# 2   6   7  7
# 3   8  14 14


#2. it will dcast data e.g on left side gear and cylinder and to 
    #the right it ill give the count of mpg and hp(with respect to gear+cyl)
cylData <- dcast(carMelt,gear + cyl ~ variable)
cylData                                     

###############OUTPUT###################
#     gear cyl mpg hp
# 1    3   4   1  1
# 2    3   6   2  2
# 3    3   8  12 12
# 4    4   4   8  8
# 5    4   6   4  4
# 6    5   4   2  2
# 7    5   6   1  1
# 8    5   8   2  2


#3. it will give the mean value for hp and mpg for different type of cyl
cylData <- dcast(carMelt,cyl ~ variable,mean)
cylData




#averaging data
head(InsectSprays)

tapply(InsectSprays$count,InsectSprays$spray,sum)


insect_split <- split(InsectSprays$count,InsectSprays$spray)

insect_count <- lapply(insect_split,sum)

#converting to vector
unlist(insect_count)
#OR
sapply(insect_split,sum)



#pylr package
ddply(InsectSprays,.(spray),summarise,sum=sum(count))

ddply(InsectSprays,.(spray),summarise,sum = ave(count,FUN = sum))