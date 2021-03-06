### ExploratoryDataPlot.R --- 
## 
## Filename: ExploratoryDataPlot.R
## Description: 
## Author: Sergio-Feliciano Mendoza-Barrera
## Maintainer: 
## Created: Sat Aug  9 09:14:48 2014 (-0500)
## Version: 
## Package-Requires: ()
## Last-Updated: Sat Aug  9 21:57:18 2014 (-0500)
##           By: Sergio-Feliciano Mendoza-Barrera
##     Update #: 142
## URL: 
## Doc URL: 
## Keywords: 
## Compatibility: 
## 
######################################################################
## 
### Commentary: 
## 
## Exploratory Data Analysis
## Project 1
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
## Download the required files
## source("dwDataFile.R")                  # Download the dataset

## fileName <- "household_power_consumption.zip"
## source <-
##         "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

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

## head(EPConsumption, n = 10)
## tail(EPConsumption, n = 10)

######################################################################
## Converting the data to easy handle

## Pasting date and time
EPConsumption$myDate <- paste(EPConsumption$Date, EPConsumption$Time, sep=" ")
EPConsumption$myDate <- dmy_hms(EPConsumption$myDate)
## head(EPConsumption)

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

## sapply(EPConsumption, mode)             # Testing NA values existence
## sapply(EPConsumption, class)
## anyNA(EPConsumption)

## dim(EPConsumption)

## Test!
## I seem to have the right subset, but the data seems to be mismatched.
## I have 2880 rows. I created this by using the following code.


## filename="data/household_power_consumption.txt"
## hpcdata<-read.csv.sql(filename,sep=";",sql='select * from file where Date="2/1/2007" OR Date="2/2/2007"')
## hpcdata$Date<-strptime(paste(hpcdata$Date,hpcdata$Time),format)
## The summary looks like this.

## > summary(hpcdata)
##       Date                         Time           Global_active_power Global_reactive_power
##  Min.   :2007-02-01 00:00:00   Length:2880        Min.   :0.220       Min.   :0.0000       
##  1st Qu.:2007-02-01 11:59:45   Class :character   1st Qu.:0.380       1st Qu.:0.0000       
##  Median :2007-02-01 23:59:30   Mode  :character   Median :0.532       Median :0.1100       
##  Mean   :2007-02-01 23:59:30                      Mean   :1.020       Mean   :0.1145       
##  3rd Qu.:2007-02-02 11:59:15                      3rd Qu.:1.466       3rd Qu.:0.1620       
##  Max.   :2007-02-02 23:59:00                      Max.   :5.448       Max.   :0.8620       
##     Voltage      Global_intensity Sub_metering_1 Sub_metering_2   Sub_metering_3  
##  Min.   :233.9   Min.   : 1.000   Min.   :0      Min.   :0.0000   Min.   : 0.000  
##  1st Qu.:239.0   1st Qu.: 1.600   1st Qu.:0      1st Qu.:0.0000   1st Qu.: 0.000  
##  Median :241.4   Median : 2.200   Median :0      Median :0.0000   Median : 0.000  
##  Mean   :241.1   Mean   : 4.292   Mean   :0      Mean   :0.2444   Mean   : 6.215  
##  3rd Qu.:243.0   3rd Qu.: 6.000   3rd Qu.:0      3rd Qu.:0.0000   3rd Qu.:17.000  
##  Max.   :250.0   Max.   :23.000   Max.   :0      Max.   :2.0000   Max.   :19.000  



######################################################################
### ExploratoryDataPlot.R ends here
