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

# Plot 4
png("Plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))

plot(power$datetime, power$Global_active_power, type = "l",
     ylab = "Global Active Power",
     xlab = "")

plot(power$datetime, power$Voltage, type = "l",
     xlab = "datetime",
     ylab = "Voltage")

plot(power$datetime, power$Sub_metering_1, type = "l",
     xlab = "",
     ylab = "Energy sub metering")
lines(power$datetime, power$Sub_metering_2, type = "l", col = "red")
lines(power$datetime, power$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, bty = "n",
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(power$datetime, power$Global_reactive_power, type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()
