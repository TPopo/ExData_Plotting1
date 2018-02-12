## set working directory with data
setwd("C:/Users/TonyP/Desktop/Coursera/elecpwrcons")

## read in data using read.table
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
                   colClasses = c("character","character", rep("numeric",7)), 
                   na.strings = "?")

## subset the data because we are only interested in two dates, also
## create POSIX date/time
data.subset <- data[data$Date %in% c("1/2/2007", "2/2/2007"),]
data.subset$Date <- as.Date(data.subset$Date, format = "%d/%m/%Y")
data.subset$DateTime <- as.POSIXct(paste(data.subset$Date, data.subset$Time))


## Create 3 vectors to graph separately
subMetering1 <- as.numeric(data.subset$Sub_metering_1)
subMetering2 <- as.numeric(data.subset$Sub_metering_2)
subMetering3 <- as.numeric(data.subset$Sub_metering_3)
globalActivePower <- as.numeric(data.subset$Global_active_power)
globalReactivePower <- as.numeric(data.subset$Global_reactive_power)
voltage <- as.numeric(data.subset$Voltage)

# open graphics device, plot to file, turn graphics device off

png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 
plot(data.subset$DateTime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)
plot(data.subset$DateTime, voltage, type="l", xlab="datetime", ylab="Voltage")
plot(data.subset$DateTime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(data.subset$DateTime, subMetering2, type="l", col="red")
lines(data.subset$DateTime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
plot(data.subset$DateTime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()