library(ggplot2)
library(dplyr)
library(hrbrthemes)
library(viridis)
library(RColorBrewer)

# Plotting histograms for SA pigmentation data from 4 populations using ggplot2

# Load data
master <- read.csv("Pheno/data_private/MasterPheno_All.csv")
head(master)
class(master)

ced <- read.csv("Pheno/data_private/Master_Pheno_CDB.csv")
karoo <- read.csv("Pheno/data_private/Master_Pheno_Karoo.csv")



# Remove all NA values
master <- master[-which(is.na(as.numeric(master$M_Arm))), ]

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

# Plot Histogram
histogram <- ggplot(master, aes(x = M_Arm)) +
  geom_histogram(binwidth = 0.75, fill = "gray", color = "gray", alpha = 0.9) +
  geom_vline(aes(xintercept = cdb_avg), col = "red", size = 0.75) +
  geom_vline(aes(xintercept = karoo_avg), col = "blue", size = 0.75) +
  geom_vline(aes(xintercept = khomani_avg), col = "green", size = 0.75) +
  geom_vline(aes(xintercept = nama_avg), col = "purple", size = 0.75) +
  labs(title = "Melanin Distribution in KhoeSan groups", y = "Frequency", x = "Melanin",
       caption = "Source: Henn Lab pigmentation data") +
  theme_set(theme_classic() + theme(legend.position = "top")
  )

ggplot(ced, aes(x = Final_M)) +
  geom_histogram(binwidth = 0.75, fill = "gray", color = "gray", alpha = 0.9) +
  geom_vline(aes(xintercept = cdb_avg), col = "red", size = 0.75) +
  theme_set(theme_classic() + theme(legend.position = "top")
  )

ggplot(karoo, aes(x = Final_M)) +
  geom_histogram(binwidth = 0.75, fill = "gray", color = "gray", alpha = 0.9) +
  geom_vline(aes(xintercept = karoo_avg), col = "red", size = 0.75) +
  theme_set(theme_classic() + theme(legend.position = "top")
  )


# Plot Bar Plot
# rearrange by median
head(master)
master$Population <- with(master, reorder(Population, M_Arm, median))


boxplot1 <-
  ggplot(master, aes(x = Population, y = M_Arm)) +
  geom_boxplot(aes(show.legend = FALSE), fill = c("#9A872D", "#F7B0AA", "#FDDDA4", "#76A08A"), notch = TRUE,
               outlier.colour = "#D1362F", outlier.alpha = 0.5) +
  labs(title = "Melanin Distribution in KhoeSan Populations", y = "Melanin",
       caption = "Source: Henn Lab pigmentation data") +
  scale_color_brewer(palette = "Dark2") +
  theme(legend.position = "none")


boxplot2 <-
  ggplot(master, aes(x = Population, y = M_Arm)) +
  geom_boxplot(aes(show.legend = FALSE), fill = c("#9A872D", "#F7B0AA", "#FDDDA4", "#76A08A"), notch = TRUE,
               outlier.colour = "#D1362F", outlier.alpha = 0.5) +
  geom_point(alpha = 0.02) + geom_jitter(width = 0.18, color = "#541F12", shape = 1) +
  labs(title = "Melanin Distribution in KhoeSan Populations", y = "Melanin",
       caption = "Source: Henn Lab pigmentation data") +
  scale_color_brewer(palette = "Dark2") +
  theme(legend.position = "none")
?geom_jitter



# Save File
pdf(file = "Pheno/output/distribution_pigmentation_plot.pdf", width = 12, height = 9)
boxplot1
boxplot2
dev.off()
