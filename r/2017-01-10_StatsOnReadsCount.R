
DF <- read.csv("~/Documents/Maitrise-Microbiome/2017-01-10_extractedReadsRatio.csv")
J0 <- DF$J0
J7 <- DF$J7
J90 <- DF$J90

boxplot(J0, J7, J90, outline=FALSE, main="WTF R?!")

boxplot(log(DF$J0), log(DF$J7), log(DF$J90), outline=FALSE)

library(ggplot2)

boxplot(Winzorize(DF$J0), winzorize(DF$J7), winzorize(DF$J90))


