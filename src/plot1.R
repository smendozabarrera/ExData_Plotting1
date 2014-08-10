### plot1.R --- 
## 
## Filename: plot1.R
## Description: 
## Author: Sergio-Feliciano Mendoza-Barrera
## Maintainer: 
## Created: Sat Aug  9 17:59:04 2014 (-0500)
## Version: 
## Package-Requires: ()
## Last-Updated: Sat Aug  9 21:00:49 2014 (-0500)
##           By: Sergio-Feliciano Mendoza-Barrera
##     Update #: 64
## URL: 
## Doc URL: 
## Keywords: 
## Compatibility: 
## 
######################################################################
## 
### Commentary: 
## 
## Plo1 1 reproduction
## 
######################################################################
## 
### Change Log:
## 
## 
######################################################################
## 
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or (at
## your option) any later version.
## 
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
## General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.
## 
######################################################################
## 
### Code:
rm(list = ls())                         # Remove all workspace data
library(parallel)
library(data.table)
library(lubridate)

######################################################################
## Download the required files (Run once)
## source("dwDataFile.R")                  # Download the dataset

## fileName <- "household_power_consumption.zip"
## source <-
##         "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"

## dwDataFile(fileName, source)                  # Download the dataset

######################################################################
## Read dataset

dataFN <- "./data/household_power_consumption.txt"
ColNames <- c("Date", "Time", "Global_active_power" ,
              "Global_reactive_power", "Voltage", "Global_intensity",
              "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

## Because data and time of the first item is "12/16/2006 17:24:00",
## so I count the number of items before "01/02/2007 00:00:00" that is
## skipRows = (47 * 60 * 24) - (17 * 60) - 23

## And there have 2 * 24 * 60 items in two days
## myNrows <- 2 * 24 * 60
EPConsumption <- fread(dataFN, sep = ";", header = FALSE, na.strings =
                         "?", colClasses = "character",
                       skip = 66637, nrows = 2880)

setnames(EPConsumption, ColNames)

######################################################################
## Converting the data to easy handle

## Pasting date and time
EPConsumption$myDate <- paste(EPConsumption$Date, EPConsumption$Time, sep=" ")
EPConsumption$myDate <- dmy_hms(EPConsumption$myDate)

## Change the class of data
EPConsumption$Global_active_power <-
        sapply(EPConsumption$Global_active_power, as.numeric)

EPConsumption$Global_reactive_power <-
        sapply(EPConsumption$Global_reactive_power, as.numeric)

EPConsumption$Voltage <-
        sapply(EPConsumption$Voltage, as.numeric)

EPConsumption$Global_intensity <-
        sapply(EPConsumption$Global_intensity, as.numeric)

EPConsumption$Sub_metering_1 <- sapply(EPConsumption$Sub_metering_1,
                                       as.numeric)

EPConsumption$Sub_metering_2 <- sapply(EPConsumption$Sub_metering_2,
                                       as.numeric)

EPConsumption$Sub_metering_3 <- sapply(EPConsumption$Sub_metering_2,
                                       as.numeric)

######################################################################
## Plot code:

## myBreaks <-
##         seq(min(EPConsumption$Global_active_power) * .99999,
##             max(EPConsumption$Global_active_power) * 1.00001,
##             length.out = 12)

## hist(EPConsumption$Global_active_power, col = "red", breaks = myBreaks,
##      main="Global Active Power",
##      xlab="Global Active Power (kilowatts)", freq = TRUE, ylim = c(0, 1200))

## See histogram on the screen
hist(EPConsumption$Global_active_power, col = "red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

pngfile <- "./figure/plot1.png"

if(!file.exists(pngfile)) {

## Open png device to write the plot
png(filename = pngfile, width = 480, height = 480, units =
      "px", pointsize = 12, bg = "transparent")

## Execute plot code
hist(EPConsumption$Global_active_power, col = "red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

## Close device!
dev.off()                               # IMPORTANT!
}

print("***  plot1.R DONE!  ***")

######################################################################
### plot1.R ends here
