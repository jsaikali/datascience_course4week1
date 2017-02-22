## Joanna Saikali
## 02/22/2017

##determining which rows correspond to dates 2007-02-01 or 2007-02-02
rowsToKeep=grep("2007-02-01|2007-02-02", as.character(as.Date(read.table("household_power_consumption.txt", sep=";", header=TRUE)[,1], "%d/%m/%Y")))

##read in the table of electric power consumption data into variable, only for the relevant dates
powerConsumptionDS<-read.table("household_power_consumption.txt", sep = ";", header=TRUE, colClasses=c("character","character","double","double","double","double","double","double","numeric"), na.strings="?")[rowsToKeep,]

##adjusting classes of columns for convenience of use
powerConsumptionDS$Date<-as.Date(powerConsumptionDS$Date, "%d/%m/%Y")
powerConsumptionDS$TimeStamp<-as.POSIXct(paste(powerConsumptionDS$Date, powerConsumptionDS$Time))

##creating plot3
library(reshape2)
png(file="plot3.png", width=480, height=480)
tallDS<-melt(powerConsumptionDS[,7:10], id=c("TimeStamp"), measure.vars=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
with(tallDS, plot(tallDS$TimeStamp, tallDS$value, type="n", xlab="", ylab="Energy sub metering"))
points(tallDS$TimeStamp[tallDS$variable=="Sub_metering_1"],tallDS$value[tallDS$variable=="Sub_metering_1"], col="black", type = "l")
points(tallDS$TimeStamp[tallDS$variable=="Sub_metering_2"],tallDS$value[tallDS$variable=="Sub_metering_2"], col="red", type = "l")
points(tallDS$TimeStamp[tallDS$variable=="Sub_metering_3"],tallDS$value[tallDS$variable=="Sub_metering_3"], col="blue", type = "l")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1,1))
dev.off()
