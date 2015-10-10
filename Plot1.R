
##Get Data and assign the Dataset to a variable
householdpc <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

##Convert Date column to format as Date
householdpc$Date <- as.Date(householdpc$Date, format="%d/%m/%Y")

##Filter required DataSet to two dates requested here
filterdatahpc <- subset(householdpc, 
                     (Date == "2007-02-01" | Date == "2007-02-02" ))

##Remove ? (NA) from the dataset for Global Active Power
removenahpc <- subset(filterdatahpc, Global_active_power != "?")

##Convert Global Active Power column to format as Numeric
removenahpc$Global_active_power <- as.numeric(as.character(removenahpc$Global_active_power))

##Setting Device as PNG with widht and height params
png(filename="plot1.png", width = 480, height = 480, units = "px")

##Create Histogram graph
hist(removenahpc$Global_active_power , col="red", main="Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frequency" )

##Closing the file and saving
dev.off()