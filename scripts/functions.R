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
