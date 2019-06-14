library(dplyr)
library(lubridate)

#read in data
mydata <- read.csv(file= "household_power_consumption.txt", header=T, sep = ";", stringsAsFactors = F)

#set date to date
mydata$Date <- as.Date(mydata$Date, "%d/%m/%Y")

#set sub metering to numeric
mydata$Sub_metering_1 <- as.numeric(mydata$Sub_metering_1)
mydata$Sub_metering_2 <- as.numeric(mydata$Sub_metering_2)
mydata$Sub_metering_3 <- as.numeric(mydata$Sub_metering_3)

#subset data to two days
data <- subset(mydata, mydata$Date == "2007-02-01" | mydata$Date == "2007-02-02")

# create a date time column
data$DateTime <- with(data, ymd(Date) + hms(Time))

#plot sub meter 1 chart
with(data, plot(x = DateTime, y = Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l"))
#plot sub meter 2 chart on top of sub meter 1
with(data, lines(x = DateTime, y = Sub_metering_2, col="red"))
#plot sub meter 3 chart on top of submeter 1 + sub meter 2
with(data, lines(x = DateTime, y = Sub_metering_3, col = "Blue"))
# add legend to top right
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       , col= c("black", "red", "blue"), lty = 1)

#copy to png
dev.copy(device=png, "plot3.png")
dev.off()
