#Load data.table package
library(data.table)

# Read in the data tbale from the text file
powerData <- data.table::fread(input = "household_power_consumption.txt"
                               , na.strings = "?")

#Format the columns for easy filtering by date and time
powerData[, Global_active_power := lapply(.SD,as.numeric), .SDcols = c("Global_active_power")]
powerData[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

#Subset the data to the desired timeframe
powerData <- powerData[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

#Open a PNG file and make the plot
png("plot2.png", width=480, height=480)

plot(x = powerData[, dateTime]
     , y = powerData[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()