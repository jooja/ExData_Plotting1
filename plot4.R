# download data
zipfile <- "data.zip"
txtfile <- "household_power_consumption.txt"
if (!file.exists(storedfile)){
  downloadedfile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(downloadedfile, zipfile, method="curl")
} else {print("Existing ZIP file found & used.")}
if (!file.exists(txtfile)) { 
  unzip(zipfile) 
} else {print("Existing unzipped data (directory) found & used.")}

# read & filter data
mydata <- read.csv(txtfile,
                   sep = ";",
                   colClasses=c("factor","factor","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
                   na.strings=c("NA", "?"))
mydata$Time <- strptime(paste(mydata$Date,mydata$Time),"%d/%m/%Y %T")
mydata$Date <- as.Date(mydata$Date,format="%d/%m/%Y")
filtereddata <- subset(mydata,mydata$Date == as.Date("2007-02-01") | mydata$Date == as.Date("2007-02-02"))

# draw plots
par(mfrow=c(2,2))
# plot #1
plot(filtereddata$Time,filtereddata$Global_active_power,
     type="n", xlab="", ylab="Global Active Power (kilowatts)")
lines(filtereddata$Time,filtereddata$Global_active_power, type="l")
# plot #2
plot(filtereddata$Time,filtereddata$Voltage,
     type="n", xlab="datetime", ylab="Voltage")
lines(filtereddata$Time,filtereddata$Voltage, type="l")
# plot #3
plot(filtereddata$Time,filtereddata$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(filtereddata$Time,filtereddata$Sub_metering_1, type="l", col ="black")
lines(filtereddata$Time,filtereddata$Sub_metering_2, type="l", col ="red")
lines(filtereddata$Time,filtereddata$Sub_metering_3, type="l", col ="blue")
legend("topright",
       c("Sub metering_1","Sub metering_2","Sub metering_3"),
       lty=c(1,1,1), 
       lwd=c(2.5,2.5,2.5),
       col=c("black","red","blue"))
# plot #4
plot(filtereddata$Time,filtereddata$Global_reactive_power,
     type="n", xlab="datetime", ylab="Global_reactive_power")
lines(filtereddata$Time,filtereddata$Global_reactive_power, type="l")

# copy to file
dev.copy(png,'plot4.png')
dev.off()