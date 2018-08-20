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

# Plot 2
png("Plot2.png", width = 480, height = 480)

dplot(power$datetime, power$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

dev.off()