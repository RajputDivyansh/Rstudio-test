# 1st function

add <- function(x,y){
    x+y
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