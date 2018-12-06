# regiswaterlyticsco

The purpose of this project is to explore the HB 1051 data with a dual focus: on water leakage as well as water production by population size. The data can be obtained from the [CWCB Water Efficiency Data Portal](http://cowaterefficiency.com/unauthenticated_home) with permission. Once in the portal, all report years (2013-2017) were selected as well as all water providers.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine.

### Prerequisites

[ArcGIS](https://www.arcgis.com/index.html) - for COWaterStations_v2.mxd to generate map visualzations

[R](https://www.r-project.org/) and [RStudio](https://www.rstudio.com/products/rstudio/download/). 

[Download and Install R and RStudio here](https://courses.edx.org/courses/UTAustinX/UT.7.01x/3T2014/56c5437b88fa43cf828bff5371c6a924/)

Once R and RStudio are installed, the following R packages are required:
* sqldf
* data.table
* dplyr
* tidyr
* ggplot2
* rlist
* lubridate  

Install and load these packages using the following commands in RStudio:
```
install.packages("<package_name>")
library(<package_name>)
```

### Installing/Downloading

* Download entire repository. 
* Open .R and .rmd files with RStudio
* *Before executing any .R or .rmd files, be sure to update file paths for read and write operations to reflect your machine's file structure*
* For .R files:
    + Right-click Select All (or type Ctrl-A on Windows, or Command-A on Mac)
    + Click "Run current line or selection" in the script window menu, (or type Ctrl-Alt-R on Windows, or Command-Option-R on Mac)
    + Output will display in RStudio Console
 * For .rmd files:
    + Click Knit (or type Ctrl-Shift-K on Windows or Command-Shift-K on Mac)

## File Descriptions

**COWaterStations_v2.mxd** - This file was used with ArcGIS to generate a map of the water stations that supply water to Colorado. This file makes use of the DWR_Surface_Water_Stations2.csv data

**COWaterStations_v2.png** - This map shows the locations of all of the water stations that supply water through Colorado

**leak2.rmd** & **leak2.pdf** -  The purpose of this file is to explore the HB1051 data with emphasis on water leakage. Files were merged to create water leakage reporting by water provider and year. Data is displayed graphically and recommendations are provided for cleaning up potential reporting errors. The .rmd contains the raw markdown file, the pdf is just a printed version of this. This report uses overview.csv & foundational_09_balance_data.csv from the HB 1051 data

**Leaks, Pipes, Detection.R** - The purpose of this file is to explore correlations between percent water loss and given variables. Weak correlations are found between percent water loss and the percent of systems inspected for leaks annually and the age at which the provider replaces small meters, and no correlation is found between the other variables (percent of pipes replaced annually, number of years between large meter testing, whether the provider had implemented a meter testing program, and leak detection methods). This report uses TotalLossYear.csv, PercentLossValuesNoOutliers.csv, foundational_06a_loss_and_leak_det.csv, and LeakDetTypes.csv

**meterGreaterDistributedChart.PNG**  - This chart shows which cities during which years have metered water greater than distributed water.

**ngrams.rmd** & **ngrams.pdf** - The purpose of this file is to conduct text analysis on the leak_detection_field_technology column in the foundational_06a_loss_and_leak_detection file. Distributions of time between testing and age to replace small meters in years are shown. Recommendations for reporting are suggested to leverage this information. The .rmd file contains the raw markdown file, the pdf is just a printed version of this. This report uses foundation_06a_loss_and_leak_detection_technology.csv.

**Statistical Analysis Water Loss.R** - The purpose of this file is to analyze how AWWA policy adherence relates to water loss. Percent water loss was calculated for each municipality.  Once the data was cleaned for outliers a Wilcoxon Rank Sum test was performed on percent water loss versus municipalities that were AWWA policy adherence on their potable treated water.  We found that municipalities that were AWWA policy adherent had significantly more percent water loss than municipalities that were not AWWA policy adherence. This report uses  foundational_06a_loss_and_leak_det.csv, foundational_07_audit_info.csv, foundational_08_audit_data.csv, foundational_09_balance_data.csv, and normalizing_03_population.csv

**waterByCity.rmd** & **waterByCity.pdf** - The purpose of this file is to explore the HB 1051 data with an emphasis on population and water production projections. Files were merged and separated by water type (i.e. potable, non-potable raw, and non-potable reuse). A linear model was fit to potable water production by population served. Population data by county/municipality was used to create population projections by county and municipality until the year 2050. These projections were used to anticipate necessary potable water production per county and municipality until the year 2050. Output files include: water_population_predictions_counties.csv and water_population_predictions_municipalities.csv. This report uses overview.csv, normalizing_03_population.csv, water_use_02_production.csv, historical-census-data-municipalities.csv & historical-census-data-counties.csv

**water_population_predictions_municipalities.csv** & **water_population_predictions_counties.csv** - These files contain the outputs of the waterByCity analyses, and include projected population numbers as well as projected potable water production needs (in millions of gallons) by municipality and county, respectively. *Note*: not all Colorado municipalities and counties are included in these files, only the ones that we had enough data to project population growth.

## Built With

* [RStudio](https://www.rstudio.com/) - The IDE used to analyze all data and generate R Markdown files
* [ArcGIS](https://www.arcgis.com/index.html) - Used to generate map visualizations

## Authors

* **Cynthia Mann** - *Map Visualizations* - [jambel77](https://github.com/jambel77)
* **David Sciacca** - *Water Production Projection Model; README.md* - [dsciacca](https://github.com/dsciacca)
* **Kellen Sorauf** - *Population Projection Model; AWWA Adherance Analysis* - [Mrsnellek](https://github.com/Mrsnellek)
* **Lolita Mannik** - *Leak Analysis; Powerpoint Presentation* - [ChihuaWars](https://github.com/ChihuaWars)
* **Yekaterina Bardash** - *Leak Data Preparation and Analysis; N-grams Analysis* - [ybardashRegis](https://github.com/ybardashRegis)

See also the list of [contributors](https://github.com/ybardashRegis/regiswaterlyticsco/graphs/contributors) who participated in this project.

## Acknowledgments

* The Colorado Governor’s Office of Information Technology for putting on the *Smart Data Analytics Challenge - Addressing Colorado’s Critical Issues*

