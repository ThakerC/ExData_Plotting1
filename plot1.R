#  Plot1


if(!file.exists("./HPC")) {dir.create("./HPC")}
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("./HPC/household_power_consumption.ZIP"))
{
     download.file(fileurl,"./HPC/household_power_consumption.ZIP")
     unzip("./HPC/household_power_consumption.ZIP",exdir = "./HPC", unzip = "internal",setTimes = FALSE)
}


plot <- read.table("./HPC/household_power_consumption.txt",sep = ";",header = TRUE)
plot1 <- subset(plot,as.Date(plot$Date,"%d/%m/%Y") == "2007/02/01" | as.Date(plot$Date,"%d/%m/%Y") == "2007/02/02" )

png(file = "plot1.png", width = 480, height = 480)

hist(as.numeric(as.character(plot1$Global_active_power)), col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.off()
