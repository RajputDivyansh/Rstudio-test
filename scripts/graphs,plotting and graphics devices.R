fileURL <- "https://github.com/DataScienceSpecialization/courses/blob/master/04_ExploratoryAnalysis/exploratoryGraphs/data/avgpm25.csv"
download.file(fileURL,"./data/usa avgpm25 dataset/avgpm25.csv",method = "curl")
pollution <- read.csv("./data/usa avgpm25 dataset/avgpm25.csv",header = TRUE)
head(pollution)


##FIVE NUMBER SUMMARY
summary(pollution$pm25)


##BOXPLOT
boxplot(pollution$pm25,col = "blue")

boxplot(pollution$pm25,col = "blue")
abline(h = 12)


##Histogram
hist(pollution$pm25,col = "green")
rug(pollution$pm25)

hist(pollution$pm25,col = "green",breaks = 50)
rug(pollution$pm25)


##BARPLOT
barplot(table(pollution$region),col = "wheat" ,main = "NUmber of Counties in Each Region")


###TWO DIMENSIONAL PLOTTING

##MULTIPLE BOXPLOTS
boxplot(pm25 ~ region, data = pollution, col = "red")


##MULTIPLE HISTOGRAM
par(mfrow = c(2,1), mar = c(4,4,2,1))
hist(subset(pollution, region == "east")$pm25, col = "green")
hist(subset(pollution, region == "west")$pm25, col = "green")


##SCATTERPLOT
with(pollution,plot(latitude, pm25))
abline(h = 12 ,lwd = 2, lyt = 2)

with(pollution,plot(latitude, pm25, col = region))
abline(h = 12 ,lwd = 2, lty = 2)

##MULTIPLE SCATTERPLOT
par(mfrow = c(2,1), mar = c(4,4,2,1))
with(subset(pollution,region == "west"),plot(latitude, pm25, main = "west"))
with(subset(pollution,region == "east"),plot(latitude, pm25, main = "east"))