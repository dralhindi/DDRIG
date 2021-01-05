library(ggplot2)
library(dplyr)

# Using ggplot2 for GWAS by Dana Al-Hindi.
# The file is named Royal T after the Royal Tenenbaum colors scheme.

# This code is set up to plot the statistical results from a GWAS.
# It requires a data frame that has a column CHR and BP present.
# args[1]: the name of the file
# args[2]: the column of which to plot (p-values)

# Set arguments as true.
args <- commandArgs(TRUE)

# Read in data.
data <- read.table(args[1], header = TRUE)
pval <- args[2]
data <- as.data.frame(data)
data[pval] <- lapply(data[pval], as.numeric)

# Set colors for plot.

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
data$logp <- -log10(data[pval])
bofferroni<- -log10(0.05/dim(data)[1])


# filter data so it can graph a little more easily
data<-data[!(data[pval]==0),]
data <- filter(data, data[pval] < 1e-3)
data$logp = unlist(data$logp)

# reorder factor levels for plot
data$CHR = factor(data$CHR, levels = c("1",  "2",  "3",  "4",  "5", "6", "7",  "8",  "9", "10",
                                       "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
                                       "21", "22", "23", "24", "X"))


# plot
plot <- ggplot(data, aes(x=BPcum, y=logp)) +

  # add bofferroni cut off
  geom_hline(yintercept=bofferroni, color = "red", size=.65) +

  # show all points
  geom_point( aes(color=CHR), alpha=0.45, size=1.3) +
  scale_color_manual(values = rep(c("#944e6c", "#83a95c", "#e9c496"), 12)) +

  # custom X axis:
  scale_x_continuous( label = axisdf$CHR, breaks= axisdf$center ) +

  # remove space between plot area and x axis
  scale_y_continuous(expand = c(0, 0) ) +

  # add title and lables
  #ggtitle(paste(args[2],"Manhattan Plot")) +
  xlab("CHR") + #ylab("-log10(PVALUE)") +

  # custom the theme:
  theme_bw() +
  theme(
    legend.position="none",
    panel.border = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank()
  )


pdf(paste("gwasplot", args[2], args[1], ".pdf", sep="_"), height=6, width=12)
plot
dev.off()
