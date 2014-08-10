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

# French to English
Sys.setlocale(category = "LC_TIME", locale = "C")

# Fusion of the two columns (Date + Time)
DateTime <- paste(HPC_DATA_SEC$Date,HPC_DATA_SEC$Time, sep = " ")
HPC_DATA_SEC <-cbind(HPC_DATA_SEC,DateTime)

# Prepare labels for the x axis
Date_at <-list(HPC_DATA_SEC$DateTime[1],HPC_DATA_SEC$DateTime[1441],HPC_DATA_SEC$DateTime[2880])
Date_label <- c("Thu","Fri","Sat")

# Transform Global_active_power in numeric type
HPC_DATA_SEC$Global_active_power <-as.numeric(as.character(HPC_DATA_SEC$Global_active_power))

# Get a with a white background
par(bg = 'white')

# Create a plot on screen device (+ title, color etc...)
plot(HPC_DATA_SEC$DateTime,HPC_DATA_SEC$Global_active_power,ylab="Global Active Power (kilowatts)",xaxt = "n")
lines(HPC_DATA_SEC$DateTime,HPC_DATA_SEC$Global_active_power)
axis(side = 1,at=Date_at,labels=Date_label)


# Copy the plot to a PNG file
dev.copy(png, file="plot2.png")

# Close the PNG file
dev.off()