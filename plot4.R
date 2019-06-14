library(dplyr)
library(lubridate)

#read in data
mydata <- read.csv(file= "household_power_consumption.txt", header=T, sep = ";", stringsAsFactors = F)

#set date to date
mydata$Date <- as.Date(mydata$Date, "%d/%m/%Y")

#set cols to numeric
mydata$Global_active_power <- as.numeric(mydata$Global_active_power)
mydata$Voltage <- as.numeric(mydata$Voltage)
mydata$Sub_metering_1 <- as.numeric(mydata$Sub_metering_1)
mydata$Sub_metering_2 <- as.numeric(mydata$Sub_metering_2)
mydata$Sub_metering_3 <- as.numeric(mydata$Sub_metering_3)
mydata$Global_reactive_power <- as.numeric(mydata$Global_reactive_power)

#subset data to two days
data <- subset(mydata, mydata$Date == "2007-02-01" | mydata$Date == "2007-02-02")

# create a date time column
data$DateTime <- with(data, ymd(Date) + hms(Time))

#set up plot window
par(mfrow= c(2,2))
#plot 1
with(data, plot(x = DateTime, y = Global_active_power, xlab = "", ylab = "Global Active Power", type = "l"))

#plot 2
with(data, plot(x = DateTime, y= Voltage, xlab = "datetime", ylab = "Voltage", type = "l"))

#plot 3
#plot sub meter 1 chart
with(data, plot(x = DateTime, y = Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l"))
#plot sub meter 2 chart on top of sub meter 1
with(data, lines(x = DateTime, y = Sub_metering_2, col="red"))
#plot sub meter 3 chart on top of submeter 1 + sub meter 2
with(data, lines(x = DateTime, y = Sub_metering_3, col = "Blue"))
# add legend to top right
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       , col= c("black", "red", "blue"), lty = 1, bty= "n")

#plot 4
with(data, plot(x = DateTime, y = Global_reactive_power, xlab = "datetime", type ="l"))


#copy to png
dev.copy(device=png, "plot4.png", height=480, width = 480)
dev.off()
