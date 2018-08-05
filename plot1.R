plot1<- function(filename)
        
{

## filename<- "household_power_consumption.txt"
## e.g. plot1("household_power_consumption.txt")
        
## read the data

data<-read.delim(filename,header = TRUE, sep =";", dec=".")

## subset to get 1st and 2nd feb 2007
data_subset<-data[(data$Date == "1/2/2007" | data$Date == "2/2/2007"),]

## set global active power as numeric
data_subset$Global_active_power<-as.numeric(as.character(data_subset$Global_active_power))

## Plot histogram
hist(data_subset$Global_active_power, col = "red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

## save as png file
dev.copy(png,file = "plot1.png") ## copy the plot to png file
dev.off() ##close png device

}