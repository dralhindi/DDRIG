setwd("/Users/dana.alhindi/Dropbox/phenotpye_data/cederberg")

dat <- cederberg_data_final
head(dat)

pdf(file= "cederberg_graphs_w_outliers_final", height=8, width=7)
par(mfrow=c(2,2))
hist(data$avg_E_Inner_R, 
     xlab="Distribution of Erythema Averages",
     sub="(outliers included)",
     xlim= c(05,25),
     ylim = c(0,20),
     breaks = 18,
     las=2,
     main = "Right Arm Erythema - Cederberg", 
     ylab= "Frequency",
     col = "lightsteelblue2")


hist(data$avg_E_Inner_L, 
     xlab="Distribution of Erythema Averages",
     sub="(outliers included)",
     xlim= c(05,25),
     ylim = c(0,20),
     breaks = 18,
     las=2,
     main = "Left Arm Erythema - Cederberg", 
     ylab= "Frequency",
     col = "lightsteelblue2")

hist(data$avg_M_Inner_R, 
     xlab="Distribution of Melanosomes Averages",
     sub="(outliers included)",
     xlim= c(30,70),
     ylim = c(0,20),
     breaks = 20,
     las=2,
     main = "Right Arm Melanosomes - Cederberg", 
     ylab= "Frequency",
     col = "lightpink3")

hist(data$avg_M_Inner_L, 
     xlab="Distribution of Melanosomes Averages",
     sub="(outliers included)",
     xlim= c(30,70),
     ylim = c(0,20),
     breaks = 20,
     las=2,
     main = "Left Arm Melanosomes - Cederberg", 
     ylab= "Frequency",
     col = "lightpink3")
dev.off()


pdf(file= "cederberg_final_e_and_m_values", height=8, width=7)
par(mfrow=c(2,1))

#Visualizing the final E and M values per/participant 

hist(data$Final_E, 
     xlab="Distribution of Combined E-values",
     xlim= c(05,25),
     ylim = c(0,20),
     breaks = 18,
     las=2,
     main = "Erythema from Cederberg", 
     ylab= "Frequency",
     col = "lightsteelblue2")

hist(data$Final_M, 
     xlab="Distribution of Combined M-Values",
     xlim= c(30,70),
     ylim = c(0,20),
     breaks = 20,
     las=2,
     main = "Melanin from Cederberg", 
     ylab= "Frequency",
     col = "lightsalmon3")

dev.off()

