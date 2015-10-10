
##Get Data and assign the Dataset to a variable
householdpc <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

##Convert Date & Time column to format as DateTime and store it in a separate column
householdpc$DateTime <- as.POSIXct(paste(householdpc$Date, householdpc$Time, sep = " ")
                                   , format= "%d/%m/%Y %H:%M:%S")

##Convert Date column to format as Date
householdpc$Date <- as.Date(householdpc$Date, format="%d/%m/%Y")

##Filter required DataSet to two dates requested here

filterdatahpc <- subset(householdpc, 
                        (Date == "2007-02-01" | Date == "2007-02-02" ))

##Remove ? (NA) from the dataset for Sub_metering columns
removenahpc <- subset(filterdatahpc, Sub_metering_1 != "?")
removenahpc <- subset(removenahpc, Sub_metering_2 != "?")
removenahpc <- subset(removenahpc, Sub_metering_3 != "?")

##Convert Sub_metering column's to format as Numeric
removenahpc$Sub_metering_1 <- as.numeric(as.character(removenahpc$Sub_metering_1))
removenahpc$Sub_metering_2 <- as.numeric(as.character(removenahpc$Sub_metering_2))
removenahpc$Sub_metering_3 <- as.numeric(as.character(removenahpc$Sub_metering_3))

##Setting Device as PNG with widht and height params
png(filename="plot3.png", width = 480, height = 480, units = "px")

##Create plot with lines showing sub_metering by time
##Create a blank plot with axis
with(removenahpc, plot(Sub_metering_1~DateTime, type="n", 
                       ylab="Energy sub metering", xlab=" "))
##Create a plot for Sub_metering_1 with black color
with(removenahpc, points(Sub_metering_1~DateTime, type="l"))
##Create a plot for Sub_metering_2 with red color
with(removenahpc, points(Sub_metering_2~DateTime, type="l", col="red"))
##Create a plot for Sub_metering_3 with blue color
with(removenahpc, points(Sub_metering_3~DateTime, type="l", col="blue"))
##Adding legent in top right corner
legend("topright", pch=1, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


##Closing the file and saving
dev.off()