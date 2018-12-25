#  Plot4

library(reshape2)

if(!file.exists("./HPC")) {dir.create("./HPC")}
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("./HPC/household_power_consumption.ZIP"))
     {
     download.file(fileurl,"./HPC/household_power_consumption.ZIP")
     unzip("./HPC/household_power_consumption.ZIP",exdir = "./HPC", unzip = "internal",setTimes = FALSE)
     }

df <- read.table("./HPC/household_power_consumption.txt",sep = ";",header = TRUE)
df$Date <- as.Date(df$Date,"%d/%m/%Y")

plot <- subset(df,df$Date == "2007/02/01" | df$Date == "2007/02/02" )


Global_active_power <- as.numeric(as.character(plot$Global_active_power))
Global_reactive_power <- as.numeric(as.character(plot$Global_reactive_power))
Voltage <- as.numeric(as.character(plot$Voltage))
datetime  <- strptime(paste(plot$Date, plot$Time, sep = ""), "%Y-%m-%d %H:%M:%S")

plot$Sub_metering_1 <- as.numeric(as.character(plot$Sub_metering_1))
plot$Sub_metering_2 <- as.numeric(as.character(plot$Sub_metering_2))
plot$Sub_metering_3 <- as.numeric(as.character(plot$Sub_metering_3))
plot$datetime <- as.character(datetime)

#  melting the data for creating third plot energy sub metering v/s datetime

melt_data <- melt(plot, id="datetime", measure.vars = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
melt_data$datetime <- strptime(melt_data$datetime,"%Y-%m-%d %H:%M:%S")


png(file= "plot4.png", width = 480, height = 480) #  initiate the png

par(mfrow = c(2,2), mar = c(4,4,1,1))

# Plot 1
plot(datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Plot 2
plot(datetime,Voltage,type = "l")               

# Plot 3
with(melt_data,plot(datetime,value, type = "n", xlab = "", ylab = "Energy sub metering")) # initiate plot
with(subset(melt_data,variable == "Sub_metering_1"), lines(datetime, value, col = "black"))
with(subset(melt_data,variable == "Sub_metering_2"), lines(datetime, value, col = "blue"))
with(subset(melt_data,variable == "Sub_metering_3"), lines(datetime, value, col = "red"))
legend("topright", lty = 1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")

# Plot 4
plot(datetime,Global_reactive_power,type = "l")


dev.off()

