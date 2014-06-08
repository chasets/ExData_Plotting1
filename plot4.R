# TSC 2014-06-07
# Coursera exdata-003 Project 1
# Plot #4

# 
# Only 2 days are needed, so pre-process in a posix shell to get only days we need
# Don't need this in the repo, so do everything in the directory above the repo
# run in shell
#   head -n1 household_power_consumption.txt > hpc.txt
#   cat household_power_consumption.txt | grep '^1/2/2007' >> hpc.txt
#   cat household_power_consumption.txt | grep '^2/2/2007' >> hpc.txt

f <- '../hpc.txt' 

df <- read.table(f, header=TRUE, sep=';',
                 colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
                 na.strings = c("?")
)

df$DateTime <- with(df, as.POSIXct(strptime(paste(Date, Time), format="%d/%m/%Y %H:%M:%S")))
df$Date <- with(df, as.Date(Date, format="%d/%m/%Y"))
df <- subset(df, select = -c(Time))   # this time is just a char; we don't need it


# Plot #4
png("figure/plot4.png", width = 480, height = 480, units = "px", bg = "transparent")
par(mfrow = c(2,2))
with(df, {
    plot(DateTime, Global_active_power, type="l", ylab="Global Active Power", xlab="")
    plot(DateTime, Voltage, type="l", xlab="datetime", ylab="Voltage")
    plot(DateTime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
    lines(DateTime, Sub_metering_2, col="red")
    lines(DateTime, Sub_metering_3, col="blue")
    legend("topright", lty=1, col=c("black", "red", "blue"), 
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(DateTime, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
}
)
dev.off()

