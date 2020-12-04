library(agricolae)
library(DescTools)

# ANOVA and Post-Hoc Testing

data <- pigmentation_data
data <- data[-which(is.na(data$M_Arm)), ]
data$Population <- as.factor(data$Population)
data$M_Arm <- as.numeric(data$M_Arm)

data1 <- pigmentation_data_minusKaroo
data1 <- data1[-which(is.na(data1$M_Arm)), ]
data1$Population <- as.factor(data1$Population)
data1$M_Arm <- as.numeric(data1$M_Arm)

results <- aov(M_Arm ~ Population, data = data)
summary(results)
ScheffeTest(results)

results_minusKaroo <- aov(M_Arm ~ Population, data = data1)
summary(results_minusKaroo)
ScheffeTest(results_minusKaroo)
