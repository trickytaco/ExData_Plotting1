power_cons_fullTable <- read.table("household_power_consumption.txt", comment.char = "", colClasses=c("character","character","real","real","real","real","real","real","real"), na.strings = "?", sep = ";", header=TRUE)

power_cons_dates <- power_cons_fullTable[power_cons_fullTable$Date == "1/2/2007" | power_cons_fullTable$Date == "2/2/2007",]

rm(power_cons_fullTable)

power_cons_dates[,1] <- as.character(as.Date(power_cons_dates[,1],"%d/%m/%Y"))

power_cons_dates$DT <- strptime(paste(power_cons_dates[,1],power_cons_dates[,2]),format="%Y-%m-%d %H:%M:%S")

power_cons <- subset(power_cons_dates, select = -c(Date,Time))

rm(power_cons_dates)

par(mfrow=c(2,2))

plot(power_cons$DT,power_cons$Global_active_power, type="n", xlab = "", ylab = "Global Active Power", main="")

lines(power_cons$DT,power_cons$Global_active_power)

plot(power_cons$DT,power_cons$Voltage, type="n", xlab = "datetime", ylab = "Voltage", main="")

lines(power_cons$DT,power_cons$Voltage)

plot(power_cons$DT,power_cons$Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering", main="")

lines(power_cons$DT,power_cons$Sub_metering_1)

lines(power_cons$DT,power_cons$Sub_metering_2, col="red")

lines(power_cons$DT,power_cons$Sub_metering_3, col="blue")

legend("topright", cex=0.4, xjust=1, bty="n", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

plot(power_cons$DT,power_cons$Global_reactive_power, type="n", xlab = "datetime", ylab = "Global_reactive_power", main="")

lines(power_cons$DT,power_cons$Global_reactive_power)

dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px")

dev.off()