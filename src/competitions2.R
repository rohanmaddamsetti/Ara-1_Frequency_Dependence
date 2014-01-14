## competitions2.R by Rohan Maddamsetti
## competitions.R is generally for finding neutral revertants.
## This script is for measuring the fitness of an allele.
## In this case, the allele is the Ara-1 nadR allele on the LoD,
## measured on the REL606 background in comparison to REL607.

days = 6
input.data <- read.csv("../data/06262013_competition_data.csv")
##sum over DT.replicate.
input.data1 <- input.data[,c("D0.red","D0.white","Df.red","Df.white")]
data <- aggregate(input.data[,c("D0.red","D0.white","Df.red","Df.white")],by=list(input.data$Replicate),FUN=sum,na.rm=TRUE)
colnames(data)[1] = "Replicate"

data$Mr <- log(data$Df.red*100^days/data$D0.red)
data$Mw <- log(data$Df.white*100^days/data$D0.white)
data$W <- data$Mr/data$Mw
mean.W <- mean(data$W, na.rm=T)
sd.W <- sd(data$W, na.rm=T)
samplesize <- 10 ##This must be adjusted in the confint expressions if some plates or cultures failed.
confint.W <- c(mean.W - 1.96*sd.W/sqrt(samplesize), mean.W + 1.96*sd.W/sqrt(samplesize))


