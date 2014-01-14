##competitions.R by Rohan Maddamsetti
##This script analyzes Competition data.

days = 6
data <- read.csv("../data/06092012_competition_data.csv")
data$Mr <- log(data$Df.red*100^days/data$D0.red)
data$Mw <- log(data$Df.white*100^days/data$D0.white)
data$W <- data$Mr/data$Mw
strain1 <- subset(data,Name==1)
strain2 <- subset(data,Name==2)
strain3 <- subset(data,Name==3)
mean1 <- mean(strain1$W, na.rm=T)
mean2 <- mean(strain2$W, na.rm=T)
mean3 <- mean(strain3$W, na.rm=T)
sd1 <- sd(strain1$W, na.rm=T)
sd2 <- sd(strain2$W, na.rm=T)
sd3 <- sd(strain3$W, na.rm=T)
samplesize <- 10 ##This must be adjusted in the confint expressions if some plates or cultures failed.
confint1 <- c(mean1 - 1.96*sd1/sqrt(samplesize), mean1 + 1.96*sd1/sqrt(samplesize))
confint2 <- c(mean2 - 1.96*sd2/sqrt(samplesize), mean2 + 1.96*sd2/sqrt(samplesize))
confint3 <- c(mean3 - 1.96*sd3/sqrt(samplesize), mean3 + 1.96*sd3/sqrt(samplesize))
