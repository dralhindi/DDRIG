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



# Plot Bar Plot
# rearrange by median
head(master)
master$Population <- with(master, reorder(Population, M_Arm, median))


barplot <- ggplot(master, aes(fill = Population, x = Population, y = M_Arm)) +
  geom_boxplot(aes(show.legend = FALSE, alpha = 0.8)) +
  labs(title = "Melanin Distribution in KhoeSan Populations", y = "Melanin",
       caption = "Source: Henn Lab pigmentation data") +
  scale_color_brewer(palette = "Dark2") +
  theme(legend.position = "none")




# Plot Violin Plot
violinplot <- ggplot(master, aes(fill = Population, x = Population, y = M_Arm)) +
  geom_violin(aes(show.legend = FALSE, alpha = 0.8)) +
  labs(title = "Melanin Distribution in KhoeSan Populations", y = "Melanin Content",
       caption = "Source: Henn Lab pigmentation data") +
  scale_color_brewer(palette = "Dark2") +
  theme(legend.position = "none")




# Save File
pdf(file = "Pheno/output/distribution_pigmentation_plot.pdf", width = 12, height = 9)
barplot
violinplot
dev.off()
