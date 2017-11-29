dev.off()
library(yarrr)
library(tidyr)
library(reshape)

# Local function to deal with outliers
winsorize <- function(x, q) {
  if(missing(q)) { q = 0.05 }
  extrema <- quantile(x, c(q, 1-q))
  x[x<extrema[1]] <- extrema[1]
  x[x>extrema[2]] <- extrema[2]
  x
}

DF <- read.csv("~/GitHub/codingTheMicrobiome/r/2017-01-10_extractedReadsRatio.csv")
#DF["J0"] <- winsorize(DF$J0, q = 0.0135); qqnorm(DF$J0);
#DF["J7"] <- winsorize(DF$J7, q = 0.0135); qqnorm(DF$J7);
#DF["J90"] <- winsorize(DF$J90, q = 0.04); qqnorm(DF$J90);



j0Tr <- subset(DF, Treatment == 1, select = "J0")
j7Tr <- subset(DF, Treatment == 1, select = "J7")
j90Tr <- subset(DF, Treatment == 1, select = "J90")

summary(j0Tr)
var(j0Tr)

summary(j7Tr)
var(j7Tr)

summary(j90Tr)
var(j90Tr)

wilcox.test(j0Tr$J0, j7Tr$J7, paired = TRUE)
wilcox.test(j90Tr$J90, j7Tr$J7, paired = TRUE)
wilcox.test(j0Tr$J0, j90Tr$J90, paired = TRUE)

invivoBwa <- read.csv("~/GitHub/codingTheMicrobiome/data/invivoBwa.csv")
#selectomicBwa <- read.csv("~/GitHub/codingTheMicrobiome/data/selectomicBwa.csv")
selectomicBwa <- read.csv("~/GitHub/codingTheMicrobiome/data/selectomicBwaTEST.csv")
# Do you winsorize the data?
invivoBwa["Normalised_Counts"] <- winsorize(invivoBwa$Normalised_Counts, q = 0.0135)
#selectomicBwa["Normalised_Counts"] <- <- winsorize(invivoBwa$Normalised_Counts)
qqnorm(invivoBwa$Normalised_Counts, main = "Q-Q plot\nIn Vivo")
qqnorm(selectomicBwa$Normalised_Counts, main = "Q-Q plot\nSelectomic")


head(selectomicBwa)

anae_J0_CefoxDF <- subset(selectomicBwa, Aero == "Anaerobic" & Antibiotic == "Cefoxitin" & Day == "J0")
anae_J0_NoneDF <- subset(selectomicBwa, Aero == "Anaerobic" & Antibiotic == "None" & Day == "J0")

summary(anae_J0_CefoxDF$Normalised_Counts)
var(anae_J0_CefoxDF$Normalised_Counts)

summary(anae_J0_NoneDF$Normalised_Counts)
var(anae_J0_NoneDF$Normalised_Counts)

wilcox.test(anae_J0_CefoxDF$Normalised_Counts, anae_J0_NoneDF$Normalised_Counts, paired = TRUE)

cohensD(anae_J0_CefoxDF$Normalised_Counts, anae_J0_NoneDF$Normalised_Counts)




#========================================================================================
# 22 aout 2017
# Power calclations
#========================================================================================
library(effsize)

DF <- read.csv("~/GitHub/codingTheMicrobiome/r/2017-01-10_extractedReadsRatio.csv")


DF["J90"] <- winsorize(DF$J90, q = 0.04); qqnorm(DF$J90);

j0Tr <- subset(DF, Treatment == 1, select = "J0"); j7Tr <- subset(DF, Treatment == 1, select = "J7"); j90Tr <- subset(DF, Treatment == 1, select = "J90")

mean(j0Tr$J0); median(j0Tr$J0)
mean(j7Tr$J7); median(j7Tr$J7)
mean(j90Tr$J90); median(j90Tr$J90)

#d0 <- subset(DFLM18, Time == "J0")$Ratio; d7 <- subset(DFLM18, Time == "J7")$Ratio; d90 <- subset(DFLM18, Time == "J90")$Ratio

d0 <- subset(DF, Treatment == "1")$J0
d7 <- subset(DF, Treatment == "1")$J7
d90 <- subset(DF, Treatment == "1")$J90

# from blog http://imaging.mrc-cbu.cam.ac.uk/statswiki/FAQ/nonpz
wtest <- wilcox.test(Ratio ~ Time, data = subset(DFLM18, Time != "J90")) #, paired = TRUE
qnorm(wtest$p.value)

cliff.delta(formula, data=list() ,conf.level=.95,
            use.unbiased=TRUE, use.normal=FALSE,
            return.dm=FALSE, ...)



cliff.delta(Ratio ~ Time0, data = subset(DFLM18, Time != "J90"))
cliff.delta(Ratio ~ Time0, data = subset(DFLM18, Time != "J7"))
cliff.delta(Ratio ~ Time0, data = subset(DFLM18, Time != "J0"))

cliff.delta(d7, d0)
cliff.delta(d90, d0)
cliff.delta(d90, d7)

cliff.delta(d0, d7)
cohen.d(d0, d7)


median(d0)
median(d7)


#### Making the supp materia qq-plot / winsorization 14 sept 2017

DF <- read.csv("~/GitHub/codingTheMicrobiome/r/2017-01-10_extractedReadsRatio.csv")

library(reshape)
bob <- subset(DF, Treatment == "1", select = c("J0", "J7", "J90"))
bob <- melt(bob)
par(mfrow=c(1,2))
qqnorm(bob$value)
qqnorm(winsorize(bob$value, q = 0.05))

max(winsorize(bob$value, q = 0.018))

max(bob$value)
subset(DF, J90 == 0.00474)

max(bob$value)




