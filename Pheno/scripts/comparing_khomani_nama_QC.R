library(NCmisc)
library(dplyr)
library(ggplot2)

setwd("/Users/dana.alhindi/DDRIG/Pheno/data_private/")

# This script was developed to compare cleaned data against raw data. Cleaned data seemed to have individuals that would be considered outliers. So this script looks to compare histogram plots against one another and reruning the QC process on the raw data. 

# Upload previously cleaned Data
nama_clean <- read.csv(file = "MasterPhenotype_Nama.csv")
head(nama_clean)
class(nama_clean$M_Arm)

kho_clean <- read.csv(file = "MasterPhenotype_KhmAll.csv")
head(kho_clean)
class(kho_clean$M_Arm)


# Change class to numeric
nama_clean$M_Arm <- as.numeric(nama_clean$M_Arm)
class(nama_clean$M_Arm)
kho_clean$M_Arm <- as.numeric(kho_clean$M_Arm)
class(kho_clean$M_Arm)

# Get min, max, and mean of each population
min(nama_clean$M_Arm,na.rm=T)
max(nama_clean$M_Arm,na.rm=T)
mean(nama_clean$M_Arm,na.rm=T)

min(kho_clean$M_Arm,na.rm=T)
max(kho_clean$M_Arm,na.rm=T)
mean(kho_clean$M_Arm,na.rm=T)


# Plot to see if data needs cleaning
prev_cleaned_nama <- ggplot(nama_clean, aes(x=M_Arm)) + 
  geom_histogram(binwidth=1.5, fill="gray", color="gray", alpha=0.9) + 
  labs(title="Melanin Distribution in the previously cleaned Nama data", y="Frequency", x="Melanin", 
       caption="Source: Henn Lab pigmentation data") + xlim(c(30,90)) + 
  theme_set(theme_classic() + theme(legend.position = "top") 
  )

prev_cleaned_khomani <- ggplot(kho_clean, aes(x=M_Arm)) + 
  geom_histogram(binwidth=1.5, fill="gray", color="gray", alpha=0.9) + 
  labs(title="Melanin Distribution in the previously cleaned Khomani", y="Frequency", x="Melanin", 
       caption="Source: Henn Lab pigmentation data") + xlim(c(30,90)) + 
  theme_set(theme_classic() + theme(legend.position = "top") 
  )



# Noticed some outliers on the end. Going to upload raw data and reclean to see if some individuals need to be removed. 
#Upload Raw data to compare
nama_raw <- read.csv(file = "Nama_phenotypes_2015-1.csv")
head(nama_raw)
kho_raw <- read.csv(file = "Khm_PhenotypeCollection_2015.csv")
head(kho_raw)

## Convert to data frame for the Nama

data = as.data.frame(nama_raw)
head(data)
nrow(data)

## Function to drop min & max of a list of numbers, and return average 

drop_avg = function(v){
  new = v[v != max(v) & v!= min(v)] # remove min & max
  avg = mean(new)
  return(avg)
}

## Create new columns for averages 

data$avg.e.r = NA 
data$avg.e.l = NA
data$avg.m.r = NA
data$avg.m.l = NA 

## Ensure all values are integers   

cols=c("e.r.arm_1","e.r.arm_2","e.r.arm_3","e.r.arm_4","e.r.arm_5",
       "e.l.arm_1","e.l.arm_2","e.l.arm_3","e.l.arm_4","e.l.arm_5",
       "m.r.arm_1","m.r.arm_2","m.r.arm_3","m.r.arm_4","m.r.arm_5",
       "m.l.arm_1","m.l.arm_2","m.l.arm_3","m.l.arm_4","m.l.arm_5")

data[, cols] <- sapply(data[,cols ], as.numeric)

## Loop through rows of data frame "data" 
## Drops min & max values, averages them, puts avg in another column in data frame 

