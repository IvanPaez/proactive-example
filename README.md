# proactive-example

Created by: IvanPaez ivan.paez_anaya@irisa.fr 
Universite de Rennes 1 - INRIA Bretagne-Atlantique, France

Description: These are the worlflows of the fire monitoring example of the proactive approach 


KNIME workflow: 01 - Download ISH metadata
downloads a list of weather stations (ISH) from ftp.ncdc.noaa.gov
some stations were only available in some years
each station has a timespan (begin..end) geolocaton (lat/lon/elev)
output is ish-hiostory.table file (KNIME internal format)

KNIME Workflow: 02 - Select ISH stations and download data
this workflow takes only ISH stations from Mississippi that were active in the year 2010
downloads "*.gz" compressed files containing their hourly temperatures from 2010
files are downloaded from ftp://ftp.ncdc.noaa.gov/pub/data/noaa/2010/ and stored SEAMS14-proact/data/ISH/ish-downloaded directory
the workflow also contains some optional visualizations (using OSM Map View)
list of all ISH stations
list of stations in Mississippi
list of stations in Mississippi with color representing distance from "MERIDIAN NAS" station
Shell script: SEAMS14-proact/data/ISH/extract-ish-downloaded.sh
extracts all "*.gz" files (from ish-downloaded dir) into "*.txt" files (SEAMS14-proact/data/ISH/ish-extracted directory)

KNIME Workflow: 03 - Normalize ISH data
reads data from ish-extracted dir
converts them into CSV format while "normalizing" the data (e.g. interpolating missing values)
CSV files are saved into SEAMS14-proact/data/ISH/ish-normalized directory
there is an optional sub-workflow to visualize the quality of data (OSM Map View, green=ok, red=rubbish)

KNIME Workflow: 04 - Enrich ISH data
reads data from ish-normalized dir
removes low-quality data sources
data preprocessing:
compute moving averages (MAs) for past day (MA_Day_past), week (MA_Week_past), month (MA_Month_past)
computes daily seasonal component: SC_Day = MA_Day_past - MA_Month_past
computes fire potential (FirePotential) using a rule: 
$Temp$ < 15 => "Low"
$Temp$ < 25 => "Normal"
TRUE => "High"
computes lags (-1,-2,-3,...) and anti-lags (+1, +2,+3...) for Temp and FirePotential columns
assuming I'm now at the time t (row t in my table)
I'll find in column Temp the current temperature
In column Temp(-1) the temperature from the previous hour
In column Temp(-8) the temperature from 8 hours ago
Similarly, In column Temp(+1) the temperature from next hour
In column Temp(+10) the temperature that is 10 hours in future
writes the data into SEAMS14-proact/data/ISH/ish-enriched directory as *.table files (KNIME internal format)
each files represents data from a single ISH station (in Mississippi in year 2010)

KNIME Workflow: 05 - Fire Reports (Download)
downloads fire reports data (*.kmz files) from:
MODIS: http://activefiremaps.fs.fed.us/data/kml/conus_hist/2010/
AVHRR: http://activefiremaps.fs.fed.us/data_avhrr/kml/conus_hist/
Stores the KMZ files into MapsDownload directory within KNIME workspace
Then I manually moved the directory into SEAMS14-proact/data/Fire Reports/MODIS directory
Further in the pipeline, only the MODIS data are used!
All KMZ files are extracted into KML files in a temporary directory
data from KML files are extracted using a XML parser (XPath expressions)
all extracted data are stored in a single table: SEAMS14-proact/data/Fire Reports/FireReports.table (KNIME internal format)
there is an optional visualization of the fire reports using "OSM Map View" (color represents the confidence of a report)

KNIME Workflow: 07 - Simulate Systems (by connecting Fires+Temp)
from all fire reports, only the fires around Mississippi are taken (using Geo-coordinate filter) to speed-up further joining
now, for each station separately, we enrich its "huge hourly table" with the following:
number of fire reports per hour (FireCount) by joining the fires with stations using geo-location (CFG_FIRE_RADIUS=50km)
predictions of fire potential using a MLP model
we use single model that predicts 7 hours to future (by shifting this new time series, we get predictions for +6, +5, +4, +3, +2, +1)
this could have been done better:
either by always doing 7 predictions with a single model by using shifted inputs
or by using 7 independently trained models tuned precisely for a specific hour, e.g. a model for +3
the decision for using MLP model has been done in a different KNIME workflow
the model is trained on "MERIDIAN NAS" station and simulates predictions for all other stations
the simulated predictions are stored as columns "FP+1", ..., "FP+7"
output of the "Joiner / Fires+Temp data" node is the input for our simulation of Simple, Reactive and Predictive systems
then we run our simulation using Java code from SEAMS14-proact/simulated-system.jar with different parameters for different type of system:
Reactive
Simple(every 1h) .. Simple(every 12h)
Predictive(1) .. Predictive(7)
Predictive(1)U .. Predictive(7)U
Predictive(1)D .. Predictive(7)D
Predictive(1)Di .. Predictive(7)Di
each simulation adds "Transmissions", "Late Fires" and "Reconfigurations" columns
then we also add "Power" column using a formula Power = a*Transmissions + b*Reconfigurations
then we compute relative values of the metrics (relative % to Reactive system)
finally, we render the box-plots using Python Plot nodes

KNIME Workflow: 08 - Evaluation/Eval FirePotential Classification
this workflow is used for choosing the right classifier



Author(s):
Viliam Simko
Ivan Paez





Date: Oct. 22, 2013
Last update: Mar 10 2015