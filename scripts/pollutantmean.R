pollutantmean <- function(directory,pollutant,id = 1:332){
    
    ###     directory = "data/airquality dataset" 
    
    
    # data <- data.frame()
    # for(i in id)
    # {
    #     #print(i)
    #     if(i<10)
    #     {
    #         path <- paste(getwd(),"/",directory,"/00",as.character(i),".csv",sep = "")
    #         dat <- read.csv(path)
    #         data <- rbind(data,dat)
    #     }
    #     else if(i<100)
    #     {
    #         path <- paste(getwd(),"/",directory,"/0",as.character(i),".csv",sep = "")
    #         dat <- read.csv(path)
    #         data <- rbind(data,dat)
    #     }
    #     else
    #     {
    #         path <- paste(getwd(),"/",directory,"/",as.character(i),".csv",sep = "")
    #         dat <- read.csv(path)
    #         data <- rbind(data,dat)
    #     }
    #     #print(path)
    #     #print(ncol(data))
    # }
    # #print(data[,pollutant])
    # mean(data[,pollutant],na.rm = TRUE)
    
    #ANOTHER SOLUTION
    
    data <- data.frame()
    
    csvFiles <- list.files(directory,full.names = TRUE)
    
    for(i in id)
    {
        x <- read.csv(csvFiles[i])
        data <- rbind(data,x)
    }
    
    mean(data[,pollutant],na.rm = TRUE)
}