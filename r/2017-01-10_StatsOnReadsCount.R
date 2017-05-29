# Local function to deal with outliers
winsorize <- function(x, q) {
  if(missing(q)) { q = 0.05 }
  extrema <- quantile(x, c(q, 1-q))
  x[x<extrema[1]] <- extrema[1]
  x[x>extrema[2]] <- extrema[2]
  x
}
DF <- read.csv("/Users/jay/GitHub/codingTheMicrobiome/r/2017-01-10_extractedReadsRatio.csv")
DF <- read.csv("~/GitHub/codingTheMicrobiome/r/2017-01-10_extractedReadsRatio.csv")
DFLM <- read.csv("~/GitHub/codingTheMicrobiome/r/bwaForLm.csv")

### Tests 21 fév 2017

J0 <- DFLM[DFLM$Time0 == 0, ]
J0 <- DFLM[DFLM$Time0 == 1, ]


E0 <- DFLM[DFLM$Time0 == 0 & DFLM$Treatment == 1, ]
E7 <- DFLM[DFLM$Time0 == 1 & DFLM$Treatment == 1, ]

plot(DFLM$Ratio)

var(E0$TotalReads)
var(E7$TotalReads)

dev.off()
par(mfrow=c(1,2))
plot(E0$TotalReads, E0$MappedReads, main = "E0")
plot(E7$TotalReads, E7$MappedReads, main = "E7")

bob <- lm(E0$MappedReads ~ E0$TotalReads)
lm(E0$MappedReads ~ E0$TotalReads)
lm(E7$MappedReads ~ E7$TotalReads)

plot(E0$MappedReads ~ E0$TotalReads)

#============================



model <- lm(Ratio ~ Treatment + Time0 + Age + Sex, data=DFLM)
model <- lm(Ratio ~ Treatment + Time0 + Treatment*Time0 + Age + Sex, data=DFLM)
summary(model)
plot(model) 

read.DIF("clipboard")

J0DFLM <- DFLM[DFLM$Time0 == 0, ]
J7DFLM <- DFLM[DFLM$Time0 == 1, ]
J0J7DFLM <- DFLM[DFLM$Time0 != 2, ]

var(DFLM$Ratio)/mean(DFLM$Ratio)
plot(DFLM$Ratio)
plot(winsorize(DFLM$Ratio))


WzDF <- DFLM
WzDF <- cbind(DFLM[1:7], lapply(DFLM[8], winsorize), DFLM[9:10])



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

J0DFLM <- DFLM[DFLM$Time0 == 0, ]
J7DFLM <- DFLM[DFLM$Time0 == 1, ]

wilcox.test((J7DFLM$Ratio - J0DFLM$Ratio) ~ Treatment, paird=TRUE, alternative="greater", data=DFLM)


WzMappedReads <- winsorize(DFLM$MappedReads)

WzRatio <- winsorize(DFLM$Ratio)
x <- DFLM$Ratio

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

beanplot(controls$J0, controls$J7, controls$J90, exposed$J0, exposed$J7, exposed$J90, 
         main="BWA", names=c("C0", "C7", "C90","E0", "E7", "E90"))

contingencyTable <- read.csv("~/GitHub/codingTheMicrobiome/r/contingencyTable.csv")
contingencyTable$X <- NULL
library("gplots")
chisq.test(contingencyTableLog)

contingencyTableXMille <- contingencyTable*1000000 
fisher.test(contingencyTableXMillion)
contingencyTable


#Kruskal--Controls--Greater
kruskal.test(C0,C7, paired=TRUE)
kruskal.test(C7,C90, paired=TRUE)
kruskal.test(C0,C90, paired=TRUE)

#Kruskal--Exposed--Greater
kruskal.test(E0,E7, paired=TRUE)
kruskal.test(E7,E90, paired=TRUE)
kruskal.test(E0,E90, paired=TRUE)

#Wilcox--Controls
wilcox.test(C0,C7, paired=TRUE)
wilcox.test(C7,C90, paired=TRUE)
wilcox.test(C0,C90, paired=TRUE)

#Wilcox--Exposed
wilcox.test(E0,E7, paired=TRUE)
wilcox.test(E7,E90, paired=TRUE)
wilcox.test(E0,E90, paired=TRUE)

wilcox.test(J0 ~ Treatment, data=DF)
wilcox.test(J7 ~ Treatment, data=DF)
wilcox.test(J90 ~ Treatment, data=DF)

#==============================================================================================
#
# New section, making like RSEM stat's
#
#==============================================================================================

DFLM <- read.csv("~/GitHub/codingTheMicrobiome/r/bwaForLm.csv")

