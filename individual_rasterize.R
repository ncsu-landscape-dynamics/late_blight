setwd("E:/USABlight")
library(raster)
library(rgdal)
library(lubridate)
library(sp)


cdl <- raster("E:/USABlight/data/CDL_2011_36.tif")
usablight <- readOGR("E:/USABlight/data/usablight_2011_2019_NY.gpkg")

usablight <- spTransform(usablight,crs(cdl))

cellsize = res(cdl)
ext <- extent(cdl)
coord <- crs(cdl)
raster1 <- raster(res = cellsize, ext, crs=coord)

usablight$count <- 1
Years <- unique(usablight$Year)

usablight$NewObservatio <- strptime(as.character(usablight$Observatio), "%Y/%m/%d")
usablight$TxtObservatio <- format(usablight$NewObservatio,"%Y-%m-%d")

start_date <- "2011-01-01"
dates <- as.Date(start_date) + lubridate::weeks(0:(52*9))
Year <- lubridate::year(start_date)
Year2 <- Year


for (i in 2:length(dates)){
  date1 <- dates[i-1]
  date2 <- dates[i]
  int <- interval(ymd(date1),ymd(date2))
  
  usablight_subset <- usablight[ymd(c(usablight$TxtObservatio)) %within% int, c("count")]
  
  
  if(length(usablight_subset) > 0) {
    #    usablight_raster <- rasterize(usablight_subset, raster, fun="count")
    usablight_raster <- rasterize(usablight_subset, raster1) 
    usablight_raster <- usablight_raster$count 
    
    #    outname <- paste("usablight_raster", date2, ".tif", sep="_")
    #    rase <- writeRaster(usablight_raster, filename=outname, format='GTiff',
    #                      overwrite=T)
  } else {
    usablight_raster <- raster(res = cellsize, ext, crs=coord)
    usablight_raster[] <- 0
    #    outname <- paste("usablight_raster", date2, ".tif", sep="_")
    #    rase <- writeRaster(usablight_raster, filename=outname, format='GTiff',
    #                        overwrite=T)
  }

  outname <- paste("usablight_raster", date2, ".tif", sep="_")
  rase <- writeRaster(usablight_raster, filename=outname, format='GTiff', overwrite=T)
    
}



