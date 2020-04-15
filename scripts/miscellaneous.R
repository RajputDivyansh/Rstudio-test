
#SET.SEED(N)    it will save the state of random number and
set.seed(1)     #same set of numbers will be reproduced again 
rnorm(5)



##GENERATE RANDOM NUMBERS FROM A LINEAR MODEL

#y=B0+B1*x+e
#B0=0.5, B1=2
#e=(0,2), x=(0,1)

#1
x <- rnorm(100)
e <- rnorm(100,0,2)

y <- 0.5+2*x+e

summary(y)
plot(x,y)


#2    WHEN X IS BINARY
x <- rbinom(100,1,0.5)
e <- rnorm(100,0,2)

y <- 0.5+2*x+e

summary(y)
plot(x,y)


#3    GENERATE RANDOM NUMBERS FROM A GENERALIZED LINEAR MODEL

##Y ~ Poisson(mu)
##log mu = B0 + B1x
##B0 = 0.5  B1 = 0.3

set.seed(1)
x <- rnorm(100)
log.mu <- 0.5 + 0.3 * x

y <- rpois(100,exp(log.mu))
summary(y)

plot(x,y)



#SAMPLE

sample(1:10,4)

sample(1:10)

sample(1:10,4,replace = TRUE)   #DUPLICATES ALLOWED

sample(2,4,replace=TRUE,prob=c(0.5,0.9))
