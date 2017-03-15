## Title: hcluster_example.R
## Author: Will Streyer
## Date: 3/14/17

## Description:
## Example of hierarchical clustering used to generate factors that can then be
## used to modify data.frames and enhance plots of those data.

## The Coursera Exploratory Data Analysis lectures covering hierarchial clustering
## do not describe how to actually assign records in a database to a cluster.
## This example shows how to accomplish that with a simple example using EPA 
## pollution data from 2008.

## Each observation site has latitude and longitude coordinates, which allows one
## to plot a poor man's map of the United States. The example here simply identifies
## the four major landmasses that appear in the data: Alaska, Hawaii, Puerto Rico,
## and the lower 48 states.

## Load libraries
require(readr)
require(plyr)
require(dplyr)
require(ggplot2)

##download PM2.5 data for 2008
url1 <- "http://aqsdr1.epa.gov/aqsweb/aqstmp/airdata/daily_88101_2008.zip"
my_path <- file.path(getwd(), "PM25", "pm25_08.zip")
download.file(url1, my_path)
unzip(my_path, exdir=file.path(getwd(), "PM25"))

## Import/Select PM2.5 Data
pm25 <- read_csv(file.path(getwd(), "PM25", "daily_88101_2008.csv"))
names(pm25) <- gsub(" ", ".", names(pm25))
pm25s <- select(pm25, state = State.Name,
                county = County.Name, 
                lat = Latitude,
                lon = Longitude,
                pm25 = Arithmetic.Mean)

#Summarize data across measurement sites (determined by latitude and longitude)
pm25s <- pm25s %>% group_by(lat, lon) %>%summarize(pm25 = mean(pm25))

##Plot the map without clustering first if you wish
#g <- ggplot(pm25s, aes(lon,lat))
#g+geom_point()

#Identify landmasses with h-clustering
#Some trial and error determined that the centroid method correctly groups the landmasses
hc <- hclust(dist(pm25s[,1:2]), method = "centroid")

#Convert the hclust results into a usable factor
#cutree() is the key function missing from the Coursera - DSS EDA lectures
landmass <- cutree(hc, k=4)
pm25s$landmass <- as.factor(landmass)
levels(pm25s$landmass) <- c("PR", "HI", "48", "AK")

g <- ggplot(pm25s, aes(lon,lat, color=landmass))
g+geom_point()

