## Joanna Saikali
## 02/22/2017

##determining which rows correspond to dates 2007-02-01 or 2007-02-02
rowsToKeep=grep("2007-02-01|2007-02-02", as.character(as.Date(read.table("household_power_consumption.txt", sep=";", header=TRUE)[,1], "%d/%m/%Y")))

##read in the table of electric power consumption data into variable, only for the relevant dates
powerConsumptionDS<-read.table("household_power_consumption.txt", sep = ";", header=TRUE, colClasses=c("character","character","double","double","double","double","double","double","numeric"), na.strings="?")[rowsToKeep,]

##adjusting classes of columns for convenience of use
powerConsumptionDS$Date<-as.Date(powerConsumptionDS$Date, "%d/%m/%Y")
powerConsumptionDS$TimeStamp<-as.POSIXct(paste(powerConsumptionDS$Date, powerConsumptionDS$Time))

##creating plot4
library(lubridate)
library(reshape2)
png(file="plot4.png", width=480, height=480)
par(mfcol=c(2,2))

##first plot
with(powerConsumptionDS, plot(powerConsumptionDS$TimeStamp,powerConsumptionDS$Global_active_power, type = "l", ylab="Global Active Power (kilowatts)", xlab=""))
tallDS<-melt(powerConsumptionDS[,7:10], id=c("TimeStamp"), measure.vars=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

##second plot
with(tallDS, plot(tallDS$TimeStamp, tallDS$value, type="n", xlab="", ylab="Energy sub metering"))
points(tallDS$TimeStamp[tallDS$variable=="Sub_metering_1"],tallDS$value[tallDS$variable=="Sub_metering_1"], col="black", type = "l")
points(tallDS$TimeStamp[tallDS$variable=="Sub_metering_2"],tallDS$value[tallDS$variable=="Sub_metering_2"], col="red", type = "l")
points(tallDS$TimeStamp[tallDS$variable=="Sub_metering_3"],tallDS$value[tallDS$variable=="Sub_metering_3"], col="blue", type = "l")
legend("topright", bty="n",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1,1))

##third plot
with(powerConsumptionDS, plot(powerConsumptionDS$TimeStamp,powerConsumptionDS$Voltage, type = "l", ylab="Voltage", xlab="datetime"))

##fourth plot
with(powerConsumptionDS, plot(powerConsumptionDS$TimeStamp,powerConsumptionDS$Global_reactive_power, type = "l", ylab="Global_reactive_power", xlab="datetime"))

graphics.off()

