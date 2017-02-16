winsorize <- function(x, q=0.05) {
  extrema <- quantile(x, c(q, 1-q))  
  x[x<extrema[1]] <- extrema[1]
  x[x>extrema[2]] <- extrema[2]
  x
}

#elenQte <- read_csv("C:/Users/augerjer/Desktop/travail/elenQte.csv")
elenQte <- read.csv("~/GitHub/codingTheMicrobiome/r/elenQte_FromRay.csv")

#library(reshape)
stackedDF <- melt(elenQte, id=c("ID", "Treatment"))
colnames(stackedDF) <- c('Patient0', 'Treatment', 'Time', 'Ratio')


dfOne <- data.frame(elenQte$ID, elenQte$J0, elenQte$Treatment, rep("0",length(elenQte$ID)))
colnames(dfOne) <- c('ID', 'Ratio', 'Treatment', 'Time0')
dfTwo <- data.frame(elenQte$ID, elenQte$J7, elenQte$Treatment, rep("1",length(elenQte$ID)))
colnames(dfTwo) <- c('ID', 'Ratio', 'Treatment', 'Time0')
dfThree <- data.frame(elenQte$ID, elenQte$J90, elenQte$Treatment, rep("2",length(elenQte$ID)))
colnames(dfThree) <- c('ID', 'Ratio', 'Treatment', 'Time0')

#stackedDF <- as.data.frame(mapply(c, dfOne, dfTwo, dfThree))
stackedDF <- rbind(dfOne, dfTwo, dfThree)
colnames(stackedDF) <- c('Patient0', 'Ratio', 'Treatment', 'Time0')
#stackedDF <- arrange(stackedDF, desc(Treatment), Patient0)

# One line to generate all local objects
controls = stackedDF[stackedDF$Treatment == 0, ]; exposed = stackedDF[stackedDF$Treatment == 1, ]; E0 = stackedDF[stackedDF$Treatment == 1 & stackedDF$Time0 == 0, ]; E7 = stackedDF[stackedDF$Treatment == 1 & stackedDF$Time0 == 1, ]; E90 = stackedDF[stackedDF$Treatment == 1 & stackedDF$Time0 == 2, ]; C0 = stackedDF[stackedDF$Treatment == 0 & stackedDF$Time0 == 0, ]; C7 = stackedDF[stackedDF$Treatment == 0 & stackedDF$Time0 == 1, ]; C90 = stackedDF[stackedDF$Treatment == 0 & stackedDF$Time0 == 2, ]; J0 = stackedDF[stackedDF$Time0 == 0, ]; J7 = stackedDF[stackedDF$Time0 == 1, ]; J90 = stackedDF[stackedDF$Time0 == 2, ]; 

controls = stackedDF[stackedDF$Treatment == 0, ]
exposed = stackedDF[stackedDF$Treatment == 1, ]

E0 = stackedDF[stackedDF$Treatment == 1 & stackedDF$Time0 == 0, ]
E7 = stackedDF[stackedDF$Treatment == 1 & stackedDF$Time0 == 1, ]
E90 = stackedDF[stackedDF$Treatment == 1 & stackedDF$Time0 == 2, ]

C0 = stackedDF[stackedDF$Treatment == 0 & stackedDF$Time0 == 0, ]
C7 = stackedDF[stackedDF$Treatment == 0 & stackedDF$Time0 == 1, ]
C90 = stackedDF[stackedDF$Treatment == 0 & stackedDF$Time0 == 2, ]

J0 = stackedDF[stackedDF$Time0 == 0, ]
J7 = stackedDF[stackedDF$Time0 == 1, ]
J90 = stackedDF[stackedDF$Time0 == 2, ]


hist(stackedDF$Ratio, breaks=100)
plot(stackedDF$Ratio)

var(stackedDF$Ratio)/mean(stackedDF$Ratio)

boxplot(C0$Ratio, C7$Ratio, C90$Ratio, E0$Ratio, E7$Ratio, E90$Ratio, 
        outline = FALSE, main="Ray", names=c("C0", "C7", "C90","E0", "E7", "E90"))

beanplot(C0$Ratio, C7$Ratio, C90$Ratio, E0$Ratio, E7$Ratio, E90$Ratio,
         log = "y", main="Ray", names=c("C0", "C7", "C90","E0", "E7", "E90"))
beanplot(C0$Ratio, C7$Ratio, C90$Ratio, E0$Ratio, E7$Ratio, E90$Ratio,
         log = "", main="Ray", names=c("C0", "C7", "C90","E0", "E7", "E90"))








#==========================================================================================
#
# Old version below
#
#==========================================================================================

allRayRatio <- c(elenQte$J0, elenQte$J7, elenQte$J90)
plot(allRayRatio)
plot(winsorize(allRayRatio))

var(allRayRatio)/mean(allRayRatio)

controls <- elenQte[elenQte$Treatment==0, ]
exposed <- elenQte[elenQte$Treatment==1, ]

E0 <- exposed$J0
E7 <- exposed$J7
E90 <- exposed$J90

C0 <- controls$J0
C7 <- controls$J7
C90 <- controls$J90


boxplot(controls$J0, controls$J7, controls$J90, outline = FALSE, main="Controls", names=c("J0", "J7", "J90"))
boxplot(exposed$J0, exposed$J7, exposed$J90, outline = FALSE, main="Exposed", names=c("J0", "J7", "J90"))


boxplot(controls$J0, controls$J7, controls$J90, exposed$J0, exposed$J7, exposed$J90, 
        outline = FALSE, main="Ray", names=c("C0", "C7", "C90","E0", "E7", "E90"))

beanplot(controls$J0, controls$J7, controls$J90, exposed$J0, exposed$J7, exposed$J90, 
         main="Ray", names=c("C0", "C7", "C90","E0", "E7", "E90"))




Kruskal--Controls--Greater
kruskal.test(C0,C7, paired=TRUE)
kruskal.test(C7,C90, paired=TRUE)
kruskal.test(C0,C90, paired=TRUE)

Kruskal--Exposed--Greater
kruskal.test(E0,E7, paired=TRUE)
kruskal.test(E7,E90, paired=TRUE)
kruskal.test(E0,E90, paired=TRUE)

Wilcox--Controls
wilcox.test(C0,C7, paired=TRUE)
wilcox.test(C7,C90, paired=TRUE)
wilcox.test(C0,C90, paired=TRUE)

Wilcox--Exposed
wilcox.test(E0,E7, paired=TRUE)
wilcox.test(E7,E90, paired=TRUE)
wilcox.test(E0,E90, paired=TRUE)


wilcox.test((J7-J0) ~ Treatment, paird=TRUE, data=elenQte)

wilcox.test(J0 ~ Treatment, data=elenQte)
wilcox.test(J7 ~ Treatment, data=elenQte)
wilcox.test(J90 ~ Treatment, data=elenQte)




ElenQte <- rbind(elenQte$J0, elenQte$J7, elenQte$J90)
hist(ElenQte, breaks=100)
hist(winsorize(ElenQte), breaks=100)



