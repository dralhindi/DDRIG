# using ggplot2 for GWAS

args=commandArgs(TRUE)

# read in data
data <- read.table(args[1], header = TRUE)
pval = args[2]

data = as.data.frame(data)


# load libraries
library(ggplot2)
library(dplyr)


data$BPcum <- NA
s <- 0
nbp <- c()
for (i in unique(data$CHR)){
  nbp[i] <- max(data[data$CHR == i,]$BP)
  data[data$CHR == i,"BPcum"] <- data[data$CHR == i,"BP"] + s
  s <- s + nbp[i]
}

axisdf = data %>% group_by(CHR) %>% summarize(center=( max(BPcum) + min(BPcum) ) / 2 )


# -log10(pval) and bonferonni cut off
data$logp <- -log10(data$pval)
bofferroni<- -log10(0.05/dim(data)[1])


# filter data so it can graph a little more easily
data<-data[!(data$pval==0),]
data <- filter(data, pval < 1e-2)

# plot
plot <- ggplot(data, aes(x=BPcum, y=logp)) +

  # add bofferroni cut off
  geom_hline(yintercept=bofferroni, color = "red", size=.65) +

  # show all points
  geom_point( aes(color=as.factor(CHR)), alpha=0.4, size=1.3) +
  scale_color_manual(values = rep(c("skyblue4", "mediumorchid"), 22 )) +

  # custom X axis:
  scale_x_continuous( label = axisdf$CHR, breaks= axisdf$center ) +
  # remove space between plot area and x axis
  scale_y_continuous(expand = c(0, 0) ) +

  # add title and lables
  ggtitle(paste(args[2],"Manhattan Plot")) +
  xlab("BP") + ylab("-log10(PVALUE)") +


  # custom the theme:
  theme_bw() +
  theme(
    legend.position="none",
    panel.border = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank()
  )


pdf(paste(args[1],"_gwasplot.pdf",sep=""), height=6, width=12)
plot
dev.off()

