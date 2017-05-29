winsorize <- function(x, q=0.03) {
  extrema <- quantile(x, c(q, 1-q))  
  x[x<extrema[1]] <- extrema[1]
  x[x>extrema[2]] <- extrema[2]
  x
}

library(yarrr)
library(tidyr)
invivoBwa <- read.csv("~/GitHub/codingTheMicrobiome/data/invivoBwa.csv")
#selectomicBwa <- read.csv("~/GitHub/codingTheMicrobiome/data/selectomicBwa.csv")
selectomicBwa <- read.csv("~/GitHub/codingTheMicrobiome/data/selectomicBwaTEST.csv")
# Do you winsorize the data?
invivoBwa["Normalised_Counts"] <- lapply(selectomicBwa["Normalised_Counts"], winsorize)
#selectomicBwa["Normalised_Counts"] <- lapply(selectomicBwa["Normalised_Counts"], winsorize)
qqnorm(invivoBwa$Normalised_Counts, main = "Q-Q plot\nIn Vivo")
qqnorm(selectomicBwa$Normalised_Counts, main = "Q-Q plot\nSelectomic")

pirateplot(log(Normalised_Counts) ~ Day + Antibiotic + Aero, data = selectomicBwa, 
           sortx = "sequential", jitter.val = 0.01)

tmp <- subset(selectomicBwa, select = -c(ID) )
wideSelecBwa <- spread(tmp, Day, Normalised_Counts)
wideSelecBwa['Fc'] <- (wideSelecBwa['J7']-wideSelecBwa['J0'])/wideSelecBwa['J0']

# Compare Fc in aero condition **Air (O2 + CO2)**
aeroNoneFc <- subset(wideSelecBwa, Antibiotic == "None" & Aero == "Air (O2 + CO2)")$Fc
aeroFoxFc <- subset(wideSelecBwa, Antibiotic == "Cefoxitin" & Aero == "Air (O2 + CO2)")$Fc
wilcox.test(aeroNoneFc, aeroFoxFc, paired = TRUE)
t.test(aeroNoneFc, aeroFoxFc, paired = TRUE)

# Compare Fc in aero condition **Anaerobic**
anaNoneFc <- subset(wideSelecBwa, Antibiotic == "None" & Aero == "Anaerobic")$Fc
anaFoxFc <- subset(wideSelecBwa, Antibiotic == "Cefoxitin" & Aero == "Anaerobic")$Fc
wilcox.test(anaNoneFc, anaFoxFc, paired = TRUE)
t.test(anaNoneFc, anaFoxFc, paired = TRUE)

J0 <- subset(wideSelecBwa, Antibiotic == "None" & Aero == "Anaerobic")['J0']
J7 <- subset(wideSelecBwa, Antibiotic == "None" & Aero == "Anaerobic")['J7']
J0 <- subset(wideSelecBwa, Antibiotic == "None" & Aero == "Anaerobic")$J0
J7 <- subset(wideSelecBwa, Antibiotic == "None" & Aero == "Anaerobic")$J7








