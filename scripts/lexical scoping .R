#<<- operator is used to assign a value to an object 
#in an environment that is different from the current environment 

makeVector <- function(x = numeric()) {
    m <- NULL
    
    #set the value of the mean
    set <- function(y) {
      x <<- y
      m <<- NULL
    }
    get <- function() {
        x
    }
    setmean <- function(mean) {
        m <<- mean
    }
    getmean <- function() {
        m
    }
    list(set = set,get = get,setmean = setmean,getmean = getmean)
}

cachemean <- function(x,...) {
  
  #get the value of the mean 
  #from the makeVector function
    m <- x$getmean()
    if(!is.null(m))
    {
        message("cached mean")
        return (m)
    }
    
    #if value of the mean(m) is NULL then
    data <- x$get()
    x$set(data)
    m <- mean(data)
    x$setmean(m)
    m
}

x <- c(1:5)
firstMean <- makeVector(x)

cachemean(firstMean)    #it will setmean into cache
cachemean(firstMean)    #in this we get cached mean  




##ANOTHER PROBLEM
##CACHED MATRIX INVERSION


makeCacheMatrix <- function(x = matrix()) {
    invMatrix <- NULL;
    
    setMatrix <- function(y) {
        x <<- y
        invMatrix <<- NULL
    }
    
    getMatrix <- function() {
        x
    }
    
    setInvMatrix <- function(inverse) {
        invMatrix <<- inverse
    }
    
    getInvMatrix <- function() {
        invMatrix
    }
    list(setMatrix = setMatrix, getMatrix = getMatrix,
         setInvMatrix = setInvMatrix, getInvMatrix = getInvMatrix)
}


cacheSolve <- function(x,...) {
    invMatrix <- x$getInvMatrix()
    if(!is.null(invMatrix))
    {
        message("cached matrix")
        return (invMatrix)
    }
    
    data <- x$getMatrix()
    invMatrix <- solve(data)
    x$setInvMatrix(data)
    
    invMatrix
}



##TESTCASES

TestMatrix <- matrix(c(1,5,8,2),2,2)
TestMatrix

CacheMatrix <- makeCacheMatrix(TestMatrix)
CacheMatrix$getMatrix()
CacheMatrix$getInverse()

cacheSolve(CacheMatrix)
cacheSolve(CacheMatrix)


####Test 3 [3*3 Matrix]#####
TestMatrix <- matrix(1:8,3,3)
TestMatrix

CacheMatrix <- makeCacheMatrix(TestMatrix)
CacheMatrix$getMatrix()
CacheMatrix$getInverse()

cacheSolve(CacheMatrix)
cacheSolve(CacheMatrix)
