library(dplyr, data.table)


#check for file 
if (!file.exists("household_power_consumption.txt")){
  temp <- tempfile()
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

#open PNG device
png("plot1.png", height = 480, width = 480, units = "px")


#create plot
with(plotdata, hist(Global_active_power, col = "red",main = "Global Active Power"
                    ,xlab = "Global Active Power (kilowatts)"))
#close the device
dev.off()
