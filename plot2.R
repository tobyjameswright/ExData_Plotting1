library(dplyr)
library(lubridate)

#read in data
mydata <- read.csv(file= "household_power_consumption.txt", header=T, sep = ";", stringsAsFactors = F)

#set date to date
mydata$Date <- as.Date(mydata$Date, "%d/%m/%Y")

#set Global Active power to numeric
mydata$Global_active_power <- as.numeric(mydata$Global_active_power)

#subset data to two days
data <- subset(mydata, mydata$Date == "2007-02-01" | mydata$Date == "2007-02-02")

# create a date time column
data$DateTime <- with(data, ymd(Date) + hms(Time))

#plot chart
with(data, plot(x = DateTime, y = Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l"))

#copy to png
dev.copy(device=png, "plot2.png", height=480, width=480)
dev.off()
