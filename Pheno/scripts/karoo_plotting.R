#Visualizing the data with outlier removal
pdf(file= "graphs_w_outilers", height=8, width=7)
par(mfrow=c(2,2))
hist(dataFrames$E_Inner_R_Arm$AvgMeasurement, 
     xlab="Distribution of Eumelanin Averages",
     sub="(outliers included)",
     xlim= c(10,25),
     ylim = c(0,25),
     breaks = 11,
     las=2,
     main = "Right Arm Eumelanin  ", 
     ylab= "Frequency",
     col = "skyblue2")

hist(dataFrames$E_Inner_L_Arm$AvgMeasurement, 
     xlab="Distribution of Eumelanin Averages",
     sub="(outliers included)",
     xlim= c(10,25),
     ylim = c(0,25),
     las=2,
     main = "Left Arm Eumelanin  ", 
     ylab= "Frequency",
     col = "skyblue2")

hist(dataFrames$M_Inner_R_Arm$AvgMeasurement, 
     xlab="Distribution of Melanosomes Averages",
     sub="(outliers included)",
     xlim= c(20,100),
     ylim = c(0,35),
     breaks = 10,
     las=2,
     main = "Right Arm Melanosomes", 
     ylab= "Frequency",
     col = "azure2")

hist(dataFrames$M_Inner_L_Arm$AvgMeasurement, 
     xlab="Distribution of Melanosomes",
     sub="(outliers included)",
     xlim= c(20,100),
     ylim = c(0,35),
     breaks = 10,
     las=2,
     main = "Left Arm Melanosomes", 
     ylab= "Frequency",
     col = "azure2")
dev.off()

#Removing outliers using 2*sd as the parameter
eir <- dataFrames$E_Inner_R_Arm$AvgMeasurement[(dataFrames$E_Inner_R_Arm$AvgMeasurement-mean(dataFrames$E_Inner_R_Arm$AvgMeasurement))>(-2*sd(dataFrames$E_Inner_R_Arm$AvgMeasurement)) & (dataFrames$E_Inner_R_Arm$AvgMeasurement-mean(dataFrames$E_Inner_R_Arm$AvgMeasurement))<(2*sd(dataFrames$E_Inner_R_Arm$AvgMeasurement))]

eil <- dataFrames$E_Inner_L_Arm$AvgMeasurement[(dataFrames$E_Inner_L_Arm$AvgMeasurement-mean(dataFrames$E_Inner_L_Arm$AvgMeasurement))>(-2*sd(dataFrames$E_Inner_L_Arm$AvgMeasurement)) & (dataFrames$E_Inner_L_Arm$AvgMeasurement-mean(dataFrames$E_Inner_L_Arm$AvgMeasurement))<(2*sd(dataFrames$E_Inner_L_Arm$AvgMeasurement))]

mil <- dataFrames$M_Inner_L_Arm$AvgMeasurement[(dataFrames$M_Inner_L_Arm$AvgMeasurement-mean(dataFrames$M_Inner_L_Arm$AvgMeasurement))>(-2*sd(dataFrames$M_Inner_L_Arm$AvgMeasurement)) & (dataFrames$M_Inner_L_Arm$AvgMeasurement-mean(dataFrames$M_Inner_L_Arm$AvgMeasurement))<(2*sd(dataFrames$M_Inner_L_Arm$AvgMeasurement))]

mir <- dataFrames$M_Inner_R_Arm$AvgMeasurement[(dataFrames$M_Inner_R_Arm$AvgMeasurement-mean(dataFrames$M_Inner_R_Arm$AvgMeasurement))>(-2*sd(dataFrames$M_Inner_R_Arm$AvgMeasurement)) & (dataFrames$M_Inner_R_Arm$AvgMeasurement-mean(dataFrames$M_Inner_R_Arm$AvgMeasurement))<(2*sd(dataFrames$M_Inner_R_Arm$AvgMeasurement))]

pdf(file= "graphs_wo_outilers", height=8, width=7)
par(mfrow=c(2,2))

#Visualizing the data with outlier removal
hist(eir, 
     xlab="Distribution of Eumelanin Averages",
     sub="(outliers excluded)",
     xlim= c(10,25),
     ylim = c(0,25),
    # breaks = 11,
     las=2,
     main = "Right Arm Eumelanin  ", 
     ylab= "Frequency",
     col = "skyblue2")

hist(eil, 
     xlab="Distribution of Eumelanin Averages",
     sub="(outliers excluded)",
     xlim= c(10,25),
     ylim = c(0,25),
     #breaks = 20,
     las=2,
     main = "Left Arm Eumelanin  ", 
     ylab= "Frequency",
     col = "skyblue2")

hist(mir, 
     xlab="Distribution of Melanosomes Averages",
     sub="(outliers excluded)",
     xlim= c(20,100),
     ylim = c(0,35),
     breaks = 10,
     las=2,
     main = "Right Arm Melanosomes", 
     ylab= "Frequency",
     col = "azure2")

hist(mil,
     xlab="Distribution of Melanosomes",
     sub="(outliers excluded)",
     xlim= c(20,100),
     ylim = c(0,35),
     breaks = 10,
     las=2,
     main = "Left Arm Melanosomes", 
     ylab= "Frequency",
     col = "azure2")

dev.off()

hist(mrppl_BVL$Average,
     main = "M. Right Arm by Town",
     xlim= c(5,25),
     ylim = c(0,15),
     breaks = 10,
     las=2,
     col = alpha("azure2",0.5))

hist(mrppl_CRN$Average,
     xlim= c(5,25),
     ylim = c(0,15),
     breaks = 10,
     las=2,
     col = alpha("coral2",0.8),
     add=T)

hist(elppl_BVL$Average,
     main = "M. Left Arm by Town",
     xlim= c(5,25),
     ylim = c(0,15),
     breaks = 10,
     las=2,
     col = alpha("azure2",0.5))

hist(elppl_CRN$Average,
     xlim= c(5,25),
     ylim = c(0,15),
     breaks = 10,
     las=2,
     col = alpha("coral2",0.8),
     add=T)



hist(erppl_BVL$Average,
     main = "M. Right Arm by Town",
     xlim= c(5,25),
     ylim = c(0,15),
     breaks = 10,
     las=2,
     col = alpha("azure2",0.5))

hist(erppl_CRN$Average,
     xlim= c(5,25),
     ylim = c(0,15),
     breaks = 10,
     las=2,
     col = alpha("coral2",0.8),
     add=T)

hist(elppl_BVL$Average,
     main = "E. Left Arm by Town",
     xlim= c(5,25),
     ylim = c(0,15),
     breaks = 10,
     las=2,
     col = alpha("azure2",0.5))

hist(elppl_CRN$Average,
     xlim= c(5,25),
     ylim = c(0,15),
     breaks = 10,
     las=2,
     col = alpha("coral2",0.8),
     add=T)


mean(elppl_BVL$Average)


