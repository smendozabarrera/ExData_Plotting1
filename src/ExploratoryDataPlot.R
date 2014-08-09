### ExploratoryDataPlot.R --- 
## 
## Filename: ExploratoryDataPlot.R
## Description: 
## Author: Sergio-Feliciano Mendoza-Barrera
## Maintainer: 
## Created: Sat Aug  9 09:14:48 2014 (-0500)
## Version: 
## Package-Requires: ()
## Last-Updated: Sat Aug  9 15:05:21 2014 (-0500)
##           By: Sergio-Feliciano Mendoza-Barrera
##     Update #: 138
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

EPConsumption <- fread(dataFN, sep = ";", header = FALSE, na.strings =
                         "?", colClasses = "character",
                       skip = 21997, nrows = 2880)

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

dim(EPConsumption)


######################################################################
### ExploratoryDataPlot.R ends here
