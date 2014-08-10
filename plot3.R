HPC_DATA <- read.table("household_power_consumption.txt",sep=";",header=TRUE,na.strings="?")
HPC_DATA <- HPC_DATA[HPC_DATA$Date %in% c("1/2/2007","2/2/2007"),]
HPC_DATA$DateTime <-strptime(paste(HPC_DATA$Date,HPC_DATA$Time,sep=" "),"%d/%m/%Y %H:%M:%S")

png(file="plot3.png",width=480,height=480)

plot(HPC_DATA$DateTime,HPC_DATA$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")

lines(HPC_DATA$DateTime,HPC_DATA$Sub_metering_2,type="l",col="red")

lines(HPC_DATA$DateTime,HPC_DATA$Sub_metering_3,type="l",col="blue")

legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"))

dev.off()
