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
    else if(num > nrow(ordered_data))
    {
        return (NA)
    }
    num <- as.numeric(num)
    
    ##Returning given rank hospital for given outcome
    return (ordered_data[num,2])
}

##TESTCASES
rankhospital("NC","heart attack","worst")
rankhospital("NC","heart attack",2)
rankhospital("NC","heart attack","best")





#3. The function ranks hospitals in all states.

##PROBLEM
# Write a function called rankall() that takes TWO (2) arguments: 
# (a) an outcome name (outcome); and (b) a hospital ranking (num). 
# The function reads the outcome-of-care-measures.csv file and 
# returns a TWO(2)-column data frame containing the hospital in 
# EACH state that has the ranking specified in num. 



rankall <- function(outcome,num = "best") {
    path <- paste(getwd(),"data","hospital dataset","outcome-of-care-measures.csv",sep="/")
    data <- read.csv(path,header = TRUE)
    
    if(!any(outcome %in% c("heart attack","heart failure","pneumonia")))
    {
        stop("invalid outcome")
    }
    
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
    data[,col] <- as.numeric(data[,col])
    data <- data[(!is.na(data[,col])),]
    
    ##splitting the data into groups/list using factor(in this case state)
    ##the internal data structure is list with data frame inside it
    ##which means 1st list element e.g "AK" consist all the data in 
    ##which state is "AK" as data frame
    splited_data <- split(data,data$State)
    res <- lapply(splited_data, function(x,num) {
        x <- x[order(x[,col],x[,2]),]
        
        if(class(num) == "character")
        {
            if(num == "best")
            {
                return (x$Hospital.Name[1])
                #return (x[1,2])                both works fine            
            }
            else if(num == "worst")
            {
                return (x[nrow(x),2])
                #return (x$Hospital.Name[nrow(x)])      this and above are same
            }
        }
        # else if(num > nrow(x))
        # {
        #     return (NA)
        # }
        else
        {
            return (x[num,2])
        }
    },num)
    ##^num here is an arguement to function
    
    #print(names(res))
    #print(unlist(res))
    ans <- data.frame(hopital = unlist(res),state = names(res))
    return (ans)
}




###########USING FOR LOOP ANOTHER SOLUTION FOR ABOVE PROBLEM 3############

# rankall <- function(outcome, num = "best") {
#     path <- paste(getwd(),"data","hospital dataset","outcome-of-care-measures.csv",sep="/")
#     data <- read.csv(path,header = TRUE)
#     
#     # 2. Get distinct 'States' from data:
#     States <- levels(factor(data[, 7]))
#     
#     # 3. Define the possible acceptable 'Outcomes':
#     Outcomes <- c("heart attack", "heart failure", "pneumonia")
#     
#     # 4. check validity of the input: 'state', 'outcome' and 'num':
#     
#     # 4.1 stops when the input 'outcome' is not exist within the 'Outcomes';
#     if ((outcome %in% Outcomes) == FALSE) 
#     {
#         stop(print("-- invalid outcome input! --"))
#     }
#     
#     # 4.2 returns 'NA' if num is greater that the number of HospitalsRanked in the data.
#     if (is.numeric(num) == TRUE) 
#     {
#         if (length(data[,2]) < num) 
#         {
#             return(NA)
#         }
#     }
#     
#     # 5. Define mapping of outcome column according to 'outcome' input:
#     colNumber <- if (outcome == "heart attack") {11}
#     else if (outcome == "heart failure") {17}
#     else {23}
#     
#     # 6. Regard 'outcome' as numeric and 'Hospital.Name' as character:
#     
#     # 6.1 regard data in column 'colNumber' as numeric;
#     
#     data[, colNumber] <- suppressWarnings(as.numeric(levels(data[, colNumber])[data[, colNumber]]))
#     
#     # 6.2 regard data in column '2' as character;
#     #> names(data)[2]
#     #[1] "Hospital.Name"
#     # since column #2 is Hospital.Name, it's should be considered as character:
#     
#     data[, 2] <- as.character(data[, 2])
#     
#     
#     # 7. initialize empty AllStatesHospitalRanking:
#     
#     AllStatesHospitalRanking <- vector()
#     
#     # 8. compute AllStatesHospitalRanking.
#     
#     # 8.1 loop for all States to compute AllStatesHospitalRanking:
#     
#     for(i in 1:length(States)) {
#         
#         # 8.1.1. selected data for each state;
#         selectedData <- subset(data, State == States[i])
#         #selectedData <- data[grep(state, data$State), ]
#         
#         # 8.1.2. re-select data based on requested input 'outcome' and clean it from all 'na' values;
#         selectedColumns <- suppressWarnings(as.numeric(selectedData[,colNumber]))
#         selectedData <- selectedData[!(is.na(selectedColumns)), ]
#         
#         # 8.1.3. rank hospital by 'outcome':
#         
#         HospitalRankPerState <- selectedData[order(selectedData[, colNumber], selectedData[, 2]), ]
#         
#         # 8.1.3.1. if input 'num' == 'best' then then 'numRank' = first;
#         if(num == "best") {numRank = 1}
#         
#         # 8.1.3.2. if input 'num' == 'worst' then 'numRank' = last;
#         else if(num == "worst") {numRank = nrow(HospitalRankPerState)}
#         
#         # 8.1.3.3. if input 'num' == number then 'numRank' = 'num'.
#         else{numRank = num}
#         
#         HospitalsRanked <- HospitalRankPerState[numRank, 2]
#         
#         # 8.1.4 append AllStatesHospitalRanking:
#         
#         AllStatesHospitalRanking <- append(AllStatesHospitalRanking, c(HospitalsRanked, States[i]))
#     }
#     
#     #8.2 AllStatesHospitalRanking as data frame along with column names and row names:
#     
#     AllStatesHospitalRanking <- as.data.frame(matrix(AllStatesHospitalRanking, length(States), 2, byrow = TRUE))
#     colnames(AllStatesHospitalRanking) <- c("hospital", "state")
#     rownames(AllStatesHospitalRanking) <- States
#     
#     #8.3. return AllStatesHospitalRanking:
#     
#     return(AllStatesHospitalRanking)
# }