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

##Plotting Graph using png GrDevice
png(file = "ExData_Plotting1/plot2.png")
with(powerData,plot(DateTime,Global_active_power,
                    ylab = "Global Active Power (kilowatts)",
                    xlab = "",
                    type = "l"))
dev.off()