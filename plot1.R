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

# Plot 1
png("plot1.png", width = 480, height = 480)
hist(plot_data$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()