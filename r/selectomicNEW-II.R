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

invivoBwa <- read.csv("~/GitHub/codingTheMicrobiome/data/invivoBwa.csv")
#selectomicBwa <- read.csv("~/GitHub/codingTheMicrobiome/data/selectomicBwa.csv")
selectomicBwa <- read.csv("~/GitHub/codingTheMicrobiome/data/selectomicBwaTEST.csv")
# Do you winsorize the data?
invivoBwa["Normalised_Counts"] <- winsorize(invivoBwa$Normalised_Counts, q = 0.0135)
#selectomicBwa["Normalised_Counts"] <- <- winsorize(invivoBwa$Normalised_Counts)
qqnorm(invivoBwa$Normalised_Counts, main = "Q-Q plot\nIn Vivo")
qqnorm(selectomicBwa$Normalised_Counts, main = "Q-Q plot\nSelectomic")


### Making the rows with NO CEFPROZIL
## Making useful lists
cefPatients <- unique(subset(invivoBwa, select = c(Patient), Cefprozil == 1))
noCefPatients <- unique(subset(invivoBwa, select = c(Patient), Cefprozil == 0))
#subset(invivoBwa, is.element(Patient, noCefPatients$Patient))

## Selecting the patients from inVivo experiment 
# Selecting patients that did NOT recieve Cefprozil 
initialCond <- subset(invivoBwa, select = c('Patient', 'Normalised_Counts'), Day == "J0")
# Adding the patients from J7 that did not recieve Cefprozil
tmp <- subset(invivoBwa, select = c('Patient', 'Normalised_Counts'), Day == "J7" & Cefprozil == 0)
initialCond <- rbind(initialCond, tmp)
initialCond['Cefprozil'] <- rep("No_Exp", nrow(initialCond))

# Selecting patients that recived Cefprozil and adding them with "Cefprozil" column
tmp <- subset(invivoBwa, select = c('Patient', 'Normalised_Counts'), Day == "J7" & Cefprozil == 1)
tmp['Cefprozil'] <- rep("Cefprozil", nrow(tmp))
initialCond <- rbind(initialCond, tmp)
# initialCond['Selectomic'] <- rep("Initial", nrow(initialCond))
# initialCond['SelectomicNumeric'] <- rep("0\nInitial", nrow(initialCond))
initialCond['Antibiotic'] <- rep("0\nInitial", nrow(initialCond))
initialCond['Aero'] <- rep("0:Initial", nrow(initialCond))



## Selecting the patients from Selectomic experiment
#selectomicBwa['Selectomic'] <- paste(selectomicBwa$Aero, selectomicBwa$Antibiotic, sep="\n")
# 0 Initial // 1 Air\nNone // 2 Air\nCefoxitin
# 3 Anaerobic\nNone // 4 Anaerobic\nCefoxitin
#selectomicBwa['SelectomicNumeric'] <- rep("Err", nrow(selectomicBwa))
# selectomicBwa[selectomicBwa$Selectomic == "Air\nNone", ][, "SelectomicNumeric"] <- "1\nAir\nNone"
# selectomicBwa[selectomicBwa$Selectomic == "Air\nCefoxitin", ][, "SelectomicNumeric"] <- "2\nAir\nCefoxitin"
# selectomicBwa[selectomicBwa$Selectomic == "Anaerobic\nNone", ][, "SelectomicNumeric"] <- "3\nAnaerobic\nNone"
# selectomicBwa[selectomicBwa$Selectomic == "Anaerobic\nCefoxitin", ][, "SelectomicNumeric"] <- "4\nAnaerobic\nCefoxitin"

# Marking the cefprozil inVivo No_exposure (to cefprozil, in clinic)
selectoNo_Exp <- subset(selectomicBwa, select = c('Patient', 'Normalised_Counts', 'Antibiotic', 'Aero'), Day == "J0")
# Adding the patients from J7 that did not recieve Cefprozil
tmp <- subset(selectomicBwa, select = c('Patient', 'Normalised_Counts', 'Antibiotic', 'Aero'), Day == "J7" & is.element(Patient, noCefPatients$Patient))
selectoNo_Exp <- rbind(selectoNo_Exp, tmp)
selectoNo_Exp['Cefprozil'] <- rep("No_Exp", nrow(selectoNo_Exp))

# Marking the cefprozil inVivo Exposed (to cefprozil, in clinic)
selectoExposed <- subset(selectomicBwa, select = c('Patient', 'Normalised_Counts', 'Antibiotic', 'Aero'), Day == "J7" & is.element(Patient, cefPatients$Patient))
selectoExposed['Cefprozil'] <- rep("Cefprozil", nrow(selectoExposed))

selectoPirate <- rbind(initialCond, selectoNo_Exp, selectoExposed)

selectoPirate$Antibiotic[selectoPirate$Antibiotic == "None"] <- "1\nNone"
selectoPirate$Antibiotic[selectoPirate$Antibiotic == "Cefoxitin"] <- "2\nCefoxitin"
selectoPirate$Cefprozil[selectoPirate$Cefprozil == "No_Exp"] <- "0:No_Exp"
selectoPirate$Cefprozil[selectoPirate$Cefprozil == "Cefprozil"] <- "1:Cefprozil"
selectoPirate$Aero[selectoPirate$Aero == "Air"] <- "1:Air"
selectoPirate$Aero[selectoPirate$Aero == "Anaerobic"] <- "2:Anae"


