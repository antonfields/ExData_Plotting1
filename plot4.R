library(tidyverse)

# Read in the data
filename <- "household_power_consumption.txt"
folder <- "data"
fullpath <- file.path(folder, filename)
data <- read.table(fullpath, header = TRUE, sep = ";", na.strings = "?")

# Create a plot data set by changing the date format and creating a
# DateTime variable to use in plots, and filter the data on the selected dates
plot_data <- data %>%
  mutate(Date = as.Date(Date,"%d/%m/%Y",),
         DateTime = strptime(paste(Date,Time), "%Y-%m-%d %H:%M:%S")) %>%
  filter(Date >= "2007-02-01" & Date <= "2007-02-02")

# Plot 4
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2),
    mar = c(4,4,4,4))

#   plot 4a
plot(plot_data$DateTime,
     plot_data$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

#   plot 4b
plot(plot_data$DateTime,
     plot_data$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

#   plot 4c
plot(plot_data$DateTime,
     plot_data$Sub_metering_1,
     type = "n",
     xlab = "",
     ylab = "Energy sub metering")
points(plot_data$DateTime, plot_data$Sub_metering_1, col = "black", type = "l")
points(plot_data$DateTime, plot_data$Sub_metering_2, col = "red", type = "l")
points(plot_data$DateTime, plot_data$Sub_metering_3, col = "blue", type = "l")
legend("topright",
       bty = "n",
       cex = 0.7,
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"),
       lwd = 2,
       col = c("black", "red", "blue"))

#   plot 4d
plot(plot_data$DateTime,
     plot_data$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()
