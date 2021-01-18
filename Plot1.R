#Load data.table package
library(data.table)

# Read in the data tbale from the text file
powerData <- data.table::fread(input = "household_power_consumption.txt"
                               , na.strings = "?")

#Format the data to be easily read by date and time
powerData[, Global_active_power := lapply(.SD,as.numeric), .SDcols = c("Global_active_power")]
powerData[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

#Subset the data to the desired timeframe
powerData <- powerData[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

#Open PNG file and make the plot
png("plot1.png", width = 480, height = 480)

hist(powerData[, Global_active_power], main = " Global Active Power",xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()
