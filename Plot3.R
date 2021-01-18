#Load data.table package
library(data.table)

# Read in the data tbale from the text file
powerData <- data.table::fread(input = "household_power_consumption.txt"
                               , na.strings = "?")

#Change columns to a format that is easily filtered by date and time
powerData[, Global_active_power := lapply(.SD,as.numeric), .SDcols = c("Global_active_power")]
powerData[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

#Subset the data to the desired dates
powerData <- powerData[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

#Open a PNG file and make the plot
png("plot3.png", width=480, height=480)

plot(powerData[,dateTime], powerData[,Sub_metering_1], type = "l", xlab = "", ylab = "Energy Sub Metering")
lines(powerData[,dateTime],powerData[, Sub_metering_2], col = "red")
lines(powerData[,dateTime],powerData[, Sub_metering_3],col = "blue")
legend("topright", col = c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ","Sub_metering_3  "),
       lty = c(1,1), lwd = c(1,1))
dev.off()