##1. Plot the 30-day mortality rates for heart attack

path <- paste(getwd(),"data","hospital dataset","outcome-of-care-measures.csv",sep="/")
data <- read.csv(path,header = TRUE)

temp <- as.numeric(data[,11])
hist(temp)





##2. Find the best hospital in a state

##PROBLEM
#Write a function called best() that takes TWO (2) arguments: 
#(a) the TWO(2)-character abbreviated name of a state; and 
#(b) an outcome name. The function reads the outcome-of-
# care-measures.csv file and returns a character vector with the 
# name of the hospital that has the best (i.e. LOWEST) 30-day 
# mortality for the specified outcome in that state. The hospital 
# name is the name provided in the Hospital.Name variable. The 
# outcomes can be one of “heart attack”, “heart failure”, or “pneumonia”. 



best <- function(state,outcome) {
    path <- paste(getwd(),"data","hospital dataset","outcome-of-care-measures.csv",sep="/")
    data <- read.csv(path,header = TRUE)
    
    if(!any(state==data$State))
    {
        stop("invalid state")
    }
    else if(!any(outcome %in% c("heart attack","heart failure","pneumonia")))
    {
        stop("invalid outcome")
    }
    
    ##selecting the state column
    state_data <- subset(data, State == state)
    ##state_data <- subset(data, data$State == state)     both works fine
    
    if(outcome == "heart attack")
    {
        col <- 11
    }
    else if(outcome == "heart failure")
    {
        col <- 17
    }
    else
    {
        col <- 23
    }
    
    ##selecting the minimum row from given outcome column
    #str(state_data)
    min_row <- which(as.numeric(state_data[,col]) == min(as.numeric(state_data[,col]), na.rm = TRUE))
    
    ##selecting hospital from given state with lowest death rate
    hospitals <- state_data[min_row,2]
    hospitals <- sort(hospitals)
    
    return(hospitals)
}

##TESTCASES
best("SC","heart attack")
length(best("SC","heart attacsk"))    ##for length of returned vector





#3. The funtion ranks hospitals by outcome in a state

##PROBLEM
# Write a function called rankhospital() that takes THREE (3) 
# arguments: (a) the TWO(2)-character abbreviated name of a state 
# (state); (b) an outcome (outcome); and the ranking of a hospital 
# in that state for that outcome (num). The function reads the 
# outcome-of-care-measures.csv file and returns a character vector 
# with the name of the hospital that has the ranking specified by the 
# num argument.



rankhospital <- function(state,outcome,num = "best") {
    path <- paste(getwd(),"data","hospital dataset","outcome-of-care-measures.csv",sep="/")
    data <- read.csv(path,header = TRUE)
    
    if(!any(state == data$State))
    {
        stop("invalid state")
    }
    else if(!any(outcome %in% c("heart attack","heart failure","pneumonia")))
    {
        stop("invalid outcome")
    }
    
    ##selecting the state column
    state_data <- subset(data, data$State == state)
    #print(state_data)
    ##state_data <- subset(data, State == state)     both works fine
    
    if(outcome == "heart attack")
    {
        col <- 11
    }
    else if(outcome == "heart failure")
    {
        col <- 17
    }
    else
    {
        col <- 23
    }
    
    ##converting the column data into numeric
    state_data[,col] <- as.numeric(state_data[,col])
    # print(state_data[,col])
    
    ##sorting the data according to death rate and hospital name
    ordered_data <- state_data[order(state_data[,col],state_data[,2]),]
    ordered_data <- ordered_data[(!is.na(ordered_data[,col])),]
    
    # print(nrow(ordered_data))
    
    if(num == "best")
    {
        num <- 1
    }
    else if(num == "worst")
    {
        num <- nrow(ordered_data)
    }
    
    num <- as.numeric(num)
    
    ##Returning given rank hospital for given outcome
    return (ordered_data[num,2])
}