# Do you winsorize the data?
DFLM["Ratio"] <- lapply(DFLM["Ratio"], winsorize)
DFLM["MappedReads"] <- lapply(DFLM["MappedReads"], winsorize)
# Making the wide version of the DF
tmp <- subset(DFLM, select = -c(Patient, Time, MappedReads, TotalReads) )
wideDF <- spread(tmp, Time0, Ratio)
colnames(wideDF) <- c('Patient0', 'Treatment', 'Sex', 'Age', 'J0', 'J7', 'J90')

# One line to make all objects specific to expected_count
controls = DFLM[DFLM$Treatment == 0, ]; exposed = DFLM[DFLM$Treatment == 1, ]; E0 = DFLM[DFLM$Treatment == 1 & DFLM$Time0 == 0, ]; E7 = DFLM[DFLM$Treatment == 1 & DFLM$Time0 == 1, ]; E90 = DFLM[DFLM$Treatment == 1 & DFLM$Time0 == 2, ]; C0 = DFLM[DFLM$Treatment == 0 & DFLM$Time0 == 0, ]; C7 = DFLM[DFLM$Treatment == 0 & DFLM$Time0 == 1, ]; C90 = DFLM[DFLM$Treatment == 0 & DFLM$Time0 == 2, ]; J0 = DFLM[DFLM$Time0 == 0, ]; J7 = DFLM[DFLM$Time0 == 1, ]; J90 = DFLM[DFLM$Time0 == 2, ]

controls = DFLM[DFLM$Treatment == 0, ]
exposed = DFLM[DFLM$Treatment == 1, ]

E0 = DFLM[DFLM$Treatment == 1 & DFLM$Time0 == 0, ]
E7 = DFLM[DFLM$Treatment == 1 & DFLM$Time0 == 1, ]
E90 = DFLM[DFLM$Treatment == 1 & DFLM$Time0 == 2, ]

C0 = DFLM[DFLM$Treatment == 0 & DFLM$Time0 == 0, ]
C7 = DFLM[DFLM$Treatment == 0 & DFLM$Time0 == 1, ]
C90 = DFLM[DFLM$Treatment == 0 & DFLM$Time0 == 2, ]

J0 = DFLM[DFLM$Time0 == 0, ]
J7 = DFLM[DFLM$Time0 == 1, ]
J90 = DFLM[DFLM$Time0 == 2, ]

# Graphs and analysis

hist(DFLM$Ratio, breaks=100)
plot(DFLM$Ratio)

var(DFLM$Ratio)/mean(DFLM$Ratio)

boxplot(C0$Ratio, C7$Ratio, C90$Ratio, E0$Ratio, E7$Ratio, E90$Ratio, 
        outline = FALSE, main="BWA", names=c("C0", "C7", "C90","E0", "E7", "E90"))

beanplot(C0$Ratio, C7$Ratio, C90$Ratio, E0$Ratio, E7$Ratio, E90$Ratio,
         log = "y", main="BWA", names=c("C0", "C7", "C90","E0", "E7", "E90"))
beanplot(C0$Ratio, C7$Ratio, C90$Ratio, E0$Ratio, E7$Ratio, E90$Ratio,
         log = "", main="BWA", names=c("C0", "C7", "C90","E0", "E7", "E90"))

t.test(E0$Ratio, E7$Ratio, paired = TRUE)

wilcox.test(controls$Ratio, E0$Ratio, paired = TRUE)
wilcox.test(controls$Ratio, E7$Ratio, paired = TRUE)
wilcox.test(controls$Ratio, E90$Ratio, paired = TRUE)

wilcox.test(controls$Ratio, E0$Ratio, alternative = "greater", paired = TRUE)
wilcox.test(controls$Ratio, E7$Ratio, alternative = "greater", paired = TRUE)
wilcox.test(controls$Ratio, E90$Ratio, alternative = "greater", paired = TRUE)


rndVariance <- c(C7$Ratio-C0$Ratio, C90$Ratio-C7$Ratio, C90$Ratio-C0$Ratio)
wilcox.test(rndVariance, (E7$Ratio-E0$Ratio), alternative = "greater", paired = TRUE)
wilcox.test(rndVariance, (E90$Ratio-E7$Ratio), alternative = "greater", paired = TRUE)
wilcox.test(rndVariance, (E90$Ratio-E0$Ratio), alternative = "greater", paired = TRUE)


# colnames : Patient Patient0 Time Time0 Treatment MappedReads TotalReads    Ratio Sex Age
plot(DFLM$TotalReads, DFLM$Ratio)

regLine <- lm(DFLM$TotalReads ~ DFLM$MappedReads)
par(cex=12)
a <- regLine$coefficients[1]
b <- regLine$coefficients[2]
plot(DFLM$TotalReads, DFLM$MappedReads)
abline(a,b)



