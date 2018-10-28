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
## Check if there is missing value coded by "?" or ""
#sapply(housePower, function(x) "?" %in% x)
#sapply(housePower, function(x) "" %in% x)

###############################################################################
## Step2. Plotting the frequecncy of the Global Active Power
###############################################################################
housePower[,3:9] <- lapply(housePower[,3:9], as.double)
str(housePower)
summary(housePower)
housePower$Global_active_power <- as.double(housePower$Global_active_power)
hist(housePower$Global_active_power, col = "red", 
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

###############################################################################
## Step3. Copying the plot to the png device
###############################################################################
## Set a PNG file with a width of 480 pixels and a height of 480 pixels.
## It's the default setting of png
dev.copy(png, filename = "plot1.png", width = 480, height = 480)
dev.off()

