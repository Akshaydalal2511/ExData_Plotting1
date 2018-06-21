powerFile <- "household_power_consumption.txt"

##Reading only specific Data from 1/1/2007 to 2/1/2007 to avoid subsetting
powerData <- read.table(powerFile,
                        sep = ";", 
                        skip = grep("^1/2/2007",readLines(powerFile))-1,
                        nrows = 2880,
                        na.strings = "?")

##Read the headings of dataframe
headings <- scan(powerFile,
                 what = "character",
                 sep = ";",
                 nlines = 1)

##Assigning headings to data frame
colnames(powerData) <- headings

##Pasting Date and Time together and converting to POSIXct using strptime
powerData$DateTime <- strptime(paste(powerData$Date,powerData$Time),
                               format = "%d/%m/%Y %H:%M:%S")

##Plotting Graphs using png GrDevice
png(file = "ExData_Plotting1/plot4.png")

##Setting plots arrangement as 2*2 filling up columnwise 
par(mfcol = c(2,2))

##First plot of Global Ative Power
with(powerData,plot(DateTime,Global_active_power,
                    ylab = "Global Active Power",
                    xlab = "",
                    type = "l"))

##Second plot of Energy Sub Metering
with(powerData,plot(DateTime,Sub_metering_1,
                    ylab = "Energy Sub Metering",
                    xlab = "",
                    type = "l"))
with(powerData,lines(DateTime,Sub_metering_2,
                     col = "red"))
with(powerData,lines(DateTime,Sub_metering_3,
                     col = "blue"))
legend("topright",
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),
       lty = 1, lwd = 1.5,
       bty = "n")

##Third plot of Voltage
with(powerData,plot(DateTime,Voltage,
                    type = "l"))

##Fourth plot of Reactive Power Consumption
with(powerData,plot(DateTime,Global_reactive_power,
                    type = "l"))
dev.off()