d <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type Date
d$Date <- as.Date(d$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
d <- subset(d,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
d <- d[complete.cases(d),]

## Combine Date and Time column
dateTime <- paste(d$Date, d$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
d <- d[ ,!(names(d) %in% c("Date","Time"))]

## Add DateTime column
d <- cbind(dateTime, d)

## Format dateTime Column
d$dateTime <- as.POSIXct(dateTime)

## Create Plot 3
with(d, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(0.2,0.2,0.2),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.2)

## Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()