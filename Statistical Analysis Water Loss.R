library(data.table)
library(dplyr)
library(tidyr)
library(ggplot2)
library(rlist)
library(lubridate)

#Select Which water type you want to analyse: 'Potable Treated', 'Non-potable Raw', 'Non-potable Re-use'
watertype <- 'Potable Treated'

#This is the foundational_09_balance_data.csv converted to thousands of gallonds
dt <- fread('C:/Users/ksorauf/OneDrive - Regis University/Gocode/Code and Data/waterloss.csv')

#Select the columns I want to use and rename them
loss <- dt[, .(dt$ce_annual_ndx, dt$water_type_index, dt$water_type, dt$dwater, dt$mwater, dt$lwater)]
colnames(loss) <- c('ce_annual_ndx', 'water_type_index', 'water_type', 'dwater', 'mwater', 'lwater')

#Only select the Desired water.  
t <- loss[loss$water_type == watertype]

# Import foundational_06a data
df <- fread('C:/Users/ksorauf/OneDrive - Regis University/Gocode/Code and Data/foundational_06a_loss_and_leak_det.csv')

#Join df with t by "ce_annual_ndx"
total <- right_join(df, t, by = c("ce_annual_ndx"))

# Import normalizing_03_population data
p <- fread('C:/Users/ksorauf/OneDrive - Regis University/Gocode/Code and Data/normalizing_03_population.csv')

# Join total with t by "ce_annual_ndx"
total <- right_join(total, p, by = c("ce_annual_ndx"))

#This data set is the foundational_08_audit_data.csv converted to thousands of gallons
bt <- fread('C:/Users/ksorauf/OneDrive - Regis University/Gocode/billloss.csv')

#Selecting on the 'Potable Treated water only'
bt <- bt[bt$water_type == watertype]

#Join by ce_annual_ndx
total <- right_join(total, bt, by = c("ce_annual_ndx"))

# Import data
ai <- fread('C:/Users/ksorauf/OneDrive - Regis University/Gocode/Code and Data/foundational_07_audit_info.csv')

#Selecting on the 'Potable Treated water only'
ai <- ai[ai$water_type == watertype]

#Join by ce_annual_ndx
total <- right_join(total, ai, by = c("ce_annual_ndx"))

# Percapita usage of water based on thousands of gallons
total$b <- total$calctotal/total$dwater #Total$b = foundational_08_audit_data.csv data converted to thousands of gallons divided by population served

#Box Plots
boxplot(total$lwater)
boxplot(total$b)
boxplot(total$calctotal)

# Percapita usage vs awwa policy adherence
boxplot(total$b[total$awwa_policy_adherence == 'YES'])
boxplot(total$b[total$awwa_policy_adherence == 'NO'])


# Remove outliers and replot
total <- total[total$b < 0.9, ]
boxplot(total$b[total$awwa_policy_adherence == 'YES'])
boxplot(total$b[total$awwa_policy_adherence == 'NO'])

# Remove "N/A"
total <- total[!grepl("N/A", total$awwa_policy_adherence),]

# Convert to factor
total$awwa_policy_adherence <- as.factor(total$awwa_policy_adherence)

# Check for normality
shapiro.test(total$b)
# Data is not normally distributed because P < 0.05

# Wicox.test to see if significant difference between data.
wilcox.test(total$b ~ total$awwa_policy_adherence)
boxplot(total$b ~ total$awwa_policy_adherence, xlab = 'AWWA Adherence', ylab = 'Percent Water Loss', main = 'Potable Treated Water')
# There is a significant difference


# Percent water loss was calculated for each municipality.  Once the data was cleaned for outliers a Wilcoxon Rank Sum test was performed on percent water loss 
# versus municipalities that were AWWA policy adherence on their potable treated water.  We found that municipalities that were AWWA policy adherence had 
# significantly more percent water loss than municipalities that were not AWWA policy adherence.


