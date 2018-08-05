plot2<- function(filename)
        
{
        
        ## filename<- "household_power_consumption.txt"
        ## e.g. plot2("household_power_consumption.txt")
        
        ## read the data
        
        data<-read.delim(filename,header = TRUE, sep =";", dec=".")
        
        ## subset to get 1st and 2nd feb 2007
        data_subset<-data[(data$Date == "1/2/2007" | data$Date == "2/2/2007"),]
        
        ## set global active power as numeric
        data_subset$Global_active_power<-as.numeric(as.character(data_subset$Global_active_power))
        data_subset$Date<-as.Date(as.character(data_subset$Date), format='%d/%m/%Y')
        
        ## create new column called Date_Time - combination of both date and time column
        data_subset$Date_Time<-paste(data_subset$Date,data_subset$Time)
        data_subset$Date_Time<-strptime(data_subset$Date_Time, format = "%Y-%m-%d %H:%M:%S")
        
        ## plot global active power against dates
        plot(data_subset$Date_Time,data_subset$Global_active_power, type="n",ylab="Global Active Power (kilowatts)",xlab="")
        lines(data_subset$Date_Time,data_subset$Global_active_power)
        
        ## save as png file
        dev.copy(png,file = "plot2.png") ## copy the plot to png file
        dev.off() ##close png device
}