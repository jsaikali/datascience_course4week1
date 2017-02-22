## Joanna Saikali
## 02/22/2017

##determining which rows correspond to dates 2007-02-01 or 2007-02-02
rowsToKeep=grep("2007-02-01|2007-02-02", as.character(as.Date(read.table("household_power_consumption.txt", sep=";", header=TRUE)[,1], "%d/%m/%Y")))

##read in the table of electric power consumption data into variable, only for the relevant dates
powerConsumptionDS<-read.table("household_power_consumption.txt", sep = ";", header=TRUE, colClasses=c("character","character","double","double","double","double","double","double","numeric"), na.strings="?")[rowsToKeep,]

##adjusting classes of columns for convenience of use
powerConsumptionDS$Date<-as.Date(powerConsumptionDS$Date, "%d/%m/%Y")
powerConsumptionDS$TimeStamp<-as.POSIXct(paste(powerConsumptionDS$Date, powerConsumptionDS$Time))

##creating plot2
library(lubridate)
png(file="plot2.png", width=480, height=480)
with(powerConsumptionDS, plot(powerConsumptionDS$TimeStamp,powerConsumptionDS$Global_active_power, type = "l", ylab="Global Active Power (kilowatts)", xlab=""))
dev.off()