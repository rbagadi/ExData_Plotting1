# Load data the file, ";" seperated with below attributes
# Date;
# Time;
# Global_active_power;
# Global_reactive_power;
# Voltage;
# Global_intensity;
# Sub_metering_1;
# Sub_metering_2;
# Sub_metering_3;

HPC_DATA <-read.table("./household_power_consumption.txt",header = TRUE,sep=";") 

# Get names of variables based on the first line of the file.
attach(HPC_DATA)

# Transform Date dd/mm/yyyy format
HPC_DATA$Date <-as.Date(HPC_DATA$Date,format='%d/%m/%Y')

# Select the rows corresponding of the date between 2007-02-01 and 2007-02-02
HPC_DATA_SEC <-HPC_DATA[which(HPC_DATA$Date == "2007-02-01" | HPC_DATA$Date == "2007-02-02"), ]

Sys.setlocale(category = "LC_TIME", locale = "C")

# Fusion of the two columns (Date + Time)
DateTime <- paste(HPC_DATA_SEC$Date,HPC_DATA_SEC$Time, sep = " ")
HPC_DATA_SEC <-cbind(HPC_DATA_SEC,DateTime)

# Prepare labels for the x axis
Date_at <-list(HPC_DATA_SEC$DateTime[1],HPC_DATA_SEC$DateTime[1441],HPC_DATA_SEC$DateTime[2880])
Date_label <- c("Thu","Fri","Sat")

# Transform Global_active_power in numeric type
HPC_DATA_SEC$Global_active_power <-as.numeric(as.character(HPC_DATA_SEC$Global_active_power))

# Transform Global_reactive_power in numeric type
HPC_DATA_SEC$Global_reactive_power <-as.numeric(as.character(HPC_DATA_SEC$Global_reactive_power))

# Transform Voltage in numeric type
HPC_DATA_SEC$Voltage <-as.numeric(as.character(HPC_DATA_SEC$Voltage))

# Transform the 3 variables sub_metering_1, sub_metering_2 and sub_metering_3 in numeric type
HPC_DATA_SEC$Sub_metering_1 <-as.numeric(as.character(HPC_DATA_SEC$Sub_metering_1))
HPC_DATA_SEC$Sub_metering_2 <-as.numeric(as.character(HPC_DATA_SEC$Sub_metering_2))
HPC_DATA_SEC$Sub_metering_3 <-as.numeric(as.character(HPC_DATA_SEC$Sub_metering_3))


# Divide the frame into 4 parts in order to create 4 plots in the same window with a white background
par(mfrow = c(2,2),bg = 'white')

# First plot
plot(HPC_DATA_SEC$DateTime,HPC_DATA_SEC$Global_active_power,ylab="Global Active Power",xaxt = "n")
lines(HPC_DATA_SEC$DateTime,HPC_DATA_SEC$Global_active_power)
axis(side = 1,at=Date_at,labels=Date_label)
# Second plot
plot(HPC_DATA_SEC$DateTime,HPC_DATA_SEC$Voltage,ylab="Voltage",xlab="datetime",xaxt = "n")
lines(HPC_DATA_SEC$DateTime,HPC_DATA_SEC$Voltage)
axis(side = 1,at=Date_at,labels=Date_label)
# Third plot
plot(HPC_DATA_SEC$DateTime,HPC_DATA_SEC$Sub_metering_1,ylab="Energy sub metering",xaxt = "n",type="l")
lines(HPC_DATA_SEC$DateTime,HPC_DATA_SEC$Sub_metering_1)
lines(HPC_DATA_SEC$DateTime,HPC_DATA_SEC$Sub_metering_2,col="firebrick1")
lines(HPC_DATA_SEC$DateTime,HPC_DATA_SEC$Sub_metering_3,col="dodgerblue2")
axis(side = 1,at=Date_at,labels=Date_label)
legend("topright",lwd=c(1,1), bty="n" ,text.width=1450, col = c("black","firebrick1","dodgerblue2"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Fourth plot
plot(HPC_DATA_SEC$DateTime,HPC_DATA_SEC$Global_reactive_power,ylab="Global_reactive_power",xlab="datetime",xaxt = "n")
lines(HPC_DATA_SEC$DateTime,HPC_DATA_SEC$Global_reactive_power)
axis(side = 1,at=Date_at,labels=Date_label)

# Copy the plot to a PNG file
dev.copy(png, file="plot4.png")

# Close the PNG file
dev.off()