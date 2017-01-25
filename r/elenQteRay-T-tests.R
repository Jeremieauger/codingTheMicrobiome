winsorize <- function(x, q=0.05) {
  extrema <- quantile(x, c(q, 1-q))  
  x[x<extrema[1]] <- extrema[1]
  x[x>extrema[2]] <- extrema[2]
  x
}

#elenQte <- read_csv("C:/Users/augerjer/Desktop/travail/elenQte.csv")
elenQte <- read.csv("~/GitHub/codingTheMicrobiome/r/elenQte.csv")

stacked <- data.frame(elenQte$ID, elenQte$J0, elenQte$Treatment)
stacked <- rbind(stacked, data.frame(elenQte$ID, elenQte$J7, elenQte$Treatment), setNames(c("1","2","3")))

dfOne <- data.frame(elenQte$ID, elenQte$J0, elenQte$Treatment, rep("0",length(elenQte$ID)))
dfTwo <- data.frame(elenQte$ID, elenQte$J7, elenQte$Treatment, rep("1",length(elenQte$ID)))
dfThree <- data.frame(elenQte$ID, elenQte$J90, elenQte$Treatment, rep("2",length(elenQte$ID)))

stackedDF <- as.data.frame(mapply(c, dfOne, dfTwo, dfThree))
colnames(stackedDF) <- c('Patient0', 'Ratio', 'Treatment', 'Time0')
stackedDF <- arrange(stackedDF, desc(Treatment), Patient0)

J0 <- stackedDF[stackedDF$Time0 == 0, ][c('Patient', 'Treatment', 'Age', 'Sex', 'Ratio')]





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

t.test(J0,J7,alternative="greater", paired=TRUE)

t.test(J0,J7, paired=TRUE)

boxplot(controls$J0, controls$J7, controls$J90, outline = FALSE, main="Controls", names=c("J0", "J7", "J90"))
boxplot(exposed$J0, exposed$J7, exposed$J90, outline = FALSE, main="Exposed", names=c("J0", "J7", "J90"))


boxplot(controls$J0, controls$J7, controls$J90, exposed$J0, exposed$J7, exposed$J90, 
        outline = FALSE, main="Ray", names=c("C0", "C7", "C90","E0", "E7", "E90"))

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


ElenQte <- rbind(elenQte$J0, elenQte$J7, elenQte$J90)
hist(ElenQte, breaks=100)
hist(winsorize(ElenQte), breaks=100)



