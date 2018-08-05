plot4<- function(filename)
        
{
        par(mfcol = c(2,2))

        ## filename<- "household_power_consumption.txt"
        ## e.g. plot4("household_power_consumption.txt")
        
        ## read the data

        data<-read.delim(filename,header = TRUE, sep =";", dec=".")

        ## subset to get 1st and 2nd feb 2007
        data_subset<-data[(data$Date == "1/2/2007" | data$Date == "2/2/2007"),]

        ## set global active power as numeric
        data_subset$Global_active_power<-as.numeric(as.character(data_subset$Global_active_power))
        data_subset$Sub_metering_1<-as.numeric(as.character(data_subset$Sub_metering_1))
        data_subset$Sub_metering_2<-as.numeric(as.character(data_subset$Sub_metering_2))
        data_subset$Sub_metering_3<-as.numeric(as.character(data_subset$Sub_metering_3))
        data_subset$Global_reactive_power<-as.numeric(as.character(data_subset$Global_reactive_power))
        data_subset$Voltage<-as.numeric(as.character(data_subset$Voltage))
        data_subset$Date<-as.Date(as.character(data_subset$Date), format='%d/%m/%Y')

        ## create new column called Date_Time - combination of both date and time column
        data_subset$Date_Time<-paste(data_subset$Date,data_subset$Time)
        data_subset$Date_Time<-strptime(data_subset$Date_Time, format = "%Y-%m-%d %H:%M:%S")
        
   
        ## plot global active power against dates
        plot(data_subset$Date_Time,data_subset$Global_active_power, type="l",ylab="Global Active Power (kilowatts)",xlab="")

        ##plot sub metering against date
        plot(data_subset$Date_Time,data_subset$Sub_metering_1,type="l", col="black",ylab="Energy sub metering",xlab="",ylim=c(0,max(data_subset$Sub_metering_1,data_subset$Sub_metering_2,data_subset$Sub_metering_3)))
        lines(data_subset$Date_Time,data_subset$Sub_metering_2, col = "red")
        lines(data_subset$Date_Time,data_subset$Sub_metering_3, col = "blue")
        legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, cex=0.5, col=c("black", "red", "blue"))
        
        ## plot voltage against dates
        plot(data_subset$Date_Time,data_subset$Voltage, type="l",ylab="Voltage",xlab="datetime")
        
        #plot global reactive power against date
        plot(data_subset$Date_Time,data_subset$Global_reactive_power, type="l",ylab="Global reactive power",xlab="datetime")

        ## save as png file
        dev.copy(png,file = "plot4.png") ## copy the plot to png file
        dev.off() ##close png device
        }