DFLM["winsoRatio"] <- winsorize(DFLM$Ratio)


model <- betareg(Ratio ~ Treatment + Time0 + Age + Sex, data=DFLM)
summary(model)
model <- betareg(winsoRatio ~ Treatment + Time0 + Age + Sex, data=DFLM)
summary(model)


########################################################################
## New section -- graphs for only exposed 0-7-90
########################################################################

DFLM <- read.csv("~/GitHub/codingTheMicrobiome/r/bwaForLm.csv")
# Do you winsorize the data?
DFLM["Ratio"] <- lapply(DFLM["Ratio"], winsorize)
DFLM18 <- subset(DFLM, Treatment == 1)

par(mfrow=c(1,3))
main <- paste0("Cefprozil exposed patients\nn = ", nrow(subset(DFLM18, Time == "J0")))
pirateplot(log10(Ratio) ~ Time, data = DFLM18, avg.line.fun = median,
           ylab = "Normalised Counts (log)", main = main, point.cex = 2)


j0 <- subset(DFLM18, Time == "J0")$Ratio
j7 <- subset(DFLM18, Time == "J7")$Ratio
j90 <- subset(DFLM18, Time == "J7")$Ratio

j0j7 <- subset(DFLM18, Time == "J0" | Time == "J7")
tmp <- subset(j0j7, select = c('Patient', 'Time', 'Ratio'))
j0j7Fc <- spread(tmp, Time, Ratio)
j0j7Fc['Fc'] <- log2(j0j7Fc$J7/j0j7Fc$J0)
j0j7Fc['Zeros'] <- rep(0, nrow(j0j7Fc['Fc']))

 
t.test(j0j7Fc$Fc, j0j7Fc$Zeros, paired = TRUE)
t.test(j0, j7, paired = TRUE)
wilcox.test(j0j7Fc$Fc, j0j7Fc$Zeros, paired = TRUE)
wilcox.test(j0, j7, paired = TRUE)



j0j7j90 <- subset(DFLM18, select = c('Patient', 'Time', 'Ratio'))
j0j7j90Fc <- spread(j0j7j90, Time, Ratio)
j0j7j90Fc['Fc_0_7'] <- log(j0j7j90Fc$J7/j0j7j90Fc$J0)
j0j7j90Fc['Fc_7_90'] <- log(j0j7j90Fc$J90/j0j7j90Fc$J7)
j0j7j90Fc['Zeros'] <- rep(0, nrow(j0j7j90Fc['Fc_0_7']))

j0 <- log(j0j7j90Fc$J0)
j7 <- log(j0j7j90Fc$J7)
j90<- log(j0j7j90Fc$J90)

z <- rep(c(0,1,2), rep(length(j0),3))
plot(z, c(j0, j7, j90),
     xaxt="n", ylab="Normalised Counts",
     xlab="", xlim=c(-0.5, 2.5), main = "Paired Conditions")
axis(side=1, at=c(0,1,2), c("J0", "J7", "J90"))
# making the colored segments 0-7
UP_0 <- log(subset(j0j7j90Fc, Fc_0_7 >= 0)$J0)
DOWN_0 <- log(subset(j0j7j90Fc, Fc_0_7 < 0)$J0)
UP_7 <- log(subset(j0j7j90Fc, Fc_0_7 >= 0)$J7)
DOWN_7 <- log(subset(j0j7j90Fc, Fc_0_7 < 0)$J7)
segments(rep(0, length(UP_0)), UP_0, rep(1, length(UP_7)), UP_7, col=4)
segments(rep(0, length(DOWN_0)), DOWN_0, rep(1, length(DOWN_7)), DOWN_7, col=2)
# making the colored segments 7-90
UP_7 <- log(subset(j0j7j90Fc, Fc_7_90 >= 0)$J7)
DOWN_7 <- log(subset(j0j7j90Fc, Fc_7_90 < 0)$J7)
UP_90 <- log(subset(j0j7j90Fc, Fc_7_90 >= 0)$J90)
DOWN_90 <- log(subset(j0j7j90Fc, Fc_7_90 < 0)$J90)
segments(rep(1, length(UP_7)), UP_7, rep(2, length(UP_90)), UP_90, col=4)
segments(rep(1, length(DOWN_7)), DOWN_7, rep(2, length(DOWN_90)), DOWN_90, col=2)

graphFc <- subset(j0j7j90Fc, select = c('Fc_0_7', 'Fc_7_90'))
graphFc <- melt(graphFc)
pirateplot(value ~ variable, data = graphFc, main = "log2 of Fold Change (B/A)", point.cex = 2)

wilcox.test(j0j7j90Fc$Fc_0_7, j0j7j90Fc$Zeros, paired = TRUE)$p.value


