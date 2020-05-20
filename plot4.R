filename = "/Users/arnoldchang/Downloads/household_power_consumption.txt"
colClasses <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric","numeric","numeric")
df1 <- read.table(filename,header=TRUE,sep=";", na.strings = "?", colClasses = colClasses)

df1$Date <- as.Date(df1$Date, "%d/%m/%Y")


df1 <- subset(df1, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
df1 <- df1[complete.cases(df1),]

dateTime <- paste(df1$Date, df1$Time)
df1 <- cbind(dateTime,df1)
df1$dateTime <- as.POSIXct(dateTime)

df1 <- subset(df1, select = -c(Date,Time))

png(file="plot4.png")

par(mfcol = c(2,2))
plot(df1$dateTime,df1$Global_active_power, type="l", main="", xlab = "", ylab="Global Active Power (kilowatts)")
labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
plot(df1$dateTime, df1$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
lines(df1$dateTime, df1$Sub_metering_2, col="red")
lines(df1$dateTime, df1$Sub_metering_3, col="blue")
legend("topright", legend=labels, col=c("black","red","blue"), lty="solid")
plot(df1$dateTime,df1$Voltage, type="l", main="", xlab = "datetime", ylab="Voltage")
plot(df1$dateTime,df1$Global_reactive_power, type="l", main="", xlab = "datetime", ylab="Global_reactive_power")
dev.off()