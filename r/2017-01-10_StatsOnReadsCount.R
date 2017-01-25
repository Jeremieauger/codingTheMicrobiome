DF <- read.csv("/Users/jay/GitHub/codingTheMicrobiome/r/2017-01-10_extractedReadsRatio.csv")
DF <- read.csv("~/GitHub/codingTheMicrobiome/r/2017-01-10_extractedReadsRatio.csv")
DFLM <- read.csv("~/GitHub/codingTheMicrobiome/r/bwaForLm.csv")

model <- lm(WzRatio ~ Treatment + Time0 + Treatment*Time0 + Age + Sex, data=DFLM)
summary(model)
plot(model)

max(DFLM$TotalReads)

J0DFLM <- DFLM[DFLM$Time0 == 0, ]
J7DFLM <- DFLM[DFLM$Time0 == 1, ]
J0J7DFLM <- DFLM[DFLM$Time0 != 2, ]

var(DFLM$Ratio)/mean(DFLM$Ratio)
plot(DFLM$Ratio)
plot(winsorize(DFLM$Ratio))


WzDF <- DFLM
max(WzDF$Ratio)
WzDF <- cbind(DFLM[1:7], lapply(DFLM[8], winsorize), DFLM[9:10])
max(WzDF$Ratio)
WzDF

J0 <- WzDF[WzDF$Time0 == 0, ][c('Patient', 'Treatment', 'Age', 'Sex', 'Ratio')]
J7 <- WzDF[WzDF$Time0 == 1, ][c('Patient', 'Treatment', 'Age', 'Sex', 'Ratio')]
J90 <- WzDF[WzDF$Time0 == 2, ][c('Patient', 'Treatment', 'Age', 'Sex', 'Ratio')]

require(plyr)
colDF <- join_all(list(J0, J7, J90), by = c('Patient', 'Treatment', 'Age', 'Sex'))
colnames(colDF) <- c('Patient', 'Treatment', 'Age', 'Sex', 'J0', 'J7', 'J90')
colDF <- arrange(colDF, desc(Treatment), Patient)
colDF

model <- lm((J7-J0) ~ Treatment + Age + Sex, data=colDF)
summary(model)

beanplot
install.packages('beanplot')
library(beanplot)

summary(DFLM$Ratio)
IQR(winsorize(DFLM$Ratio))


J0J7DFLM <- WzDF[WzDF$Time0 != 2, ]

hist(DFLM$Ratio, breaks=100)
hist(winsorize(DFLM$Ratio), breaks=100)
max(winsorize(DFLM$Ratio))
model <- lm(Ratio ~ Treatment + Time + Age + Sex, data=J0J7DFLM)
summary(model)
plot(model)


install.packages('e1071')
library(e1071)
b_model <- naiveBayes(winsorize(Ratio) ~ Treatment + Time0 + Age + Sex, data=J0J7DFLM)
b_model <- naiveBayes(Ratio ~ Treatment + Time0 + Age + Sex, data=J0J7DFLM)
b_model
summary(b_model)
str(b_model)


hist(J0J7DFLM$Ratio, breaks=20)

hist(WzRatio, breaks=20)
hist(DFLM$Ratio, breaks=20)

modelII <- lm(WzMappedReads ~ Treatment + TotalReads + Patient0 - Age - Sex, data=DFLM)
summary(modelII)
plot(modelII)

J0DFLM <- DFLM[DFLM$Time0 == 0, ]
J7DFLM <- DFLM[DFLM$Time0 == 1, ]

wilcox.test((J7DFLM$Ratio - J0DFLM$Ratio) ~ Treatment, paird=TRUE, alternative="greater", data=DFLM)


WzMappedReads <- winsorize(DFLM$MappedReads)

WzRatio <- winsorize(DFLM$Ratio)
x <- DFLM$Ratio

winsorize <- function(x, q=0.05) {
  extrema <- quantile(x, c(q, 1-q))  
  x[x<extrema[1]] <- extrema[1]
  x[x>extrema[2]] <- extrema[2]
  x
}

controls <- DF[DF$Treatment == 0, ]
exposed <- DF[DF$Treatment == 1, ]

E0 <- exposed$J0
E7 <- exposed$J7
E90 <- exposed$J90

C0 <- controls$J0
C7 <- controls$J7
C90 <- controls$J90

boxplot(J0, J7, J90, outline=FALSE)
boxplot(DF$J0, DF$J7, DF$J90, outline=FALSE)
boxplot(log(DF$J0), log(DF$J7), log(DF$J90), outline=FALSE)

boxplot(DF$J0, DF$J7, DF$J90, outline=FALSE)

boxplot(controls$J0, controls$J7, controls$J90, exposed$J0, exposed$J7, exposed$J90, 
        outline = FALSE, main="BWA", names=c("C0", "C7", "C90","E0", "E7", "E90"))

beanplot(controls$J0, controls$J7, controls$J90, exposed$J0, exposed$J7, exposed$J90, outline = FALSE, main="BWA", names=c("C0", "C7", "C90","E0", "E7", "E90"))


contingencyTable <- read.csv("~/GitHub/codingTheMicrobiome/r/contingencyTable.csv")
contingencyTable$X <- NULL
library("gplots")
chisq.test(contingencyTableLog)

contingencyTableXMille <- contingencyTable*1000000 
fisher.test(contingencyTableXMillion)
contingencyTable


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

wilcox.test(J0 ~ Treatment, data=DF)
wilcox.test(J7 ~ Treatment, data=DF)
wilcox.test(J90 ~ Treatment, data=DF)




