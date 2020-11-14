## Cederberg Pigmentation Measurements 

install.packages("NCmisc")
library(NCmisc)

## set working directory 

setwd("~/Desktop/cederberg_phenotype_data/")

## Read in Data 

data = read.csv("cederberg_phenotypes_2017-1.csv")

## Convert to data frame 

data = as.data.frame(data)
nrow(data)

## Function to drop min & max of a list of numbers, and return average 

drop_avg = function(v){
  new = v[v != max(v) & v!= min(v)] # remove min & max
  avg = mean(new)
  return(avg)
}

## Create new columns for averages 

data$avg_E_Inner_R = NA 
data$avg_E_Inner_L = NA
data$avg_M_Inner_R = NA
data$avg_M_Inner_L = NA 

## Ensure all values are integers   

cols=c("E_Inner_R_1","E_Inner_R_2","E_Inner_R_3","E_Inner_R_4","E_Inner_R_5",
       "E_Inner_L_1","E_Inner_L_2","E_Inner_L_3","E_Inner_L_4","E_Inner_L_5",
       "M_Inner_R_1","M_Inner_R_2","M_Inner_R_3","M_Inner_R_4","M_Inner_R_5",
       "M_Inner_L_1","M_Inner_L_2","M_Inner_L_3","M_Inner_L_4","M_Inner_L_5")

data[, cols] <- sapply(data[,cols ], as.numeric)

## Loop through rows of data frame "data" 
## Drops min & max values, averages them, puts avg in another column in data frame 

for (row in 1:nrow(data)){
  E_Inner_R = data[row, c("E_Inner_R_1","E_Inner_R_2","E_Inner_R_3","E_Inner_R_4","E_Inner_R_5")] 
  data[row,]$avg_E_Inner_R = drop_avg(E_Inner_R)

  E_Inner_L = data[row, c("E_Inner_L_1","E_Inner_L_2","E_Inner_L_3","E_Inner_L_4","E_Inner_L_5")]
  data[row,]$avg_E_Inner_L = drop_avg(E_Inner_L)
  
  M_Inner_R = data[row, c("M_Inner_R_1","M_Inner_R_2","M_Inner_R_3","M_Inner_R_4","M_Inner_R_5")]
  data[row,]$avg_M_Inner_R = drop_avg(M_Inner_R)
  
  M_Inner_L = data[row, c("M_Inner_L_1","M_Inner_L_2","M_Inner_L_3","M_Inner_L_4","M_Inner_L_5")]
  data[row,]$avg_M_Inner_L = drop_avg(M_Inner_L)
}


## Omit outliers > 2 sd from mean for all four measurements across dataset 

data = data[-(which.outlier(data$avg_E_Inner_R, thr = 2, method = "sd", high = TRUE, low = TRUE)),]
data = data[-(which.outlier(data$avg_E_Inner_L, thr = 2, method = "sd", high = TRUE, low = TRUE)),]
data = data[-(which.outlier(data$avg_M_Inner_R, thr = 2, method = "sd", high = TRUE, low = TRUE)),]
data = data[-(which.outlier(data$avg_M_Inner_L, thr = 2, method = "sd", high = TRUE, low = TRUE)),]

# Average left and right arms for each sample (row)

data$Final_E = NA
data$Final_M = NA 

for (row in 1:nrow(data)){
  avg_E = rowMeans((data[row, c("avg_E_Inner_R", "avg_E_Inner_L")]))
  avg_M = rowMeans((data[row, c("avg_M_Inner_R", "avg_M_Inner_L")]))
  data[row,]$Final_E = avg_E
  data[row,]$Final_M = avg_M 
}

# Write data frame to csv file 
  write.csv(data, file = "~/Desktop/cederberg_phenotype_data/cederberg_data_final.csv")
