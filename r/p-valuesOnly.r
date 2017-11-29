##########################################################################################
## in vivo
##########################################################################################

### For the p-values
DFLM <- read.csv("~/GitHub/codingTheMicrobiome/r/bwaForLm.csv")
DFLM["Ratio"] <- lapply(DFLM["Ratio"], winsorize)

# J0 - J7
wilcox.test(Ratio ~ Time, data = subset(DFLM, Time != "J90" & Treatment == 1), paired = TRUE)
# J7 - J90
wilcox.test(Ratio ~ Time, data = subset(DFLM, Time != "J0" & Treatment == 1), paired = TRUE)
# J0 - J90
wilcox.test(Ratio ~ Time, data = subset(DFLM, Time != "J7" & Treatment == 1), paired = TRUE)



# Confirmation des formules...
# j0DF <- subset(DFLM18, Time == "J0")
# j7DF <- subset(DFLM18, Time == "J7")
# j90DF <- subset(DFLM18, Time == "J90")
# wilcox.test(j0DF$Ratio, j7DF$Ratio, paired = TRUE)

##########################################################################################
## Selectomic
##########################################################################################

selectomicBwa <- read.csv("~/GitHub/codingTheMicrobiome/data/selectomicBwaTEST.csv")
tmp <- subset(selectomicBwa, Day == "J0" & Aero == "Anaerobic") 
wilcox.test(Normalised_Counts ~ Antibiotic, data = tmp, paired = TRUE)
