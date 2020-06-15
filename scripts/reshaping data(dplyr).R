##RESHAPING DATA

library(reshape2)
head(mtcars)


#melting data
dup_mtcars <- mtcars
dup_mtcars$carname <- rownames(mtcars)
carMelt <- melt(dup_mtcars,id = c("carname","gear","cyl"),measure.vars = c("mpg","hp"))   #it is used to group the data according to measure.vars
head(carMelt,4)



#casting data frames  
#1.it will dcast molten data e.g on left side cylinder and to the right it ill give the count of mpg and hp
cylData <- dcast(carMelt,cyl ~ variable)    
cylData

###############OUTPUT###################
#    cyl mpg hp
# 1   4  11 11
# 2   6   7  7
# 3   8  14 14


#2. it will dcast data e.g on left side gear and cylinder and to 
#the right it ill give the count of mpg and hp(with respect to gear+cyl)
cylData <- dcast(carMelt,gear + cyl ~ variable)
cylData                                     

###############OUTPUT###################
#     gear cyl mpg hp
# 1    3   4   1  1
# 2    3   6   2  2
# 3    3   8  12 12
# 4    4   4   8  8
# 5    4   6   4  4
# 6    5   4   2  2
# 7    5   6   1  1
# 8    5   8   2  2


#3. it will give the mean value for hp and mpg for different type of cyl
cylData <- dcast(carMelt,cyl ~ variable,mean)
cylData




#averaging data
head(InsectSprays)

tapply(InsectSprays$count,InsectSprays$spray,sum)


insect_split <- split(InsectSprays$count,InsectSprays$spray)

insect_count <- lapply(insect_split,sum)

#converting to vector
unlist(insect_count)
#OR
sapply(insect_split,sum)



#pylr package
ddply(InsectSprays,.(spray),summarise,sum=sum(count))

ddply(InsectSprays,.(spray),summarise,sum = ave(count,FUN = sum))






##MANAGING DATA FRAMES WITH dplyr
fileUrl <- "https://github.com/DataScienceSpecialization/courses/blob/master/03_GettingData/dplyr/chicago.rds?raw=true"
download.file(fileUrl,destfile = "./data/chicago airquality dataset/chicago.rds")
chicago <- readRDS("./data/chicago airquality dataset/chicago.rds")

str(chicago)
names(chicago)


#1. SELECT
head(select(chicago,city:dptp))   #it will print city to dptp colomn

head(select(chicago,-(city:dptp)))    #it will print all colomn except city to dptp


#2. FILTER
chic.f <- filter(chicago,pm25tmean2 > 30)   #it will give data frame with pm25tmean2 >30

chic.f <- filter(chicago,pm25tmean2 > 30 & tmpd > 80)   ##it will give data frame with pm25tmean2 >30 and tempd  >80


#3. ARRANGE
arrange(chicago,date)   #it's kind of sort
arrange(chicago,desc(date))


#4. RENAME
rename(chicago,pm25=pm25tmean2,dewpoint=dptp)   #new_name=old_name


#5. MUTATE          #you want to create new variables that are derived from existing variables
chicago <- mutate(chicago, pm25detrend = pm25 - mean(pm25, na.rm = TRUE))
head(chicago)

#6. TRANSMUTE       #it will only shows transformed variable
head(transmute(chicago, pm10detrend = pm10tmean2 - mean(pm10tmean2, na.rm = TRUE),o3detrend = o3tmean2 - mean(o3tmean2, na.rm = TRUE)))

#7. GROUP_BY
chicago <- mutate(chicago,tempcat = factor(1*(tmpd > 80),labels = c("cold","hot")))
hotcold <- group_by(chicago,tempcat)
summarise(hotcold,pm25 = mean(pm25),o3 = max(o3tmean2),no = median (no2tmean2))

chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)
years <- group_by(chicago,year)
summarize(years, pm25 = mean(pm25, na.rm = TRUE),o3 = max(o3tmean2, na.rm = TRUE), 
          no2 = median(no2tmean2, na.rm = TRUE))

