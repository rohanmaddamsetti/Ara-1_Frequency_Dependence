# FD_plot_library.R by Rohan Maddamsetti.
# This file contains common code that is reused in my FD competition analysis scripts.

library(ggplot2)

sum.DT.replicates <- function(the.input.data) {
data <- aggregate(the.input.data[,c("D0.red","D0.white","Df.red","Df.white")],by=list(the.input.data$Ratio,the.input.data$Replicate),FUN=sum,na.rm=TRUE)
colnames(data)[1] = "Ratio"
colnames(data)[2] = "Replicate"
return(data)
}

analyze.FD.data <- function(data, samplesize, days.of.competition=6) {
data$Mr <- log(data$Df.red*100^days.of.competition/data$D0.red)
data$Mw <- log(data$Df.white*100^days.of.competition/data$D0.white)
data$W <- data$Mw/data$Mr
#data$W <- data$Mr/data$Mw
ratio1 <- subset(data,Ratio=="1:9")
ratio2 <- subset(data,Ratio=="1:1")
ratio3 <- subset(data,Ratio=="9:1")
mean1 <- mean(ratio1$W, na.rm=T)
mean2 <- mean(ratio2$W, na.rm=T)
mean3 <- mean(ratio3$W, na.rm=T)
sd1 <- sd(ratio1$W, na.rm=T)
sd2 <- sd(ratio2$W, na.rm=T)
sd3 <- sd(ratio3$W, na.rm=T)

confint1 <- c(mean1 - 1.96*sd1/sqrt(samplesize), mean1 + 1.96*sd1/sqrt(samplesize))
confint2 <- c(mean2 - 1.96*sd2/sqrt(samplesize), mean2 + 1.96*sd2/sqrt(samplesize))
confint3 <- c(mean3 - 1.96*sd3/sqrt(samplesize), mean3 + 1.96*sd3/sqrt(samplesize))

print("mean1 is:")
print(mean1)
print("mean2 is:")
print(mean2)
print("mean3 is:")
print(mean3)

print("confint1 is:")
print(confint1)
print("confint2 is:")
print(confint2)
print("confint3 is:")
print(confint3)

##return a dataframe of the results for plotting.
left.error <- c(confint1[1],confint2[1],confint3[1])
right.error <- c(confint1[2],confint2[2],confint3[2])
results <- data.frame(Ratio=as.factor(c("1:9","1:1","9:1")),Fitness=c(mean1,mean2,mean3),Left=left.error,Right=right.error)
return(results)
}

change.ratio.helper <- function (element) {
  if (element == "1:9") {
    return(0.1)
  }
  else if (element == "1:1") {
    return(0.5)
  }
  else if (element == "9:1") {
    return(0.9)
  }
}

best.fit <- function(results) {
  work.with <- results
  work.with$Frequency <- sapply(work.with$Ratio, change.ratio.helper)
  model <- lm(data=work.with,Fitness~Frequency)
  return(coef(model))
}

plot.FD.competition <- function (results, plot.title, output.file,rev.x.labels=FALSE) {

##change levels to plot x-axis properly.
  ratio.table <- table(results$Ratio)
  if (rev.x.labels) {
    ratio.levels <- names(ratio.table)[rev(rank(results$Ratio))]
  } else {
    ratio.levels <- names(ratio.table)[rank(results$Ratio)]
  }
  results$Ratio <- factor(results$Ratio, levels = ratio.levels)
  
#  the.intercept <- best.fit(results)[1]
#  the.slope <- best.fit(results)[2]
  
  the.plot <- ggplot(results,aes(x=Ratio,y=Fitness)) +
    geom_hline(aes(yintercept=1), colour="#EE5623", size=2) +
   #   geom_abline(intercept=the.intercept, slope=the.slope) + 
      geom_errorbar(aes(ymin=Left,ymax=Right),width=0.1, size=2) +
        geom_line() +
          geom_point(size=4) +
            scale_y_continuous(limits=c(0.94,1.06)) +
              labs(title=plot.title) +
                theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank(), axis.ticks=element_blank(), panel.background=element_rect(fill="#FFFFFF"))


ggsave(the.plot, file=output.file)
  
}