for (row in 1:nrow(data)){
  e.r.arm = data[row, c("e.r.arm_1","e.r.arm_2","e.r.arm_3","e.r.arm_4","e.r.arm_5")] 
  data[row,]$avg.e.r = drop_avg(e.r.arm)
  
  e.l.arm = data[row, c("e.l.arm_1","e.l.arm_2","e.l.arm_3","e.l.arm_4","e.l.arm_5")]
  data[row,]$avg.e.l = drop_avg(e.l.arm)

  m.r.arm = data[row, c("m.r.arm_1","m.r.arm_2","m.r.arm_3","m.r.arm_4","m.r.arm_5")]
  data[row,]$avg.m.r = drop_avg(m.r.arm)
  
  m.l.arm = data[row, c("m.l.arm_1","m.l.arm_2","m.l.arm_3","m.l.arm_4","m.l.arm_5")]
  data[row,]$avg.m.l = drop_avg(m.l.arm)
}


## Omit outliers > 2 sd from mean for all four measurements across dataset 
# TODO(Dana): Go back and double check what stage to remove outlines. By arm or by E/M average? 

data = data[-(which.outlier(data$avg.e.r, thr = 2, method = "sd", high = TRUE, low = TRUE)),]
data = data[-(which.outlier(data$avg.e.l, thr = 2, method = "sd", high = TRUE, low = TRUE)),]
data = data[-(which.outlier(data$avg.m.r, thr = 2, method = "sd", high = TRUE, low = TRUE)),]
data = data[-(which.outlier(data$avg.m.l, thr = 2, method = "sd", high = TRUE, low = TRUE)),]

# Average left and right arms for each sample (row)

data$Final_E = NA
data$Final_M = NA 

for (row in 1:nrow(data)){
  avg_E = rowMeans((data[row, c("avg.e.r", "avg.e.l")]))
  avg_M = rowMeans((data[row, c("avg.m.r", "avg.m.l")]))
  data[row,]$Final_E = avg_E
  data[row,]$Final_M = avg_M 
}
nrow(data)


## Convert to data frame for Khomani

data1 = as.data.frame(kho_raw)
head(data1)
nrow(data1)

## Function to drop min & max of a list of numbers, and return average 

drop_avg = function(v){
  new = v[v != max(v) & v!= min(v)] # remove min & max
  avg = mean(new)
  return(avg)
}

## Create new columns for averages 

data1$avg.e.r = NA 
data1$avg.e.l = NA
data1$avg.m.r = NA
data1$avg.m.l = NA 

## Ensure all values are integers   

cols=c("e.r.arm_1","e.r.arm_2","e.r.arm_3","e.r.arm_4","e.r.arm_5",
       "e.l.arm_1","e.l.arm_2","e.l.arm_3","e.l.arm_4","e.l.arm_5",
       "m.r.arm_1","m.r.arm_2","m.r.arm_3","m.r.arm_4","m.r.arm_5",
       "m.l.arm_1","m.l.arm_2","m.l.arm_3","m.l.arm_4","m.l.arm_5")

data1[, cols] <- sapply(data1[,cols ], as.numeric)

## Loop through rows of data1 frame "data1" 
## Drops min & max values, averages them, puts avg in another column in data1 frame 

for (row in 1:nrow(data1)){
  e.r.arm = data1[row, c("e.r.arm_1","e.r.arm_2","e.r.arm_3","e.r.arm_4","e.r.arm_5")] 
  data1[row,]$avg.e.r = drop_avg(e.r.arm)
  
  e.l.arm = data1[row, c("e.l.arm_1","e.l.arm_2","e.l.arm_3","e.l.arm_4","e.l.arm_5")]
  data1[row,]$avg.e.l = drop_avg(e.l.arm)
  
  m.r.arm = data1[row, c("m.r.arm_1","m.r.arm_2","m.r.arm_3","m.r.arm_4","m.r.arm_5")]
  data1[row,]$avg.m.r = drop_avg(m.r.arm)
  
  m.l.arm = data1[row, c("m.l.arm_1","m.l.arm_2","m.l.arm_3","m.l.arm_4","m.l.arm_5")]
  data1[row,]$avg.m.l = drop_avg(m.l.arm)
}


## Omit outliers > 2 sd from mean for all four measurements across dataset 
# TODO(Dana): Go back and double check what stage to remove outlines. By arm or by E/M average? 

