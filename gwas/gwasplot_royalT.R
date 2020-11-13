library(ggplot2)
library(dplyr)

# Using ggplot2 for GWAS by Dana Al-Hindi. 
# The file is named Royal T after the Royal Tenenbaum colors scheme.

# This code is set up to plot the statistical results from a GWAS. 
# It requires a data frame that has a column CHR and BP present. 
# args[1]: the name of the file
# args[2]: the column of which to plot (p-values)

# Set arguments as true.
args=commandArgs(TRUE)


# Read in data.
data <- read.table(args[1], header = TRUE)
pval = args[2]
data = as.data.frame(data)
data[pval] <- lapply(data[pval], as.numeric)

# Set colors for plot.

olive_yellow <- "#9A872D"
soft_orange <- "#F5CDB6"
soft_red <- "#F7B0AA"
mango_yogurt <- "#FDDDA4"
moss_green <- "#76A08A"

colors <- c(olive_yellow, soft_orange, soft_red, mango_yogurt, moss_green, 
            olive_yellow, soft_orange, soft_red, mango_yogurt, moss_green,
            olive_yellow, soft_orange, soft_red, mango_yogurt, moss_green, 
            olive_yellow, soft_orange, soft_red, mango_yogurt, moss_green,
            olive_yellow, soft_orange, soft_red)


data$BPcum <- NA

# Group by chromosome and string bp together numerically.
s <- 0
nbp <- c()
for (i in unique(data$CHR)){
  nbp[i] <- max(data[data$CHR == i,]$BP)
  data[data$CHR == i,"BPcum"] <- data[data$CHR == i,"BP"] + s
  s <- s + nbp[i]
}

# Define an axis.
axisdf = data %>% group_by(CHR) %>% summarize(center=( max(BPcum) + min(BPcum) ) / 2 )


# -log10(pval) and bonferonni cut off
data$logp <- -log10(data[pval])
bofferroni<- -log10(0.05/dim(data)[1])


# filter data so it can graph a little more easily
data<-data[!(data[pval]==0),]
data <- filter(data, data[pval] < 1e-2)
data$logp = unlist(data$logp)


plot <- ggplot(data, aes(x=BPcum, y=logp)) +

  # show all points
  geom_point( aes(color=as.factor(CHR)), alpha=0.65, size=1.3) +
  scale_color_manual(values = colors) +

  # custom X axis:
  scale_x_continuous( label = axisdf$CHR, breaks= axisdf$center ) +

  # remove space between plot area and x axis
  scale_y_continuous(expand = c(0, 0) ) +

  # add title and lables
  ggtitle(paste(args[2],"Manhattan Plot")) +
  xlab("BP") + ylab("-log10(PVALUE)") +

  # add bofferroni cut off
  geom_hline(yintercept=bofferroni, color = "red", size=.55) +

  # custom the theme:
  theme_bw() +
  theme(
    legend.position="none",
    panel.border = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank()
  )


pdf(paste("gwasplot",args[2],args[1],".pdf", sep="_"), height=6, width=12)
plot
dev.off()
