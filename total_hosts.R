library(raster)
setwd("E:/USABlight/data")

hosts <- raster("E:/USABlight/data/CDL_2019_36.tif")

total_hosts <- hosts 

total_hosts[] <- 100


outname <- paste("total_hosts_2019.tif")
writeRaster(total_hosts, filename=outname, format='GTiff', overwrite=T)


plot(total_hosts)
plot(hosts)
