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

# Plot 3
png("plot3.png", width = 480, height = 480)
plot(plot_data$DateTime,
     plot_data$Sub_metering_1,
     type = "n",
     xlab = "",
     ylab = "Energy sub metering")
points(plot_data$DateTime, plot_data$Sub_metering_1, col = "black", type = "l")
points(plot_data$DateTime, plot_data$Sub_metering_2, col = "red", type = "l")
points(plot_data$DateTime, plot_data$Sub_metering_3, col = "blue", type = "l")
legend("topright",
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"),
       lwd = 2,
       col = c("black", "red", "blue"))
dev.off()