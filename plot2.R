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

## create vector to plot, open device, plot to device, and turn device off
globalActivePower <- as.numeric(data.subset$Global_active_power)
png("plot2.png", width=480, height=480)
plot(data.subset$DateTime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()