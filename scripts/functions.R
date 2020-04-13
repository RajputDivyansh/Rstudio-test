# 1st function

add <- function(x,y){
    x+t1
}

above <- function(x,n=10){
    use<- x>n
    x[use] 
}

columnmean <- function(x, removeNA=TRUE){
    nc <- ncol(x)
    means <- numeric(nc)
    for(i in nc)
    {
        means[i] <- mean(x[,i],na.rm = removeNA)       
    }
    means
}

#LOOP FUNCTIONS 
#LAPPLY
#1

x <- list(a=1:4,b=rnorm(10))
lapply(x,mean)


#2 Using function arguement
x <- 1:4
lapply(x,runif,min=3,max=7)


#3 Using anonymous function
x <- list(a=matrix(1:4,2,2),b=matrix(1:6),3,2)
lapply(x,function(elt) elt[,1])



#DIFFERENCE BETWEEN LAPPLY AND SAPPLY IS THAT LATER ONE 
#SIMPLIFIES THE RESULT MEANS IF RESULTING LIST IS OF SAME
#LENGTH THEN IT WILL RETURN A VECTOR

#SAPPLY
x <- list(a=1:4,b=rnorm(10))
sapply(x,mean)




#APPLY  apply(X,MARGIN,FUN,...)
#1

#MARGIN SIGNIFIES WETHER ROW COLLAPSES OR COLUMN
x <- matrix(rnorm(200),20,10)
apply(x,2,mean)  
#OR
apply(x,1,mean)


#2
x <- matrix(rnorm(200),20,10)
apply(x,1,quantile,probs = c(0.25,0.75))


#3MULTIPLE DIMENSIONS
x <- array(rnorm(2*2*10),c(2,2,10))
apply(a,c(1,2),mean)

#ANOTHER SOL FOR ABOVE
rowMeans(x,dim = 2)




#MAPPLY MULTIVARIATE APPLY  mapply(FUN,...,MoreArgs=NULL,SIMPLIFY=TRUE,USE.NAMES=TRUE)

#suppose you have two lists, and the elements of 
#the first list go into one argument of the function, 
#and the elements of the second list go into another 
#argument of the function. So lapply and sapply 
#can't really be used for that purpose.we can do this
#using mapply


#1
list(rep(1,4),rep(2,3),rep(3,2),rep(4,1))

#OR WE CAN USE MAPPLY

mapply(rep,1:4,4:1)


#2
noise <- function(n,mean,sd) {
    rnorm(n,mean,sd)
}

noise(5,1,2)    #it gives correct result

noise(1:5,1:5,2)    #it doesn't

#TO SOLVE THIS WE USE MAPPLY
mapply(noise,1:5,1:5,2)

#what it does? it run arguement one by one like 1 then 2
#and so on(upto 5) from both the arguement




#TAPPLY     tapply(X,INDEX,FUN=NULL, ...,SIMPLIFY=TRUE)

#So the basic idea behind tapply is that the first 
#argument is a numeric vector or a vector of some sort.
#The second argument is, is another vector of the same 
#length which identifies which group each element of the 
#numeric vector is in. So for example, suppose there are 
#two groups suppose you have men and women, for example, 
#in two groups, and maybe the first 50 observations are 
#men and the second 50 observations are women. Then you 
#need to have a factor variable which indicates, you
#know, which, which observations are men and which, 
#which are women. And so if you want to take the mean of 
#the numeric factor within men or within women

x <- c(rnorm(10),runif(10),rnorm(10,1))
f <- gl(3,10)   #it is used to identify the groups

tapply(x,f,mean)

tapply(x,f,range)




#SPLIT      split(X,F,drop = FALSE)     F is factor

#So it's kind of like tapply, but it, but it's like tapply 
#but without applying the summary statistics. So what it 
#does, is it takes a vector, or an object x and it takes 
#a factor variable, f. Which again identifies levels of a 
#group.And then it splits the object x into the number of 
#groups that are identified in, in factor f. So for example, 
#if f has three levels identifying three groups, then the 
#split function will split x, into three groups. And so, and 
#then once you've got those groups split apart, you can apply, 
#you can use lapply, or sapply to apply a function to those 
#individual groups


#1
library(datasets)
head(airquality)
s <- split(airquality,airquality$Month)

lapply(s,colMeans)

lapply(s,colMeans(x[,c("Ozone","Solar.R","Wind")],na.rm = TRUE))

sapply(s,colMeans(x[,c("Ozone","Solar.R","Wind")],na.rm = TRUE))


#2  SPLITTING ON MORE THAN ONE LEVEL
x <- rnorm(10)
f1 <- gl(2,5)
f2 <- gl(5,2)

interaction(f1,f2)

#USE THIS AS ANOTHER SOL OF ABOVE
str(split(x,list(f1,f2)))   #its sometimes give empty level

#FOR DROPPING EMPTY LEVELS
str(split(x,list(f1,f2),drop =TRUE))