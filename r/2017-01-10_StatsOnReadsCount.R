
DF <- read.csv("/Users/jay/GitHub/codingTheMicrobiome/r/2017-01-10_extractedReadsRatio.csv")

controls <- DF[DF$Treatment == 0, ]
exposed <- DF[DF$Treatment == 1, ]

E0 <- exposed$J0
E7 <- exposed$J7
E90 <- exposed$J90

C0 <- controls$J0
C7 <- controls$J7
C90 <- controls$J90

yarrr <- boxplot(C0, C7, C90, E0, E7, E90, outline=FALSE)
x11(yarrr)
boxplot(J0, J7, J90, outline=FALSE, main="WTF R?!")
boxplot(DF$J0, DF$J7, DF$J90, outline=FALSE)
boxplot(log(DF$J0), log(DF$J7), log(DF$J90), outline=FALSE)

library(ggplot2)

boxplot(Winzorize(DF$J0), winzorize(DF$J7), winzorize(DF$J90))

contingencyTable <- read.csv("~/GitHub/codingTheMicrobiome/r/contingencyTable.csv")
contingencyTable$X <- NULL
library("gplots")
install.packages('gplots')
chisq.test(contingenceTable)

file_path <- "http://www.sthda.com/sthda/RDoc/data/housetasks.txt"
housetasks <- read.delim(file_path, row.names = 1)
chisq <- chisq.test(housetasks)

