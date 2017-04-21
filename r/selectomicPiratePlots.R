library(yarrr)
#library(reshape)

dfAllRsem <- read.csv("~/GitHub/codingTheMicrobiome/data/selectomic-Rsem/Selectomic-Rsem.csv")

foxCo2DF <- subset(dfAllRsem, antibiotic == "FOX" & gas == "CO2")
foxAnaDF <- subset(dfAllRsem, antibiotic == "FOX" & gas == "ANA")
mebCo2DF <- subset(dfAllRsem, antibiotic == "MEB" & gas == "CO2")
mebAnaDF <- subset(dfAllRsem, antibiotic == "MEB" & gas == "ANA")

par(mfrow=c(2,2))
pirateplot(formula = log(expected_count) ~ day, avg.line.fun = median, 
           data = mebCo2DF, 
           main = "mebCo2")

pirateplot(formula = log(expected_count) ~ day, avg.line.fun = median, 
           data = foxCo2DF,
           main = "foxCo2")

pirateplot(formula = log(expected_count) ~ day, avg.line.fun = median, 
           data = mebAnaDF,
           main = "mebAna")

pirateplot(formula = log(expected_count) ~ day, avg.line.fun = median, 
           data = foxAnaDF,
           main = "foxAna")

par(mfrow=c(2,2))
pirateplot(formula = log(expected_count) ~ day, avg.line.fun = median, 
           hdi.iter = 0,
           data = mebCo2DF, 
           main = "mebCo2")

pirateplot(formula = log(expected_count) ~ day, avg.line.fun = median, 
           hdi.iter = 0,
           data = foxCo2DF,
           main = "foxCo2")

pirateplot(formula = log(expected_count) ~ day, avg.line.fun = median, 
           hdi.iter = 0,
           data = mebAnaDF,
           main = "mebAna")

pirateplot(formula = log(expected_count) ~ day, avg.line.fun = median, 
           hdi.iter = 0,
           data = foxAnaDF,
           main = "foxAna")


# Number of reads that matched to CGR1 or CGR2 region
CGR1_2_longDF <- read_csv("~/GitHub/codingTheMicrobiome/data/CGR1-2-longDF.csv")

par(mfrow=c(1,1))
pirateplot(formula = mappedReads ~ day, 
           data = CGR1_2_longDF,
           main = "mappedToCGR")

library(betareg)
fit <- glm(expected_count ~ day, data = foxCo2DF)
summary(fit)
plot(fit)

subset(foxCo2DF, day == "0")$expected_count

wilcox.test(subset(foxCo2DF, day == "0")$expected_count, 
            subset(foxCo2DF, day == "7")$expected_count,
            paired = TRUE)


foxCo2DF


foxCo2DF
foxAnaDF
mebCo2DF
mebAnaDF


pirateplot(formula = log(expected_count) ~ day, avg.line.fun = median, 
           data = mebCo2DF, 
           main = "mebCo2")

pirateplot(formula = log(Ratio) ~ Time + Treatment, avg.line.fun = median, 
           hdi.iter = 0,
           data = DFLM, 
           main = "Burrows-Wheeler Aligner")
par(mfrow=c(1,1))



