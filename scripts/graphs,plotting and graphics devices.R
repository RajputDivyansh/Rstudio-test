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


##LATTICE PLOT
library(lattice)
xyplot(Ozone~wind,data = airquality)
xyplot(Ozone ~ wind | month,data = airquality,layout=c(5,1))

xyplot(y~x  | f,panel = function(x,y,...) {
  panel.xyplot(x,y,...)
  panel.abline(h=median(y),lty = 2)
})


##GGPLOT2
qplot(displ,hwy,data=mpg)
qplot(displ,hwy,data=mpg,color=drv)
qplot(displ,hwy,data=mpg,geom = c("point","smooth") )

qplot(hwy,data=mpg,fill = drv)

qplot(displ,hwy,data=mpg,facets = .~drv)
qplot(displ,hwy,data=mpg,facets = drv~.,bandwidth=2)


#Building plot from scratch in ggplot
g <- ggplot(mpg,aes(displ,hwy))
g + geom_point()

g + geom_point() + geom_smooth()
g + geom_point() + geom_smooth(method = "lm")

p <- g + geom_point() + facet_grid(. ~ drv) + geom_smooth(method = 'lm')

#alpha is used for transparency and se=FALSE is for CONFIDENCE INTERVAL
p <- g + geom_point(aes(color = drv) ,size=2, alpha=1/2) + geom_smooth(size=4, linetype=3 ,method = "lm", se =FALSE)

#change overall theme and font as well with provided option
p <- g + geom_point(aes(color = drv)) + theme_bw(base_family = "Times")

#Axis limit in case of outlier
g + geom_line() + coord_cartesian(ylim = c(-3,3))
