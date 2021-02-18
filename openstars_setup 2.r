library(openSTARS)

grass_program_path <- "/Applications/GRASS-7.8.app/Contents/Resources/"
dem_path <- "/Users/primer2/michigan_data/paint_river_dem_2.tif"

grass_db_path <- "/Users/jhosen/michigan_temps/grassDB/file10b5545a972"
setup_grass_environment(
						dem = dem_path, 
                        gisBase = grass_program_path,
                        gisDbase = tempdir(),
                        remove_GISRC = TRUE,
                        override = TRUE
                        )


sites_path<-"/Users/primer2/michigan_data/paint_river_sites.shp"

check_projection(dem_path)
check_projection(sites_path)

#this imports the DEM and sites into GRASS
import_data(dem=dem_path,sites=sites_path)



library(sp)
#this extracts the DEM from GRASS into R for plotting.
dem <- readRAST("dem", ignore.stderr = TRUE)
#this does the same for sites.
sites <- readVECT("sites_o", type="point",with_c=TRUE)
#psources <- readVECT("psources", ignore.stderr = TRUE)
#lu <- readRAST("landuse_r", ignore.stderr = TRUE)

#now we try plotting.
plot(dem, col = gray(seq(0,1,length.out=20)))
cols <- colorRampPalette(c("blue", "red"))(length(sites$value))[rank(sites$value)]
points(sites, pch = 16, col = cols)
#points(psources, pch = 19, col = 1, cex = 1.7)
#legend(x = par("usr")[2]*0.991, y = par("usr")[4]*0.999, pch = c(16, 16, 19), ncol = 1, col = c(range(cols),1), legend = c(paste("value at sites:", c(range(sites$value))), "point sources"))







