## FDcompetitions.R by Rohan Maddamsetti

source("FD_plot_library.R")

###############################################################
##### analyze 7.5K FD competition data.

input.data <- read.csv("/Users/Rohandinho/Desktop/Projects/Ara-1_Frequency_Dependence/data/04122012_competition_data.csv")
competition.48.7.data <- input.data[input.data$Competition=="48+7",]
competition.45.8.data <- input.data[input.data$Competition=="45+8",] 

#First, examine both competitions separately.
#Check to make sure both give the same trend.
#Then it should be OK to combine both datasets.
#This is to check that there isn't any problems with the data/experiment.

comp1 <- sum.DT.replicates(competition.48.7.data)
comp2 <- sum.DT.replicates(competition.45.8.data)
analyze.data(comp1)
analyze.data(comp2)

##Now, combine the data from the competitions.
##The two competitions are identical, but have reversed polarity,
##i.e. one is red vs. white, and the other is white vs. red
##for the two competitors.

##The easiest thing to do, is to swap the names of the columns for comp2,
##i.e., swap D0.red and D0.white, etc., and change the values in the
##Replicate column from 1-6 to 7-12. Then, add this dataframe to comp1,
## and analyse all the data together.
names(comp2) <- c("Ratio", "Replicate", "D0.white", "D0.red", "Df.white", "Df.red")
comp2$Replicate <- c(7,7,7,8,8,8,9,9,9,10,10,10,11,11,11,12,12,12)

##In the 10K FD competition, the Clade 1 clone (RM1.19.62) is red, and the
##Clade 2 clone (RM2.34.1) is white.
##In this 7.5K FD competition, the Clade 1 clone (RM1.72.53)'s red version is
##RM2.12.7, and the Clade 2 clone (RM1.72.69)'s white version is RM2.48.1.
##So, the 48+7 competition has the same polarity as the 10K competition.
##By switching the polarity of comp2 and analyzing full.data, these results
##are directly comparable to the 10K FD competition results.

full.data <- rbind(comp1,comp2)
results <- analyze.FD.data(full.data,samplesize=12)

the.title <- "Difference in Fitness between Competitors at 7500 Generations"
the.output <- "/Users/Rohandinho/Desktop/Projects/Ara-1_Frequency_Dependence/results/7.5K_FDplot.eps"
plot.FD.competition(results, the.title ,the.output)

###############################################################
###analyze 10K competition data.

tenK.input.data <- read.csv("/Users/Rohandinho/Desktop/Projects/Ara-1_Frequency_Dependence/data/04052012_competition_data.csv")
tenK.data <- sum.DT.replicates(tenK.input.data)
tenK.sample.size <- 12
tenK.results <- analyze.FD.data(tenK.data, tenK.sample.size, 6)

tenK.title <- "Difference in Fitness between Competitors at 10000 Generations"
tenK.output.file <- "/Users/Rohandinho/Desktop/Projects/Ara-1_Frequency_Dependence/results/10K_FDplot.eps"

## Reverse the x-labels: these particular data are formatted in the opposite
## red:white ratio compared to the other data sets. To avoid input errors, the
## csv file storing these data is formatted as the data was written in my lab
## notebook.
plot.FD.competition(tenK.results, tenK.title, tenK.output.file, rev.x.labels=TRUE)

###############################################################
#### analyze nuoM FD competition data.

nuoM.input.data <- read.csv("/Users/Rohandinho/Desktop/Projects/Ara-1_Frequency_Dependence/data/07192012_competition_data.csv")
nuoM.data <- sum.DT.replicates(nuoM.input.data)
nuoM.sample.size <- 12 
nuoM.days = 6
nuoM.results <- analyze.FD.data(nuoM.data, nuoM.sample.size, nuoM.days)
nuoM.title <- "Difference in Fitness between Competitors"
nuoM.output <- "/Users/Rohandinho/Desktop/Projects/Ara-1_Frequency_Dependence/results/nuoM_FDplot.eps"
plot.FD.competition(nuoM.results, nuoM.title, nuoM.output)

###############################################################
###### analyze nuoG FD competition data.

nuoG.input.data <- read.csv("/Users/Rohandinho/Desktop/Projects/Ara-1_Frequency_Dependence/data/08202012_competition_data.csv")
nuoG.data <- sum.DT.replicates(nuoG.input.data)
nuoG.sample.size <- 12 
nuoG.days = 6
nuoG.results <- analyze.FD.data(nuoG.data, nuoG.sample.size, nuoG.days)
nuoG.title <- "Difference in Fitness between Competitors"
nuoG.output <- "/Users/Rohandinho/Desktop/Projects/Ara-1_Frequency_Dependence/results/nuoG_FDplot.eps"
plot.FD.competition(nuoG.results, nuoG.title, nuoG.output)

###############################################################
###### analyze nuoG-nadR FD competition data.

nadR.input.data <- read.csv("/Users/Rohandinho/Desktop/Projects/Ara-1_Frequency_Dependence/data/06192013_competition_data.csv")
nadR.data <- sum.DT.replicates(nadR.input.data)
nadR.sample.size <- 12 
nadR.days = 6
nadR.results <- analyze.FD.data(nadR.data, nadR.sample.size, nadR.days)
nadR.title <- "Difference in Fitness between Competitors"
nadR.output <- "/Users/Rohandinho/Desktop/Projects/Ara-1_Frequency_Dependence/results/nuoG-nadR_FDplot.eps"
plot.FD.competition(nadR.results, nadR.title, nadR.output)
