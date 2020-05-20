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

png(file="plot2.png")
plot(df1$dateTime,df1$Global_active_power, type="l", main="", xlab = "", ylab="Global Active Power (kilowatts)")
dev.off()