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

# draw plot & line
plot(filtereddata$Time,filtereddata$Global_active_power,
     type="n", xlab="", ylab="Global Active Power (kilowatts)")
lines(filtereddata$Time,filtereddata$Global_active_power, type="l")

# copy to file
dev.copy(png,'plot2.png')
dev.off()
