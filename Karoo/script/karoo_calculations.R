hist(em_averages$E_L.Average...MinMax, main="Average E Values for Left Arm", 
     xlab = "E Values", breaks=60, xlim=c(10,25), ylim = c(2,24), col="pink")
     
hist(em_averages$E_R.Average...MinMax, main="Average E Values for Left Arm", 
     xlab = "E Values", breaks=60, xlim=c(10,25), ylim = c(2,18), col="pink")
     
mean(em_averages$E_R.Average...MinMax) 
mean(em_averages$M_R.Average...MinMax)
mean(em_averages$E_L.Average...MinMax) 
mean(em_averages$M_L.Average...MinMax)
sd(em_averages$E_R.Average...MinMax) 
sd(em_averages$M_R.Average...MinMax)
sd(em_averages$E_L.Average...MinMax) 
sd(em_averages$M_L.Average...MinMax)

print(mean(em_averages$E_R.Average...MinMax)+2*(sd(em_averages$E_R.Average...MinMax)))
print(mean(em_averages$M_R.Average...MinMax)+2*(sd(em_averages$M_R.Average...MinMax)))
print(mean(em_averages$E_L.Average...MinMax)+2*(sd(em_averages$E_L.Average...MinMax)))
print(mean(em_averages$M_L.Average...MinMax)+2*(sd(em_averages$M_L.Average...MinMax)))

outliers <- which(em_averages$E_R.Average...MinMax >20.9,em_averages$E_R.Average...MinMax <20.9,
                  em_averages$M_R.Average...MinMax >75.22,em_averages$M_R.Average...MinMax <75.22,
                  em_averages$E_L.Average...MinMax >24.36,em_averages$E_L.Average...MinMax <24.36,
                  em_averages$M_R.Average...MinMax >76.76,em_averages$M_R.Average...MinMax <76.76)

hist(em_averages$E_L.Average...MinMax&em_averages$E_R.Average...MinMax main="Average E Values for Left Arm", 
     xlab = "E Values", breaks=60, xlim=c(10,25), ylim = c(2,24), col="pink")

comb


