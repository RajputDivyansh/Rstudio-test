corr <- function(directory,threshold = 0) {
    
    ###     directory = "data/airquality dataset" 
    csvFiles <- list.files(directory,full.names = TRUE)
    res <- NULL
    for(i in 1:332)
    {
        dat <- read.csv(csvFiles[i])
        data <- dat[complete.cases(dat),]
        if(nrow(data) > threshold)
        {
            res <- c(res,cor(data[,"sulfate"],data[,"nitrate"]))
        }
    }
    res
}