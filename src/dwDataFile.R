### dwDataFile.R --- 
## 
## Filename: dwDataFile.R
## Description: dwDataFile <- function(destfile, fileUrl)
## Author: Sergio-Feliciano Mendoza-Barrera
## Created: Sun Jul 20 22:04:18 2014 (-0500)
## Version: 
## Package-Requires: ()
## Last-Updated: Sat Aug  9 20:55:35 2014 (-0500)
##           By: Sergio-Feliciano Mendoza-Barrera
##     Update #: 15
## URL: 
## Doc URL: 
## Keywords: 
## Compatibility: 
## 
######################################################################
## 
### Commentary: 
## 
## Download data using download.file() method
## 
######################################################################
## 
### Change Log:
## 
## 
######################################################################
## 
## This program is free software; you can redistribute it and/or
## modify it under the terms of the GNU General Public License as
## published by the Free Software Foundation; either version 3, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
## General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program; see the file COPYING.  If not, write to
## the Free Software Foundation, Inc., 51 Franklin Street, Fifth
## Floor, Boston, MA 02110-1301, USA.
## 
######################################################################
## 
### Code:

dwDataFile <- function(destfile, fileUrl) {

        ##############################################################
        ## Check that state and outcome are valid
        if(!(hasArg(destfile) & hasArg(fileUrl))) {
                stop("\t\nArguments are not complete!\n")
        }

        if(!file.exists("data")) {
                dir.create("data")
        }

        directory <- "data"             # Setting data directory

        destfile <- paste(".", directory, destfile, sep = "/")
        
        if(!file.exists(destfile)) {
                download.file(fileUrl, destfile, method = "curl")
                print(list.files(directory))
                dateDownloaded <- date()
        }
        print("Download done !")
}
######################################################################
### dwDataFile.R ends here
