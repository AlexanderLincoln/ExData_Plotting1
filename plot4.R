library(dplyr, data.table)


#check for file 
if (!file.exists("household_power_consumption.txt")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
} else {
  file <- "./household_power_consumption.txt"
}


#Check for data
if (!exists("plotdata")) {
  data <- fread(file,sep= ";",na.strings = "?")
  plotdata <- filter(data,Date =="1/2/2007" | Date=="2/2/2007")
  plotdata$Date <-as.Date(plotdata$Date,format = "%d/%m/%Y")
  plotdata$dt <- as.POSIXct(paste(plotdata$Date,plotdata$Time))
}  

series<- colnames(plotdata)[7:9]
plotcolors <- c("green","red","blue")


#open PNG device
png("plot4.png", height = 480, width = 480, units = "px")

#create plots

par(mfcol= c(2,2),mar = c(4, 4, 2, 1))

with(plotdata, plot(dt,Global_active_power, type = "l",ylab = "Global Active Power (kilowatts)",xlab = ""))


with(plotdata, plot(dt,Sub_metering_1, type = "l",ylab = "Global Active Power (kilowatts)",col = plotcolors[1]))
with(plotdata, lines(dt,Sub_metering_2, type = "l",col = plotcolors[2]))
with(plotdata, lines(dt,Sub_metering_3, type = "l",col = plotcolors[3]))
legend("topright",legend = series,col=plotcolors,lty =1 )

with(plotdata, plot(dt,Voltage, type = "l",ylab = "Voltage",xlab = "datetime"))
with(plotdata, plot(dt,Global_reactive_power, type = "l",ylab = "Global Reactive Power",xlab = "datetime"))


#close the device
dev.off()
