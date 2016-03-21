library(dplyr, data.table)

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unzip(temp))
data <- fread(unzip(temp),sep= ";",na.strings = "?",nrows = 100)

data2 <- select(mutate(data,date = as.Date(Date,format = "%d/%m/%Y")),2:10)

dt <- as.POSIXlt(paste(data3$Date,data3$Time), "%d/%m/%Y %H:%M:%S", tz = "")

