#Stacks all raster files from within a folder

setwd("E:/USABlight")
library(raster)
library(rgdal)
library(lubridate)

raster_files = list.files(("E:/USABlight/2019"), full.names = T)
raster_files

usablight_stack <- stack(raster_files)

outname <- paste("usablight_raster_2019.tif")
rase <- writeRaster(usablight_stack, filename=outname, format='GTiff',
                    overwrite=T)







