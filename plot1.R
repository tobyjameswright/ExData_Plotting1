library(dplyr)

#read in data
mydata <- read.csv(file= "household_power_consumption.txt", header=T, sep = ";", stringsAsFactors = F)

#set date to date
mydata$Date <- as.Date(mydata$Date, "%d/%m/%Y")

#set Global Active power to numeric
mydata$Global_active_power <- as.numeric(mydata$Global_active_power)

#subset data to two days
data <- subset(mydata, mydata$Date == "2007-02-01" | mydata$Date == "2007-02-02")

#plot histogram
with(data, hist(Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main="Global Active Power"))

#copy to png
dev.copy(device=png, "plot1.png", height = 480, width = 480)
dev.off()
