library(openSTARS)

gisbase ='/usr/local/opt/grass7/grass-base'
initGRASS(gisBase = gisbase, home = tempdir(), gisDbase = tempdir(), location='test', 
	mapset="PERMANENT", override = TRUE)

initGRASS(gisBase ='/usr/local/opt/grass7/grass-base', override=TRUE)
initGRASS(gisBase ='/Applications/GRASS-7.8.app/Contents/MacOS', 
          location = 'geostat2012_ll', mapset = 'user1', 
          gisDbase = '/Users/Lars/Documents/Biologi/grassdata', override = TRUE)

# Source this file at the top of an R or Rmd file using rgrass7 together
# with GRASS installed via OSGeo4W (https://trac.osgeo.org/osgeo4w/) on a
# Windows machine.

# e.g. source(file.path(getwd(), 'rgrass7-setup-win-osgeo4w.R'))

# You can alternatively add the contents to a project-specific .Rprofile.

# Its better to set these variables in an R session rather than in System,
# especially if you have other GIS software like PostGIS installed, which has
# its own GDAL_DATA path. This is also the only solution for Windows users on
# accounts lacking admin rights.

# Note that if you call `library(sf)` after setting these variables, GDAL_DATA
# will be overwritten!

# These paths are current to 2020-07-21 and may change in future. If you get
# stuck, open a question on gis.stackexchange or r-sig-geo. I'm not resourced
# to respond to one-on-one contacts on this topic.

# Change this if you installed OSGeo4W in a non standard location:
Sys.setenv('OSGEO4W_ROOT' = file.path('C:', 'OSGeo4W64'))

Sys.setenv('PROJ_LIB' =
             file.path(Sys.getenv('OSGEO4W_ROOT'), 'share', 'proj'))
Sys.setenv('GRASS_PROJSHARE' =
             file.path(Sys.getenv('OSGEO4W_ROOT'), 'share', 'proj'))
Sys.setenv('GDAL_DATA' =
             file.path(Sys.getenv('OSGEO4W_ROOT'), 'share', 'gdal'))
Sys.setenv('GEOTIFF_CSV' =
             file.path(Sys.getenv('OSGEO4W_ROOT'), 'share', 'epsg_csv'))
Sys.setenv('GRASS_PYTHON' =
             file.path(Sys.getenv('OSGEO4W_ROOT'), 'bin', 'python3.exe'))
Sys.setenv('PYTHONHOME' =
             file.path(Sys.getenv('OSGEO4W_ROOT'), 'apps', 'Python37'))
Sys.setenv('GISBASE' =
             file.path(Sys.getenv('OSGEO4W_ROOT'), 'apps', 'grass', 'grass78'))
Sys.setenv('PYTHONPATH' =
             paste(Sys.getenv('PYTHONHOME'),
                   file.path(Sys.getenv('GISBASE'), 'etc', 'python'),
                   sep = .Platform$path.sep))

# not essential, but for the sake of completeness:
Sys.setenv('FONTCONFIG_FILE'= 
             file.path(Sys.getenv("GISBASE"), 'etc', 'fonts.conf'))

# NB these next two will vary depending on how your windows install is handled.
# The GRASS7 folder will also not exist on your system on a fresh install until
# you've opened the program GUI at least once. Comment them out if you don't
# want/need addons and/or don't need the rc information (that file just
# remembers the last grass session opened)

Sys.setenv('GISRC' =
             file.path(Sys.getenv('USERPROFILE'), 'AppData', 'Roaming',
                       'GRASS7', 'rc'))
Sys.setenv('GRASS_ADDON_PATH' =
             file.path(Sys.getenv('USERPROFILE'), 'AppData', 'Roaming',
                       'GRASS7', 'addons'))
# Lastly,
Sys.setenv('PATH' = paste(Sys.getenv("PATH"),
                          file.path(Sys.getenv('OSGEO4W_ROOT'), 'bin'),
                          Sys.getenv('PYTHONHOME'),
                          Sys.getenv('PYTHONPATH'),
                          file.path(Sys.getenv('GISBASE'), 'bin'),
                          file.path(Sys.getenv('GISBASE'), 'scripts'),
                          file.path(Sys.getenv('GISBASE'), 'lib'),
                          sep = .Platform$path.sep))

# Be aware that if you have other Python or GRASS installs on your path already,
# you might need to move `Sys.getenv("PATH")` to the end of the `paste()`.

grass_program_path <- "/usr/local/opt/grass7/grass-base"


dem_path <- "/Users/jhosen/gdrive/michigan_temp_tif/USGS_one_meter_x37y512_MI_Ottawa_NF_2017.tif"
grass_db_path <- "/Users/jhosen/michigan_temps/grassDB/file10b5545a972"
setup_grass_environment(dem = dem_path, 
                        gisBase = grass_program_path,
                        gisDbase = tempdir(),
#                        remove_GISRC = TRUE,
                        override = TRUE
                        )


sites_path<-"/Users/jhosen/michigan_temps/paint_river_sites.shp"
import_data(dem=dem_path,sites=sites_path)