main <- paste0("In Vitro : Antibiotic\nn = ", nrow(subset(selectoPirate, grepl('None', Antibiotic))))
pirateplot(log(Normalised_Counts) ~ Antibiotic, main = main,
           data = selectoPirate)

main <- paste0("In Vitro : Air Condition\nn=", nrow(subset(selectoPirate, grepl('Air', Aero))))
pirateplot(log(Normalised_Counts) ~ Aero, main = main,
           data = selectoPirate)

par(mfrow = c(1,1));
pirateplot(log(Normalised_Counts) ~ Aero + Cefprozil, 
           data = selectoPirate)

par(mfrow = c(1,2));
pirateplot(log(Normalised_Counts) ~ SelectomicNumeric, main = "No Exposure", ylim = c(-14, -2),
           data = subset(selectoPirate, Cefprozil == "No_Exp"), xlab = "Culture Condition",
           jitter.val = 0.02, point.cex = 1.2)

pirateplot(log(Normalised_Counts) ~ SelectomicNumeric, main = "Cefprozil", ylim = c(-14, -2),
           data = subset(selectoPirate, Cefprozil == "Cefprozil"), xlab = "Culture Condition",
           jitter.val = 0.02, point.cex = 1.2)

par(mfrow = c(1,1));
pirateplot(log(Normalised_Counts) ~ SelectomicNumeric, main = "Pooled", ylim = c(-14, -2),
           data = selectoPirate, xlab = "Culture Condition",
           jitter.val = 0.02, point.cex = 1.2)




################################################################################
# End of plotting section
################################################################################

noneDF <- subset(selectoPirate, grepl("None", Selectomic), select = c("Patient", "Normalised_Counts"))
rownames(noneDF) <- NULL
foxDF <- subset(selectoPirate, grepl("Cefoxitin", Selectomic), select = c("Patient", "Normalised_Counts"))
rownames(foxDF) <- NULL
colnames(foxDF) <- c("Patient", "Normalised_Counts_Fox")
fcDF <- merge(noneDF, foxDF, by = "Patient")

fcDF <- subset(selectoPirate, grepl("None", Selectomic), select = c("Patient", "Normalised_Counts"))
colnames(fcDF) <- c("Patient", "Counts_N0_Exp")
fcDF['Counts_Cefox'] <- subset(selectoPirate, grepl("Cefoxitin", Selectomic), select = c("Normalised_Counts"))
fcDF['Fc'] <- (fcDF$Counts_Cefox-fcDF$Counts_N0_Exp)/fcDF$Counts_N0_Exp
#fcDF['Fc'] <- (fcDF$Counts_N0_Exp-fcDF$Counts_Cefox)/fcDF$Counts_Cefox
fcDF['Zeros'] <- rep(0, length(fcDF)) 

main = paste0("Selectomic; with / without cefoxitin\n n = ", nrow(fcDF))
pirateplot(formula = winsorize(Fc) ~ Zeros, data = fcDF, hdi.iter = 0, 
           ylab = "Fold Change", main = main,
           avg.line.fun = median, point.cex = 1.5)

wilcox.test(fcDF$Fc, fcDF$Zeros)
median(fcDF$Fc)

wilcox.test(fcDF$Counts_N0_Exp, fcDF$Counts_Cefox, paired = TRUE)
t.test(fcDF$Counts_N0_Exp, fcDF$Counts_Cefox, paired = TRUE)
nrow(fcDF)
#spread(selectoPirate, Selectomic, Normalised_Counts)


par(mfrow=c(1,3))
tmp <- subset(fcDF, select = c("Counts_N0_Exp", "Counts_Cefox"))
colnames(tmp) <- c("Not Exposed", "Cefoxitin")
tmp <- melt(tmp)
pirateplot(log(value) ~ variable, data = tmp, ylab = "Normalised Counts", xlab = "", 
           main = "Normalised Counts", jitter.val = 0.02, point.cex = 2, pal = "blue")

lbefore <- log(fcDF$Counts_N0_Exp)
after <- log(fcDF$Counts_Cefox)
z <- rep(c(0,1), rep(length(before),2))
plot(z, c(before, after),
     xaxt="n", ylab="Normalised Counts",
     xlab="", xlim=c(-0.5, 1.5), main = "Paired Conditions")
axis(side=1, at=c(0,1), c("Not Exposed", "Cefoxitin"))
beforeUP <- log(subset(fcDF, Fc >= 0)$Counts_N0_Exp)
beforeDown <- log(subset(fcDF, Fc < 0)$Counts_N0_Exp)
afterUP <- log(subset(fcDF, Fc >= 0)$Counts_Cefox)
afterDown <- log(subset(fcDF, Fc < 0)$Counts_Cefox)
segments(rep(0, length(beforeUP)), beforeUP, rep(1, length(afterUP)), afterUP, col=4)
segments(rep(0, length(beforeDown)), beforeDown, rep(1, length(afterDown)), afterDown, col=2)
#segments(rep(0,length(before)), before, rep(1,length(after)), after, col=1)

pirateplot(winsorize(Fc) ~ Zeros, data = fcDF, ylab = "Fold Change", xlab = "", main = "Fold Change",
           hdi.iter = 0, avg.line.fun = median, jitter.val = 0.02, point.cex = 2)



