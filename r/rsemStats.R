winsorize <- function(x, q=0.05) {
  extrema <- quantile(x, c(q, 1-q))  
  x[x<extrema[1]] <- extrema[1]
  x[x>extrema[2]] <- extrema[2]
  x
}

rsemDF <- read_csv("~/GitHub/codingTheMicrobiome/data/rsemDF.csv")
rsemExpect <- read_excel("~/GitHub/codingTheMicrobiome/data/rsemExpect.xlsx")

tmp <- subset(rsemExpect, select = -c(sample) )
wideExpect <- spread(tmp, day, expected_count)


hist(rsemExpect$expected_count, breaks=100)

plot(rsemExpect$expected_count)

model <- lm(expected_count ~ treatment + date + age + sex, data=rsemExpect)
model <- lm(expected_count ~ Treatment + Time0 + Treatment*Time0 + Age + Sex, data=DFLM)
summary(model)
plot(model)


var(DFLM$Ratio)/mean(DFLM$Ratio)

Wilcox--Exposed
wilcox.test(E0$expected_count, E7$expected_count, paired=TRUE)
wilcox.test(E7$expected_count, E90$expected_count, paired=TRUE)
wilcox.test(E0$expected_count, E90$expected_count, paired=TRUE)

wilcox.test(expected_count ~ treatment, data=rsemExpect)
wilcox.test(J7$expected_count ~ Treatment, data=DF)
wilcox.test(J90 ~ Treatment, data=DF)

wilcox.test(expected_count ~ treatment, data=rsemExpect)

wilcox.test((7-0) ~ treatment, data=wideExpect)

controls = rsemExpect[rsemExpect$treatment == 0, ]
exposed = rsemExpect[rsemExpect$treatment == 1, ]

E0 = rsemExpect[rsemExpect$treatment == 1 & rsemExpect$day == 0, ]
E7 = rsemExpect[rsemExpect$treatment == 1 & rsemExpect$day == 7, ]
E90 = rsemExpect[rsemExpect$treatment == 1 & rsemExpect$day == 90, ]

C0 = rsemExpect[rsemExpect$treatment == 0 & rsemExpect$day == 0, ]
C7 = rsemExpect[rsemExpect$treatment == 0 & rsemExpect$day == 7, ]
C90 = rsemExpect[rsemExpect$treatment == 0 & rsemExpect$day == 90, ]

J0 = rsemExpect[rsemExpect$day == 0, ]
J7 = rsemExpect[rsemExpect$day == 7, ]
J90 = rsemExpect[rsemExpect$day == 90, ]

wilcox.test(expected_count ~ treatment, data=J0)
wilcox.test(expected_count ~ treatment, data=J7)
wilcox.test(expected_count ~ treatment, data=J90)

boxplot(C0$expected_count, C7$expected_count, C90$expected_count, E0$expected_count, E7$expected_count, E90$expected_count, 
        outline = FALSE, main="RSEM", names=c("C0", "C7", "C90","E0", "E7", "E90"))

beanplot(C0$expected_count, C7$expected_count, C90$expected_count, E0$expected_count, E7$expected_count, E90$expected_count,
         main="RSEM", names=c("C0", "C7", "C90","E0", "E7", "E90"))


wilcox.test(controls$expected_count, E0$expected_count, paired = TRUE)
wilcox.test(controls$expected_count, E7$expected_count, paired = TRUE)
wilcox.test(controls$expected_count, E90$expected_count, paired = TRUE)

wilcox.test(controls$expected_count, E0$expected_count, alternative = "greater")
wilcox.test(controls$expected_count, E7$expected_count, alternative = "greater")
wilcox.test(controls$expected_count, E90$expected_count, alternative = "greater")

wilcox.test((7-0) ~ treatment, data = wideExpect)







