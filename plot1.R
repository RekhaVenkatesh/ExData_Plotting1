##Download the file at runtime, and unzip
data <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",data)
con <- unz(data, "household_power_consumption.txt")
dfAll <- read.table(con, header=TRUE, sep=";", na.strings="?")
unlink(data)

##Load required libraries
library(dplyr)
library(lubridate)

#Subset data only for two days; [2880,9]
df <- filter(dfAll, Date=="1/2/2007" | Date=='2/2/2007')
df2 <- mutate(df, Date=dmy(Date), Time = hms(Time))

hist(df2$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")
dev.copy(png, "plot1.png")
dev.off()