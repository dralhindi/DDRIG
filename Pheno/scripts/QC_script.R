## QC Pigmentation Measurements

library(NCmisc)

## Read in Data
data <- read.csv("Pheno/data_private/cdb_phenotypes_2017_DRA.csv")

## Convert to data frame

data <- as.data.frame(data)

## Drop NA Values


## Function to drop min & max of a list of numbers, and return average
drop_avg <- function(v) {
  new <- v[v != max(v) & v != min(v)] # remove min & max
  avg <- mean(new)
  return(avg)
}

## Create new columns for averages
data$avg.e.r <- NA
data$avg.e.l <- NA
data$avg.m.r <- NA
data$avg.m.l <- NA

## Ensure all values are integers
data[, c(5:24)] <- sapply(data[, c(5:24)], as.numeric)
colnames(data)

## Loop through rows of data frame "data"
## Drops min & max values, averages them, puts avg in another column in data frame
## Do this for each measurement separately: e_r, e_l, m_r, m_l

for (row in seq_len(nrow(data))) {
  e.r.arm <- data[row, c("e.r.arm_1", "e.r.arm_2", "e.r.arm_3", "e.r.arm_4", "e.r.arm_5")]
  data[row, ]$avg.e.r <- drop_avg(e.r.arm)
  e.l.arm <- data[row, c("e.l.arm_1", "e.l.arm_2", "e.l.arm_3", "e.l.arm_4", "e.l.arm_5")]
  data[row, ]$avg.e.l <- drop_avg(e.l.arm)
  m.r.arm <- data[row, c("m.r.arm_1", "m.r.arm_2", "m.r.arm_3", "m.r.arm_4", "m.r.arm_5")]
  data[row, ]$avg.m.r <- drop_avg(m.r.arm)
  m.l.arm <- data[row, c("m.l.arm_1", "m.l.arm_2", "m.l.arm_3", "m.l.arm_4", "m.l.arm_5")]
  data[row, ]$avg.m.l <- drop_avg(m.l.arm)
}

## Gets difference between M averages (m_r - m_l)
data$m_diff <- data$avg.m.r - data$avg.m.l

## Omit outliers > 2 sd from mean for the column m_diff (containing differences between m averages)
data <- data[- (which.outlier(data$m_diff, thr = 2, method = "sd", high = TRUE, low = TRUE)), ]

# Average left and right arms for each sample (row)
data$Final_E <- NA
data$Final_M <- NA

for (row in seq_len(nrow(data))) {
  avg_E <- rowMeans((data[row, c("avg.e.r", "avg.e.l")]))
  avg_M <- rowMeans((data[row, c("avg.m.r", "avg.m.l")]))
  data[row, ]$Final_E <- avg_E
  data[row, ]$Final_M <- avg_M
}


# Write data frame to csv file
write.csv(data, file = "Pheno/data_private/Master_Pheno_CDB.csv")
