#dev.off()
par(mfrow = c(1,1))
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

invivoBwa <- read.csv("~/GitHub/codingTheMicrobiome/data/invivoBwa.csv")
selectomicBwa <- read.csv("~/GitHub/codingTheMicrobiome/data/selectomicBwa.csv")
#selectomicBwa <- read.csv("~/GitHub/codingTheMicrobiome/data/selectomicBwaTEST.csv")
# Do you winsorize the data?
invivoBwa["Normalised_Counts"] <- winsorize(invivoBwa$Normalised_Counts, q = 0.0135)
#selectomicBwa["Normalised_Counts"] <- <- winsorize(invivoBwa$Normalised_Counts)
qqnorm(invivoBwa$Normalised_Counts, main = "Q-Q plot\nIn Vivo")
qqnorm(selectomicBwa$Normalised_Counts, main = "Q-Q plot\nSelectomic")

# Making usefull lists; which 18 patients were cefprozil group, which 6 were controls
cefPatients <- unique(subset(invivoBwa, select = c(Patient), Cefprozil == 1))
noCefPatients <- unique(subset(invivoBwa, select = c(Patient), Cefprozil == 0))
#subset(invivoBwa, is.element(Patient, noCefPatients$Patient))

###################### 0 Initial // 1 Air\nNone // 2 Air\nCefoxitin ######################
###################### 3 Anaerobic\nNone // 4 Anaerobic\nCefoxitin #######################
tmpInVivo <- subset(invivoBwa, Cefprozil == 1)
tmpInVivo$selectoNum <- "0"
tmpInVivo <- subset(tmpInVivo, select = c("Patient", "Day", "Normalised_Counts", "selectoNum"))


###################### 0 Initial // 1 Air\nNone // 2 Air\nCefoxitin ######################
###################### 3 Anaerobic\nNone // 4 Anaerobic\nCefoxitin #######################
# Keeping only the 18 patients that received the antibiotic
#selectomicBwa <- subset(selectomicBwa, is.element(Patient, cefPatients$Patient))
selectomicBwa$selectoNum <- "Err"

# To use with the "TEST" version of .CSV
# selectomicBwa$selectoNum[selectomicBwa$Antibiotic == "None" & selectomicBwa$Aero == "Air"] <- "1"
# selectomicBwa$selectoNum[selectomicBwa$Antibiotic == "Cefoxitin" & selectomicBwa$Aero == "Air"] <- "2"
# selectomicBwa$selectoNum[selectomicBwa$Antibiotic == "None" & selectomicBwa$Aero == "Anaerobic"] <- "3"
# selectomicBwa$selectoNum[selectomicBwa$Antibiotic == "Cefoxitin" & selectomicBwa$Aero == "Anaerobic"] <- "4"

selectomicBwa$selectoNum[selectomicBwa$Antibiotic == "MEB" & selectomicBwa$Aero == "CO2"] <- "1"
selectomicBwa$selectoNum[selectomicBwa$Antibiotic == "FOX" & selectomicBwa$Aero == "CO2"] <- "2"
selectomicBwa$selectoNum[selectomicBwa$Antibiotic == "MEB" & selectomicBwa$Aero == "ANA"] <- "3"
selectomicBwa$selectoNum[selectomicBwa$Antibiotic == "FOX" & selectomicBwa$Aero == "ANA"] <- "4"
tmpSelecto <- subset(selectomicBwa, select = c("Patient", "Day", "Normalised_Counts", "selectoNum"))
newPirate <- rbind(tmpInVivo, tmpSelecto)

## Plotting! 2 graphs, one before (D0), one after (D7)
par(mfrow = c(1,2))
# Samples from day 0
pirateplot(log10(Normalised_Counts) ~ selectoNum, main = "D0", ylim = c(-6, -0.5),
           data = subset(newPirate, Day == "J0"), point.cex = 1.5)

pirateplot(log10(Normalised_Counts) ~ selectoNum, main = "D7", 
           data = subset(newPirate, Day == "J7"), point.cex = 1.5)


#####################################################################################
## The panels graph with FC
#####################################################################################

par(mfrow=c(1,3))
# pirateplot(log10(Normalised_Counts) ~ selectoNum, 
#            data = subset(selectomicBwa, Day == "J0" & Aero == "ANA"),
#            point.cex = 2, pal = c('#E56AA2', '#FB8441') )

pirateplot(log10(Normalised_Counts) ~ selectoNum, 
           data = subset(selectomicBwa, Day == "J0" & Aero == "ANA"),
           point.cex = 2, pal = c('blue', 'blue') )



newFc <- spread(subset(selectomicBwa, Day == "J0" & Aero == "ANA", select = -c(ID, selectoNum)), Antibiotic, Normalised_Counts)
newFc['Fc'] <- log2(newFc$FOX/newFc$MEB)

before <- log10(subset(selectomicBwa, Day == "J0" & selectoNum == "3")$Normalised_Counts)
after <- log10(subset(selectomicBwa, Day == "J0" & selectoNum == "4")$Normalised_Counts)
z <- rep(c(0,1), rep(length(before),2))
plot(z, c(before, after),
     xaxt="n", ylab="Normalised Counts",
     xlab="", xlim=c(-0.5, 1.5), ylim = c(-4.5, -1), main = "Paired Conditions")
axis(side=1, at=c(0,1), c("Not Exposed", "Cefoxitin"))
grid (NA,NULL, lty = 1, col = "cornsilk2")
beforeUP <- log10(subset(newFc, Fc >= 0)$MEB)
beforeDown <- log10(subset(newFc, Fc < 0)$MEB)
afterUP <- log10(subset(newFc, Fc >= 0)$FOX)
afterDown <- log10(subset(newFc, Fc < 0)$FOX)
segments(rep(0, length(beforeUP)), beforeUP, rep(1, length(afterUP)), afterUP, col=4)
segments(rep(0, length(beforeDown)), beforeDown, rep(1, length(afterDown)), afterDown, col=2)


pirateplot((Fc) ~ Aero, data = newFc, ylab = "Fold Change", xlab = "", main = "Fold Change", avg.line.fun = median, 
           jitter.val = 0.02, point.cex = 2, pal = c('blue'))



