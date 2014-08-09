power_cons_fullTable <- read.table("household_power_consumption.txt", comment.char = "", colClasses=c("character","character","real","real","real","real","real","real","real"), na.strings = "?", sep = ";", header=TRUE)

power_cons_dates <- power_cons_fullTable[power_cons_fullTable$Date == "1/2/2007" | power_cons_fullTable$Date == "2/2/2007",]

rm(power_cons_fullTable)

power_cons_dates[,1] <- as.character(as.Date(power_cons_dates[,1],"%d/%m/%Y"))

power_cons_dates$DT <- strptime(paste(power_cons_dates[,1],power_cons_dates[,2]),format="%Y-%m-%d %H:%M:%S")

power_cons <- subset(power_cons_dates, select = -c(Date,Time))

rm(power_cons_dates)

par(mfrow=c(1,1))

plot(power_cons$DT,power_cons$Global_active_power, type="n", xlab = "", ylab = "Global Active Power (kilowatts)", main="")

lines(power_cons$DT,power_cons$Global_active_power)

dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px")

dev.off()