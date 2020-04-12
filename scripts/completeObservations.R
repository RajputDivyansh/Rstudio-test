complete <- function(directory,id = 1:332) {
    
    data <- data.frame()
    csvFiles <- list.files(directory,full.names = TRUE)
    for(i in id)
    {
        dat <- read.csv(csvFiles[i])
        #print(complete.cases(dat))
        nco <- sum(complete.cases(dat))
        temp <- data.frame(i,nco)
        data <- rbind(data,temp)
    }
    data
}