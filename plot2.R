#  Plot2


if(!file.exists("./HPC")) {dir.create("./HPC")}
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("./HPC/household_power_consumption.ZIP"))
     {
     download.file(fileurl,"./HPC/household_power_consumption.ZIP")
     unzip("./HPC/household_power_consumption.ZIP",exdir = "./HPC", unzip = "internal",setTimes = FALSE)
     }

plot <- read.table("./HPC/household_power_consumption.txt",sep = ";",header = TRUE)
plot$Date <- as.Date(plot$Date,"%d/%m/%Y")

plot2 <- subset(plot,plot$Date == "2007/02/01" | plot$Date == "2007/02/02" )


plot2$Global_active_power <- as.numeric(as.character(plot2$Global_active_power))
plot2$std <- strptime(paste(plot2$Date, plot2$Time, sep = ""), "%Y-%m-%d %H:%M:%S")

png(file = "plot2.png", width = 480, height = 480)

plot(plot2$std, plot2$Global_active_power,type = "l", lwd = 2, xlab = "", ylab = "Golbal Active Power (kilowatts)")

dev.off()
