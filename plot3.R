#  Plot3

library(reshape2)

if(!file.exists("./HPC")) {dir.create("./HPC")}
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("./HPC/household_power_consumption.ZIP"))
{
     download.file(fileurl,"./HPC/household_power_consumption.ZIP")
     unzip("./HPC/household_power_consumption.ZIP",exdir = "./HPC", unzip = "internal",setTimes = FALSE)
}


plot <- read.table("./HPC/household_power_consumption.txt",sep = ";",header = TRUE)
plot$Date <- as.Date(plot$Date,"%d/%m/%Y")

plot3 <- subset(plot,plot$Date == "2007/02/01" | plot$Date == "2007/02/02" )


plot3$Sub_metering_1 <- as.numeric(as.character(plot3$Sub_metering_1))
plot3$Sub_metering_2 <- as.numeric(as.character(plot3$Sub_metering_2))
plot3$Sub_metering_3 <- as.numeric(as.character(plot3$Sub_metering_3))
plot3$std <- as.character(strptime(paste(plot3$Date, plot3$Time, sep = ""), "%Y-%m-%d %H:%M:%S"))

df <- melt(plot3, id="std", measure.vars = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
df$std <- strptime(df$std,"%Y-%m-%d %H:%M:%S")


png( file = "plot3.png", width = 480, height = 480)

with(df,plot(std,value, type = "n", xlab = "", ylab = "Energy sub metering")) # initiate plot
with(subset(df,variable == "Sub_metering_1"), lines(std, value, col = "black"))
with(subset(df,variable == "Sub_metering_2"), lines(std, value, col = "blue"))
with(subset(df,variable == "Sub_metering_3"), lines(std, value, col = "red"))

legend("topright", lty = 1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


dev.off()
