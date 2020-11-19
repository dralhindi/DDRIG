library(ggplot2)
library(dplyr)

# Plotting histograms for SA pigmentation data from 4 populations using ggplot2

# Load data
cdb <- MasterPheno_CDB_DRA
karoo <- MasterPhenotpe_Karoo_DRA
khomani <- MasterPhenotype_KhmAll
nama <- MasterPhenotype_Nama
master <- as.data.frame(MasterPheno_All)

class(master)

# Convert desired column to numeric values
cdb$M_Arm <- as.numeric(cdb$M_Arm)
karoo$M_Arm <- as.numeric(karoo$M_Arm)
khomani$M_Arm <- as.numeric(khomani$M_Arm)
nama$M_Arm <- as.numeric(nama$M_Arm)
master$M_Arm <- as.numeric(master$M_Arm)

class(master$M_Arm)

# Find averages for each population
cdb_avg <- mean(cdb$M_Arm,na.rm=TRUE)
karoo_avg <- mean(karoo$M_Arm,na.rm=TRUE)
khomani_avg <- mean(khomani$M_Arm,na.rm=TRUE)
nama_avg <- mean(nama$M_Arm,na.rm=TRUE)
master_avg 
<- mean(master$M_Arm,na.rm=TRUE)


# Where do you want the legend to appear
legend = data.frame(matrix(ncol = 4, nrow = 4))
colnames(legend) = c("x_pos" , "y_pos" , "label")
legend$label = c("Cederberg", "Nama", "Karoo","Khomani")

# Fill data frame
legend[1, 1] <- 85.83
legend[2, 1] <- 85
legend[3, 1] <- 85
legend[4, 1] <- 85.58
legend[1, 2] <- 30
legend[2, 2] <- 29
legend[3, 2] <- 28
legend[4, 2] <- 27

head(legend)


# Plot
hp <- ggplot(master, aes(x=M_Arm)) + 
  geom_histogram(binwidth=0.75, fill="gray", color="gray", alpha=0.9) + 
  geom_vline(aes(xintercept = cdb_avg),col='red',size=0.75) +
  geom_vline(aes(xintercept = karoo_avg),col='blue',size=0.75) +
  geom_vline(aes(xintercept = khomani_avg),col='green',size=0.75) +
  geom_vline(aes(xintercept = nama_avg),col='purple',size=0.75) +
  labs(title="Melanin Distribution in KhoeSan groups", y="Frequency", x="Melanin", caption="Source: Henn Lab pigmentation data") +
  theme_set(theme_classic() + theme(legend.position = "top") 
  )

hp <- hp + geom_text(data = legend, aes(x = x_pos, y = y_pos, label = label))
hp

# Save File
pdf(file="/Users/dana.alhindi/DDRIG/Pheno/output/histogram_pigmentation.jpeg", width=12, height = 11) 
hp
dev.off()


