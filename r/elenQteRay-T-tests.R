elenQte_FromRay

elenQte_FromRay <- read_csv("C:/Users/augerjer/Desktop/travail/elenQte_FromRay.csv")

controls <- elenQte_FromRay[ which(elenQte_FromRay$Traitement=='0'), ]
exposed <- elenQte_FromRay[ which(elenQte_FromRay$Traitement=='1'), ]

J0 <- exposed$J0
J7 <- exposed$J7
J90 <- exposed$J90

J0 <- controls$J0
J7 <- controls$J7
J90 <- controls$J90

t.test(J0,J7,alternative="greater", paired=TRUE)

t.test(J0,J7, paired=TRUE)

boxplot(controls$J0, controls$J7, controls$J90, outline = FALSE, main="Controls", names=c("J0", "J7", "J90"))
boxplot(exposed$J0, exposed$J7, exposed$J90, outline = FALSE, main="Exposed", names=c("J0", "J7", "J90"))


boxplot(controls$J0, controls$J7, controls$J90, exposed$J0, exposed$J7, exposed$J90, outline = FALSE, main="BWA", names=c("C0", "C7", "C90","E0", "E7", "E90"))



kruskal.test(J0,J7,alternative="greater", paired=TRUE)
kruskal.test(J7,J90,alternative="greater", paired=TRUE)
kruskal.test(J0,J90,alternative="greater", paired=TRUE)


kruskal.test(J0,J7,alternative="less", paired=TRUE)
kruskal.test(J7,J90,alternative="less", paired=TRUE)
kruskal.test(J0,J90,alternative="less", paired=TRUE)


wilcox.test(J0,J7,alternative="greater", paired=TRUE)
wilcox.test(J7,J90,alternative="greater", paired=TRUE)
wilcox.test(J0,J90,alternative="greater", paired=TRUE)


wilcox.test(J0,J7,alternative="less", paired=TRUE)
wilcox.test(J7,J90,alternative="less", paired=TRUE)
wilcox.test(J0,J90,alternative="less", paired=TRUE)












