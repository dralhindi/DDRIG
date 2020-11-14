# using ggplot2 for GWAS
# load libraries 
library(ggplot2)
library(dplyr)
library(qqman)

# set working directory 
setwd("/Users/dana.alhindi/Dropbox/UKB_Pigmentation")
data_snp <- data
data_snp$SNPid<-seq(1:nrow(data_snp))
manhattan(data, p="PVAL_META", bp="BP", chr="CHR")
?manhattan

# read in data
chr20_22 <- read.table(file="20_22_testfile.tsv", header=TRUE)
data <- chr20_22
head(data_snp)
nrow(data)

# nCHR <- length(unique(data$CHR))
data$BPcum <- NA
s <- 0
nbp <- c()
for (i in unique(data$CHR)){
  nbp[i] <- max(data[data$CHR == i,]$BP)
  data[data$CHR == i,"BPcum"] <- data[data$CHR == i,"BP"] + s
  s <- s + nbp[i]
}

head(data)

#data <- data %>% 
  
  # Compute chromosome size
#  group_by(data$CHR) %>% 
#   summarise(chr_len=max(BP)) %>% 
#   
#   # Calculate cumulative position of each chromosome
#   mutate(tot=cumsum(chr_len)-chr_len) %>%
#   select(-chr_len) %>%
#   
#   # Add this info to the initial dataset
#   left_join(data, ., by=c("CHR"="CHR")) %>%
#   
#   # Add a cumulative position of each SNP
#   arrange(CHR, BP) %>%
#   mutate( BPcum=BP+tot)
# 
# axisdf = data %>% group_by(CHR) %>% summarize(center=( max(BPcum) + min(BPcum) ) / 2 )

head(data)
nrow(data)

# -log10(PVAL) and bonferonni cut off
data$logp <- -log10(data$PVAL_META)
bofferroni<- -log10(0.05/dim(data)[1])

head(data)


# filter data so it can graph a little more easily
data <- filter(data, PVAL_META < 1e-2)
nrow(data)
data<-data[!(data$PVAL_META==0),]
nrow(data)
head(data)

# plot
plot <- ggplot(data, aes(x=BPcum, y=-log10(PVAL_META))) +
  
  # add bofferroni cut off
  geom_hline(yintercept=bofferroni, color = "red", size=.85) +
  
  # show all points
  geom_point( aes(color=as.factor(CHR)), alpha=0.4, size=1.3) +
  scale_color_manual(values = rep(c("skyblue4", "mediumorchid"), 22 )) +
  
  # custom X axis:
  scale_x_continuous( label = axisdf$CHR, breaks= axisdf$center ) +
  # remove space between plot area and x axis
  scale_y_continuous(expand = c(0, 0) ) +     
  # remove space between plot area and x axis
  
  
  # custom the theme:
  theme_bw() +
  theme( 
    legend.position="none",
    panel.border = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank()
  )

plot

