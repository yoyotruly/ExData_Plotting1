library(data.table)
library(tidyverse)

# set working directory to local folder
setwd("...")

# import the raw file
power_raw <- fread("household_power_consumption.txt", sep = ";")
str(power_raw)

# subset data to include only observations on Feb 1 & Feb 2, 2007
power <- filter(power_raw, Date == "1/2/2007" | Date == "2/2/2007")
str(power)

# remove the raw file to free up memory
rm(power_raw)

# unite date & time columns
power <- unite(power, datetime, Date, Time, sep = " ")

# convert datetime format
power$datetime <- strptime(power$datetime, format = "%d/%m/%Y %H:%M:%S")

# convert the rest to numeric
power[, 2:7] <- data.frame(mapply(as.numeric, power[, 2:7]))
str(power)

# Plot 3
png("Plot3.png", width = 480, height = 480)

plot(power$datetime, power$Sub_metering_1, type = "l",
     xlab = "",
     ylab = "Energy sub metering")
lines(power$datetime, power$Sub_metering_2, type = "l", col = "red")
lines(power$datetime, power$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()