library(tidyverse)
library(ggforce)
library(ggplot2)

# creating a venn diagram using ggplot2

# contrust the circles 
data <- data.frame(x = c(0, 1, -1),
                   y = c(-0.5, 1, 1),
                   tx = c(0, 1.5, -1.5),
                   ty = c(-1, 1.3, 1.3),
                   cat = c('META_hits', 'EUR_hits', 
                           'AFR_hits'))

# plot with annotations
ggplot(data, aes(x0 = x , y0 = y, r = 1.5, fill = cat)) + 
  geom_circle(alpha = 0.25, size = 0.2, color = "black",show.legend = FALSE) + 
  geom_text(aes(x = tx , y = ty, label = cat), size = 7) +
  annotate(geom="text", x=0, y=1.5, label="x",color="purple", size = 5) +
  annotate(geom="text", x=-0.9, y=0, label="12",color="darkblue", size = 5) +
  annotate(geom="text", x=0.9, y=0, label="111",color="darkgreen", size = 5) +
  annotate(geom="text", x=0, y=0.5, label="y",color="darkgray", size = 5) +
  theme_void() 


