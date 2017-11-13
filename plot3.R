## LOAD THE DATA

## This assignment uses data from the UC Irvine Machine Learning Repository.
## A popular repository for machine learning datasets. 
## In particular, we will be using the "Individual household electric power 
## consumption Data Set" which is available on the course web site:
## https://www.coursera.org/learn/exploratory-data-analysis/peer/ylVFo/course-project-1
## OR here:
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

#################################################################

## BEFORE RUNNING THIS SCRIPT.....
## In either case download the zip file to your local directory.
## Unzip the file, extracting a 130mb text file, 
## and place in your working directory.

## Make sure "household_power_consumption.txt" is in your current wd 
## of the session your are currently testing this script !!!!!!

## Don't forget to do the following:
## 1) install.packages("sqldf")....1 time, if you don't have it
## 2) library(sqldf)....needs to be done each session

## the following code will load the file into R.
## This will just load the rows that we need for the specified 2 day period.
## It takes about 10 seconds to load.

## Data check....
## This will create a df that has 2880 obs of 9 variables
## Each date has 1440 obs, 1 obs for every minute of the day (60 mins * 24 hrs)

mydf<- read.csv.sql("household_power_consumption.txt","select * from file 
where Date = '1/2/2007' or Date = '2/2/2007' ",sep=";") 


##############################################################
## TRANSFORM THE DATA IN MY DF

## create 2nd new date column, changing type to: Date, format: "2007-02-01" 
mydf$Date2 <- with(mydf, as.Date(Date, format="%d/%m/%Y"))

## create 3rd (final) new merged date/time column, 
## changing type to: POSIXct, format: "2007-02-01 00:00:00"
mydf$Date3 <- with(mydf, as.POSIXct(paste(Date2, Time), format="%Y-%m-%d %H:%M:%S"))

# Reorder mydf by column number
mydf <- mydf[,c(1,2,10,11,3,4,5,6,7,8,9)]


##############################################################
## 3RD PLOT

## open graphics device
png("plot3.png", width=480, height=480)

## Initialize a new plot
plot(mydf$Date3, mydf$Sub_metering_1, type = "l",xlab = ""
,ylab = "Energy sub metering"
)

lines(mydf$Date3, mydf$Sub_metering_2, type = "l", col="red")
lines(mydf$Date3, mydf$Sub_metering_3, type = "l", col="blue")
legend("topright", lty = 1     ## pch = 151, 
       ,col = c("black", "red", "blue")
      ,legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
    

## close graphics device
dev.off()


print("plot3.png file is ready for viewing, it's in your wd")

