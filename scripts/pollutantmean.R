pollutantmean <- function(directory,pollutant,id = 1:332){
    
    data <- data.frame()  
    for(i in id)
    {
        #print(i)
        if(i<10)
        {
            path <- paste(getwd(),"/",directory,"/00",as.character(i),".csv",sep = "")
            dat <- read.csv(path)
            data <- rbind(data,dat)
        }
        else if(i<100)
        {
            path <- paste(getwd(),"/",directory,"/0",as.character(i),".csv",sep = "")
            dat <- read.csv(path)
            data <- rbind(data,dat)
        }
        else
        {
            path <- paste(getwd(),"/",directory,"/",as.character(i),".csv",sep = "")
            dat <- read.csv(path)
            data <- rbind(data,dat)
        }
        #print(path)
        #print(ncol(data))
    }
    #print(data[,pollutant])
    mean(data[,pollutant],na.rm = TRUE)
}