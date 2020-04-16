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
    
    state_data <- subset(data, State == state)
    
    if(outcome == "heart attack")
    {
        col <- 11
    }
    if(outcome == "heart failure")
    {
        col <- 17
    }
    else
    {
        col <- 23
    }
    
    min_row <- which(as.numeric(state_data[,col]) == min(as.numeric(state_data[,col]), na.rm = TRUE))
    hospitals <- state_data[min_row,2]
    # hospitals <- state_data$Hospital.Name
    
    hospitals <- sort(hospitals)
    
    return(hospitals)
}