#8. %>%       it is used to use more than one function one command
chicago %>% mutate(month =as.POSIXlt(data)$mon + 1) %>% group_by(month) %>% summarize(pm25 = mean(pm25,na.rm = TRUE),
                                                                                      o3 = max(o3tmean2),no = median (no2tmean2))





##MERGING DATA

fileUrl1 <- "http://www.sharecsv.com/dl/e70e9c289adc4b87c900fdf69093f996/reviews.csv"
fileUrl2 <- "http://www.sharecsv.com/dl/0863fd2414355555be0260f46dbe937b/solutions.csv"
download.file(fileUrl1,destfile = "./data/review solution dataset/reviews.csv",method = "curl")
download.file(fileUrl2,destfile = "./data/review solution dataset/solutions.csv",method = "curl")
reviews <- read.csv("./data/review solution dataset/reviews.csv")
solutions <- read.csv("./data/review solution dataset/solutions.csv")

#by default it merge data frames on the basis of same colomns
mergedData <- merge(reviews,solutions,all = TRUE)

mergedData <- merge(reviews,solutions,by.x = "solution_id",by.y = "id",all = TRUE)


#using join in the plyr package
df1 <- data.frame(id = sample(1:10),x = rnorm(10))
df2 <- data.frame(id = sample(1:10),y = rnorm(10))

arrange(join(df1,df2),id)

#if you have multiple packages
df1 <- data.frame(id = sample(1:10),x = rnorm(10))
df2 <- data.frame(id = sample(1:10),y = rnorm(10))
df3 <- data.frame(id = sample(1:10),z = rnorm(10))
dfList = list(df1,df2,df3)

join_all(dfList)






#################EXAMPLE#########################

mydf <- read.csv("./data/R's cran download log/cran download log.csv",stringsAsFactors = FALSE)
dim(mydf)
library(dplyr)

#converting data frame to tibble data frame
cran <- tbl_df(mydf)

#grouped the cran data on package
#now any operation we apply to the grouped data 
#will take place on a per package basis.
by_package <- group_by(cran,package)

#summarizing data on the basis of below functions
pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))


#We need to know the value of 'count' that splits the data into
#the top 1% and bottom 99% of packages based on total downloads.
#In statistics, this is called the 0.99, or 99%, sample
#quantile. Use quantile(pack_sum$count, probs = 0.99) to
#determine this number.

quantile(pack_sum$count,prob = 0.99)


#Now we can isolate only those packages which had more than 679
#total downloads

filter(pack_sum,pack_sum$count > 679)

#aranging the data according to maximum count of download
arrange(top_counts,desc(count))



#Our final metric of popularity is the number of distinct
#countries from which each package was downloaded. We'll
#approach this one a little differently to introduce you to a
#method called 'chaining' (or 'piping').

top_countries <- filter(pack_sum, countries > 60)
result1 <- arrange(top_countries, desc(countries), avg_bytes)

# Print the results to the console.
print(result1)


#using chaining operator

#The code to the right of %>% operates on the result from the
#code to the left of %>%
result3 <-
  cran %>%
  group_by(package) %>%
  summarize(count = n(),
            unique = n_distinct(ip_id),
            countries = n_distinct(country),
            avg_bytes = mean(size)
  ) %>%
  filter(countries > 60) %>%
  arrange(desc(countries), avg_bytes)

# Print result to console
print(result3)





##TIDYING DATA WITH tidyr Package

#gather    or    pivot_longer
#this function use to increase the number of rows and decreasing the number of columns.
students3 %>%
  gather( class,grade , -(name:test) ,na.rm = TRUE) %>%
  print


#spread    or   pivot_wider
#this function is use toincrease the number of columns and decreasing the number of rows.
students3 %>%
  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  spread( test, grade) %>%
  mutate(class = parse_number(class)) %>%
  print()


#Another example on tyding data
sat %>%
  select(-contains("total")) %>%
  gather(part_sex, count, -score_range) %>%
  separate(part_sex, c("part", "sex")) %>%
  group_by(part,sex) %>%
  mutate(total=sum(count),prop=count/total) %>% 
  print()