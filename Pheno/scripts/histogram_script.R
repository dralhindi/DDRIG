library(ggplot2)

setwd("/Users/dana.alhindi/DDRIG/Pheno/data_private")

# Plotting histograms for SA pigmentation data from 4 populations using ggplot2

# Load data
master <- read_excel("MasterPheno_All.xlsx")
head(master)
class(master)

# Convert desired column to numeric values
master$M_Arm <- as.numeric(master$M_Arm)
class(master$M_Arm)

# Find averages for each population
master_avg <- mean(master$M_Arm, na.rm = TRUE)
averages <- aggregate(M_Arm ~ Population, master, mean)

cdb_avg <- averages[1, 2]
karoo_avg <- averages[2, 2]
khomani_avg <- averages[3, 2]
nama_avg <- averages[4, 2]

# Plot
ggplot(master, aes(x = M_Arm)) +
  geom_histogram(binwidth = 0.75, fill = "gray", color = "gray", alpha = 0.9) +
  geom_vline(aes(xintercept = cdb_avg), col = "red", size = 0.75) +
  geom_vline(aes(xintercept = karoo_avg), col = "blue", size = 0.75) +
  geom_vline(aes(xintercept = khomani_avg), col = "green", size = 0.75) +
  geom_vline(aes(xintercept = nama_avg), col = "purple", size = 0.75) +
  labs(title = "Melanin Distribution in KhoeSan groups", y = "Frequency", x = "Melanin",
       caption = "Source: Henn Lab pigmentation data") +
  theme_set(theme_classic() + theme(legend.position = "top")
  )

# Save File
pdf(file = "/Users/dana.alhindi/DDRIG/Pheno/output/histogram_pigmentation.pdf", width = 12, height = 9)
hp
dev.off()
