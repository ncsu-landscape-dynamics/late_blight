#Creates two raster
#Raster start: week with the first occurrence of the disease 
#Raster end: the remaining weeks in that given year

library(terra)
library(raster)
setwd("E:/USABlight/data")


infected_file <- "usablight_raster_2019.tif"

s <- rast(infected_file)

late_blight_start <- s[[33]]

late_blight_end <- s[[34:52]]


outname <- paste("late_blight_2019_start.tif")
writeRaster(late_blight_start, filename=outname, overwrite=T)



outname <- paste("late_blight_2019_end.tif")
writeRaster(late_blight_end, filename=outname, overwrite=T)



