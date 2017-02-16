winsorize <- function(x, q=0.05) {
  extrema <- quantile(x, c(q, 1-q))  
  x[x<extrema[1]] <- extrema[1]
  x[x>extrema[2]] <- extrema[2]
  x
}

rsemTPM <- read_excel("~/GitHub/codingTheMicrobiome/data/rsemTPM.xlsx")
# Do you want to winsorize the data
rsemTPM["TPM"] <- lapply(rsemTPM["TPM"], winsorize)
tmp <- subset(rsemTPM, select = -c(sample) )
wideTPM <- spread(tmp, day, TPM)


model <- lm(expected_count ~ treatment + day + age + sex, data=rsemExpect)
summary(model)
plot(model)


hist(rsemTPM$TPM, breaks=100)
plot(rsemTPM$TPM)

#Oneline To make J0-J90, exposed/ctl, etc.
controls = rsemTPM[rsemTPM$treatment == 0, ]; exposed = rsemTPM[rsemTPM$treatment == 1, ]; E0 = rsemTPM[rsemTPM$treatment == 1 & rsemTPM$day == 0, ]; E7 = rsemTPM[rsemTPM$treatment == 1 & rsemTPM$day == 7, ]; E90 = rsemTPM[rsemTPM$treatment == 1 & rsemTPM$day == 90, ]; C0 = rsemTPM[rsemTPM$treatment == 0 & rsemTPM$day == 0, ]; C7 = rsemTPM[rsemTPM$treatment == 0 & rsemTPM$day == 7, ]; C90 = rsemTPM[rsemTPM$treatment == 0 & rsemTPM$day == 90, ]; J0 = rsemTPM[rsemTPM$day == 0, ]; J7 = rsemTPM[rsemTPM$day == 7, ]; J90 = rsemTPM[rsemTPM$day == 90, ]; 

controls = rsemTPM[rsemTPM$treatment == 0, ]
exposed = rsemTPM[rsemTPM$treatment == 1, ]

E0 = rsemTPM[rsemTPM$treatment == 1 & rsemTPM$day == 0, ]
E7 = rsemTPM[rsemTPM$treatment == 1 & rsemTPM$day == 7, ]
E90 = rsemTPM[rsemTPM$treatment == 1 & rsemTPM$day == 90, ]

C0 = rsemTPM[rsemTPM$treatment == 0 & rsemTPM$day == 0, ]
C7 = rsemTPM[rsemTPM$treatment == 0 & rsemTPM$day == 7, ]
C90 = rsemTPM[rsemTPM$treatment == 0 & rsemTPM$day == 90, ]

J0 = rsemTPM[rsemTPM$day == 0, ]
J7 = rsemTPM[rsemTPM$day == 7, ]
J90 = rsemTPM[rsemTPM$day == 90, ]

boxplot(C0$TPM, C7$TPM, C90$TPM, E0$TPM, E7$TPM, E90$TPM, 
        outline = FALSE, main="TPM", names=c("C0", "C7", "C90","E0", "E7", "E90"))

beanplot(C0$TPM, C7$TPM, C90$TPM, E0$TPM, E7$TPM, E90$TPM,
         log = "y", main="TPM", names=c("C0", "C7", "C90","E0", "E7", "E90"))
beanplot(C0$TPM, C7$TPM, C90$TPM, E0$TPM, E7$TPM, E90$TPM,
         log = "", main="TPM", names=c("C0", "C7", "C90","E0", "E7", "E90"))



wilcox.test(controls$TPM, E0$TPM, paired = TRUE)
wilcox.test(controls$TPM, E7$TPM, paired = TRUE)
wilcox.test(controls$TPM, E90$TPM, paired = TRUE)

wilcox.test(controls$TPM, E0$TPM, alternative = "greater")
wilcox.test(controls$TPM, E7$TPM, alternative = "greater")
wilcox.test(controls$TPM, E90$TPM, alternative = "greater")



rsemTPM["decostand"] <- toMinMax(decostand(rsemTPM$TPM, method = "range"))
rsemTPM["decostand"] <- noZero(decostand(rsemTPM$TPM, method = "range"))
rsemTPM["decostand"] <- betaNorm(rsemTPM$TPM)

model <- betareg(decostand ~ treatment + day + age + sex, data=rsemTPM)
summary(model)
plot(model)







