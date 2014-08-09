#R script to read in household power consumption data and plot a line plot
#of date/time versus global active power in kilowatts. 

#Original data from
#https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

#File should be unzipped and placed into working directory

#Read in the whole table
power_cons_fullTable <- read.table("household_power_consumption.txt", comment.char = "", colClasses=c("character","character","real","real","real","real","real","real","real"), na.strings = "?", sep = ";", header=TRUE)

#Extract a subset of the rows with dates "1/2/2007" and "2/2/2007"
power_cons_dates <- power_cons_fullTable[power_cons_fullTable$Date == "1/2/2007" | power_cons_fullTable$Date == "2/2/2007",]

#Clean up memory
rm(power_cons_fullTable)

#Convert the dates to Date format
power_cons_dates[,1] <- as.character(as.Date(power_cons_dates[,1],"%d/%m/%Y"))

#Add a new column, DT, that converts the dates and times to POSIXlt format
power_cons_dates$DT <- strptime(paste(power_cons_dates[,1],power_cons_dates[,2]),format="%Y-%m-%d %H:%M:%S")

#Make a new data frame that excludes the old Date and Time columns
power_cons <- subset(power_cons_dates, select = -c(Date,Time))

#Clean up memory
rm(power_cons_dates)

#Set up the device for 4 plots in a 2x2 layout
par(mfrow=c(2,2))

#Set up the first plot and add the line
plot(power_cons$DT,power_cons$Global_active_power, type="n", xlab = "", ylab = "Global Active Power", main="")
lines(power_cons$DT,power_cons$Global_active_power)

#Set up the second plot and add the line
plot(power_cons$DT,power_cons$Voltage, type="n", xlab = "datetime", ylab = "Voltage", main="")
lines(power_cons$DT,power_cons$Voltage)

#Set up the third plot and add the lines and legend
plot(power_cons$DT,power_cons$Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering", main="")
lines(power_cons$DT,power_cons$Sub_metering_1)
lines(power_cons$DT,power_cons$Sub_metering_2, col="red")
lines(power_cons$DT,power_cons$Sub_metering_3, col="blue")
legend("topright", cex=0.4, xjust=1, bty="n", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Set up the fourth plot and add the line
plot(power_cons$DT,power_cons$Global_reactive_power, type="n", xlab = "datetime", ylab = "Global_reactive_power", main="")
lines(power_cons$DT,power_cons$Global_reactive_power)

#Copy the device to a png device
dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px")

#Close the device to save the file
dev.off()