data1 = data1[-(which.outlier(data1$avg.e.r, thr = 2, method = "sd", high = TRUE, low = TRUE)),]
data1 = data1[-(which.outlier(data1$avg.e.l, thr = 2, method = "sd", high = TRUE, low = TRUE)),]
data1 = data1[-(which.outlier(data1$avg.m.r, thr = 2, method = "sd", high = TRUE, low = TRUE)),]
data1 = data1[-(which.outlier(data1$avg.m.l, thr = 2, method = "sd", high = TRUE, low = TRUE)),]

## Average left and right arms for each sample (row)

data1$Final_E = NA
data1$Final_M = NA 

for (row in 1:nrow(data1)){
  avg_E = rowMeans((data1[row, c("avg.e.r", "avg.e.l")]))
  avg_M = rowMeans((data1[row, c("avg.m.r", "avg.m.l")]))
  data1[row,]$Final_E = avg_E
  data1[row,]$Final_M = avg_M 
}


## Rename new data
nama_recleaned <- data
kho_recleaned <- data1


## Plot to see if data needs cleaning
raw_r_arm_nama <- ggplot(nama_recleaned, aes(x=avg.m.r)) + 
  geom_histogram(binwidth=1.5, fill="gray", color="gray", alpha=0.9) + 
  labs(title="R.Arm Melanin Distribution in the Raw cleaned Nama data", y="Frequency", x="Melanin", 
       caption="Source: Henn Lab pigmentation data") + xlim(c(30,90)) + 
  theme_set(theme_classic() + theme(legend.position = "top") 
  )

raw_l_arm_nama <- recleaned_nama <- ggplot(nama_recleaned, aes(x=avg.m.l)) + 
  geom_histogram(binwidth=1.5, fill="gray", color="gray", alpha=0.9) + 
  labs(title="L.Arm Melanin Distribution in the Raw cleaned Nama data", y="Frequency", x="Melanin", 
       caption="Source: Henn Lab pigmentation data") + xlim(c(30,90)) + 
  theme_set(theme_classic() + theme(legend.position = "top") 
  )

raw_r_arm_khomani <- ggplot(kho_recleaned, aes(x=avg.m.r)) + 
  geom_histogram(binwidth=1.5, fill="gray", color="gray", alpha=0.9) + 
  labs(title="R.Arm Averages Melanin Distribution in the Raw cleaned Khomani data", y="Frequency", x="Melanin", 
       caption="Source: Henn Lab pigmentation data") + xlim(c(30,90)) + 
  theme_set(theme_classic() + theme(legend.position = "top") 
  )

raw_l_arm_khomani <- recleaned_khomani <- ggplot(nama_recleaned, aes(x=avg.m.l)) + 
  geom_histogram(binwidth=1.5, fill="gray", color="gray", alpha=0.9) + 
  labs(title="L.Arm Melanin Distribution in the Raw cleaned Khomani data", y="Frequency", x="Melanin", 
       caption="Source: Henn Lab pigmentation data") + xlim(c(30,90)) + 
  theme_set(theme_classic() + theme(legend.position = "top") 
  )

recleaned_nama <- ggplot(nama_recleaned, aes(x=Final_M)) + 
  geom_histogram(binwidth=1.5, fill="gray", color="gray", alpha=0.9) + 
  labs(title="Melanin Distribution in the newly cleaned Nama data", y="Frequency", x="Melanin", 
       caption="Source: Henn Lab pigmentation data") + xlim(c(30,90)) + 
  theme_set(theme_classic() + theme(legend.position = "top") 
  )

recleaned_khomani <- ggplot(kho_recleaned, aes(x=Final_M)) + 
  geom_histogram(binwidth=1.5, fill="gray", color="gray", alpha=0.9) + 
  labs(title="Melanin Distribution in the newly cleaned Khomani", y="Frequency", x="Melanin", 
       caption="Source: Henn Lab pigmentation data") + xlim(c(30,90)) + 
  theme_set(theme_classic() + theme(legend.position = "top") 
  )

## Comparing n removed
nrow(nama_raw)
nrow(nama_recleaned)
nrow(kho_raw)
nrow(kho_recleaned)

setwd("/Users/dana.alhindi/DDRIG/Pheno/output//")

pdf(file="khomani_nama_comparison.pdf", onefile = TRUE, paper = "letter", width = 7, height = 8)
par(mfrow=c(2,2))
prev_cleaned_khomani
prev_cleaned_nama
recleaned_khomani
recleaned_nama

dev.off() 

