library(data.table)
library(dplyr)
library(tidyr)
library(ggplot2)
library(rlist)
library(lubridate)

#Load data
dt <- fread('C:/Users/ksorauf/OneDrive - Regis University/Gocode/historical-census-data all counties.csv')

# Remove data with 0 population
dt <- dt[dt$`Total Population` != 0, ]

# Only keep citys with 5 or more population values
dt<-dt[,count:=.N,by=`AREA(S)`][(count>=5)]

# Find the unique areas in the data
u <- unique(dt$`AREA(S)`)

# Create an empty list
mods <- list()

# Loop a 3rd order polynomial fit for each area and save results in the empty list
for (i in 1:length(u)){
  mods[[i]] <- lm(`Total Population` ~ poly(YEAR, 2), data = dt[dt$`AREA(S)` == u[i]])
}



# Create an empty prediction list
preds = NULL

# Future years to predict population
fy <- data.frame('YEAR' = c(2020, 2030, 2040, 2050))

# Add the unique areas to the prediction list and empty prediction years
preds<- data.table(u)
preds$Y2020 = NA
preds$Y2030 = NA
preds$Y2040 = NA
preds$Y2050 = NA

# Loop predictions through and save results
for (i in 1:length(u)){
  preds$Y2020[i] <- predict(mods[[i]], fy)[1]
  preds$Y2030[i] <- predict(mods[[i]], fy)[2]
  preds$Y2040[i] <- predict(mods[[i]], fy)[3]
  preds$Y2050[i] <- predict(mods[[i]], fy)[4]
}

