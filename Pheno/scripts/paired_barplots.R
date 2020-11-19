setwd("/Users/dana.alhindi/Dropbox/Grants_Fellowship_Apps/NSF_DDRIG_Dana")
options(stringsAsFactors=F)

# Load data
Dat <- read.csv("Martin_Table2.csv")
head(Dat)

# Make main plot
pdf(file="/Users/dana.alhindi/Dropbox/Grants_Fellowship_Apps/NSF_DDRIG_Dana/Martin_freq_paired_barplot.pdf", width=12, height = 6) 

barplot(height=t(as.matrix(Dat[,c("San_freq", "W_Afr_freq", "N_Eur_freq")])), beside=T, space=c(0,2),
        col=c("#D3DDDC", "#FCD16B","#76A08A"),
        ylab="Frequency of Pigmentation Allele"
        )
legend(90,1, legend=c("San", "W African", "European"),
       col=c("#D3DDDC", "#FCD16B", "#76A08A"), pch=15, cex = 0.75, bty = "n")
axis(side=1, at=seq(3.5, 95, 5), labels=Dat$Gene, las=2, cex.axis=0.7, padj=-0.5)
axis(side=1, at=seq(3.5, 95, 5), labels=Dat$SNP, las=2, cex.axis=0.7, padj=1, tick=F)

# Add San CIs
San.xPositions <- seq(2.5, nrow(Dat)*5, 5)
for (i in 1:nrow(Dat)) {
    X <- San.xPositions[i]
    L.CI <- Dat$San_95._LCI[i]
    U.CI <- Dat$San_95._UCI[i]
    segments(x0=X,x1=X,y0=L.CI,y1=U.CI)
}

dev.off()

