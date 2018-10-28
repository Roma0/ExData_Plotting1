###############################################################################
## Step 1. Reading Data into R and extracting and checking the target Data
###############################################################################
## Download the Raw data if it doesn't exist.
if(!file.exists("./household_power_consumption.txt")){
        Url <- "https://d396qusza40orc.cloudfront.net/"
        Url <- paste0(Url, "exdata%2Fdata%2Fhousehold_power_consumption.zip")
        download.file(Url, destfile = "household_power_consumption.zip", 
                      method = "curl")
        unzip("household_power_consumption.zip")
}

## Load the file into R
housePower <- read.csv2("household_power_consumption.txt",
                        stringsAsFactors = FALSE)
## Read the sample data
head(housePower)
## Extract the datas from the dates 2007-02-01 and 2007-02-02
housePower <- subset(housePower, (Date == "1/2/2007" | Date == "2/2/2007"))
str(housePower)
summary(housePower)
## Check if there is missing value coded by "?" or ""
#sapply(housePower, function(x) "?" %in% x)
#sapply(housePower, function(x) "" %in% x)

###############################################################################
## Step2. Plotting the Global Active Power to time
###############################################################################
housePower[,3:9] <- lapply(housePower[,3:9], as.double)
str(housePower)
summary(housePower)
housePower$NewTime <- paste(housePower$Date, housePower$Time)
housePower$NewTime <- strptime(housePower$NewTime, "%d/%m/%Y %H:%M:%S")
par(mfrow = c(2, 2), mar = c(4,4,1,1))
plot(housePower$NewTime, housePower$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power")
plot(housePower$NewTime, housePower$Voltage, type = "l",
     xlab = "datetime", ylab = "Voltage")
with(housePower, plot(NewTime, Sub_metering_1, type = "n", 
                      ylab = "Energy sub metering", xlab = ""))
with(housePower, points(NewTime, Sub_metering_1, type = "l"))
with(housePower, points(NewTime, Sub_metering_2, type = "l", col = "red"))
with(housePower, points(NewTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", bty = "n", cex = 0.8,
       lty = "solid", col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(housePower$NewTime, housePower$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power")

###############################################################################
## Step3. Copying the plot to the png device
###############################################################################
## Set a PNG file with a width of 480 pixels and a height of 480 pixels.
## It's the default setting of png
dev.copy(png, filename = "plot4.png", width = 480, height = 480)
dev.off()