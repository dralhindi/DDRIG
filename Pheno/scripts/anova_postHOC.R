library(tidyverse)
library(DescTools) 

# Running ANOVA test on KhoeSan pigmentation averages

# set work directory
setwd("Pheno/data_private/")

# Load data
cdb <- read.csv(file = "MasterPheno_CDB_DRA.csv")
karoo <- read.csv(file = "MasterPhenotpe_Karoo_DRA.csv")
nama <- read.csv(file = "MasterPhenotype_Nama.csv")
kho <- read.csv(file = "MasterPhenotype_KhmAll.csv")
data <- read.csv(file = "pigmentation_data.csv")
data_omitKaroo <- read.csv(file = "pigmentation_data_minusKaroo.csv")


# Removing empty rows
cdb <- cdb[-which(is.na(as.numeric(cdb$M_Arm))), ]
nama <- nama[-which(is.na(as.numeric(nama$M_Arm))), ]
kho <- kho[-which(is.na(as.numeric(kho$M_Arm))), ]
data <- data[-which(is.na(as.numeric(data$M_Arm))), ]
data_omitKaroo <- data_omitKaroo[-which(is.na(as.numeric(data_omitKaroo)))]

# Making sure columns are numeric
cdb$M_Arm <- as.numeric(cdb$M_Arm)
karoo$M_Arm <- as.numeric(karoo$M_Arm)
nama$M_Arm <- as.numeric(nama$M_Arm)
kho$M_Arm <- as.numeric(kho$M_Arm)
data$M_Arm <- as.numeric(data$M_Arm)
data_omitKaroo$M_Arm <- as.numeric(data_omitKaroo$M_Arm)

# Make sure Populations are factors
data$Population <- as.factor(data$Population)
data_omitKaroo$Population <- as.factor(data_omitKaroo$Population)

# Check Variance are similar 
var(cdb$M_Arm, na.rm = TRUE)
var(karoo$M_Arm, na.rm = TRUE)
var(nama$M_Arm, na.rm = TRUE)
var(kho$M_Arm, na.rm = TRUE)


# ANOVA and Post HOC Test
results <- aov(M_Arm ~ Population, data = data)
summary(results)
ScheffeTest(results)

results_omitKaroo <- aov(M_Arm ~ Population, data = data_omitKaroo)
summary(results_omitKaroo)
ScheffeTest(results_omitKaroo)


# Permutation Testing to adjust for small Karoo sample size
perm_kho <- data.frame(sample(kho$M_Arm, size = 89))
perm_kho$Population <- c(rep("Khomani", 89))
colnames(perm_kho) <- c("M_Arm","Population")
head(perm_kho)

perm_cdb <- data.frame(sample(cdb$M_Arm, size = 89))
perm_cdb$Population <- c(rep("Cederberg", 89))
colnames(perm_cdb) <- c("M_Arm","Population")
head(perm_cdb)

perm_nama <- data.frame(sample(nama$M_Arm, size = 89))
perm_nama$Population <- c(rep("Nama", 89))
colnames(perm_nama) <- c("M_Arm","Population")
head(perm_nama)

perm_karoo <- data.frame(sample(karoo$M_Arm, size = 90))
perm_karoo$Population <- c(rep("Karoo", 90))
colnames(perm_karoo) <- c("M_Arm","Population")
head(perm_karoo)

merged <- rbind(perm_nama, perm_kho, perm_cdb, perm_karoo)
head(merged)
tail(merged)

results_merged <- aov(M_Arm ~ Population, data = merged)
summary(results_merged)
ScheffeTest(results_merged)
