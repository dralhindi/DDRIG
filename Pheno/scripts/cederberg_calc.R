## Cederberg Pigmentation Measurements 

install.packages("NCmisc")
library(NCmisc)

## set working directory 


## Read in Data 
data <- cdb_phenotypes_2017_DRA

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

# Write data frame to csv file 
  write.csv(data, file = "cdb_data_final_nov14.csv")

