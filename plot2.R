##Download the file at runtime
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
df2 <- mutate(df, Date=dmy(Date), Time=hms(Time))
##Create a new column that will combine date and time
df2$DateTime <- strptime(paste(df$Date,df$Time),format = "%d/%m/%Y %H:%M:%S")

plot(df2$DateTime, df2$Global_active_power, type="l", xlab="",ylab="Global Active Power (kilowatts)")

dev.copy(png, "plot2.png")
dev.off()