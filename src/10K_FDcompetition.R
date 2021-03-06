##10K_FDcompetition.R by Rohan Maddamsetti
##This script analyzes 04052012_competition_data.csv to test for
##frequency-dependence between the two clades that co-existed at this timepoint.

input.data <- read.csv("/Users/Rohandinho/Desktop/Projects/Ara-1_Frequency_Dependence/data/04052012_competition_data.csv")
##sum over DT.replicate.
input.data1 <- input.data[,c("D0.red","D0.white","Df.red","Df.white")]
data <- aggregate(input.data[,c("D0.red","D0.white","Df.red","Df.white")],by=list(input.data$Ratio,input.data$Replicate),FUN=sum,na.rm=TRUE)
colnames(data)[1] = "Ratio"
colnames(data)[2] = "Replicate"


data$Mr <- log(data$Df.red*100^6/data$D0.red)
data$Mw <- log(data$Df.white*100^6/data$D0.white)
data$W <- data$Mr/data$Mw
ratio1 <- subset(data,Ratio=="1:9")
ratio2 <- subset(data,Ratio=="1:1")
ratio3 <- subset(data,Ratio=="9:1")
mean1 <- mean(ratio1$W, na.rm=T)
mean2 <- mean(ratio2$W, na.rm=T)
mean3 <- mean(ratio3$W, na.rm=T)
sd1 <- sd(ratio1$W, na.rm=T)
sd2 <- sd(ratio2$W, na.rm=T)
sd3 <- sd(ratio3$W, na.rm=T)
samplesize <- 12 ##This must be adjusted in the confint expressions if some plates or cultures failed.
confint1 <- c(mean1 - 1.96*sd1/sqrt(samplesize), mean1 + 1.96*sd1/sqrt(samplesize))
confint2 <- c(mean2 - 1.96*sd2/sqrt(samplesize), mean2 + 1.96*sd2/sqrt(samplesize))
confint3 <- c(mean3 - 1.96*sd3/sqrt(samplesize), mean3 + 1.96*sd3/sqrt(samplesize))

left.error <- c(confint1[1],confint2[1],confint3[1])
right.error <- c(confint1[2],confint2[2],confint3[2])

##Now plot the results of the competition.
library(ggplot2)

results <- data.frame(Ratio=as.factor(c("1:9","1:1","9:1")),Fitness=c(mean1,mean2,mean3),Left=left.error,Right=right.error)

##manually change levels to plot x-axis properly.
ratio.table <- table(results$Ratio)
ratio.levels <- names(ratio.table)[reverse(rank(results$Ratio))]
results$Ratio <- factor(results$Ratio, levels = ratio.levels)

the.plot <- ggplot(results,aes(x=Ratio,y=Fitness)) +
  geom_errorbar(aes(ymin=Left,ymax=Right),width=0.1) +
  geom_line() +
  geom_point() +
  scale_y_continuous(limits=c(0.94,1.04)) +
  labs(title="Difference in Fitness between Competitors at 10000 Generations") +
  geom_hline(aes(yintercept=1), colour="#990000", linetype="dashed")

ggsave(the.plot, file="/Users/Rohandinho/Desktop/Projects/Ara-1_Frequency_Dependence/results/10K_FDplot.pdf")
