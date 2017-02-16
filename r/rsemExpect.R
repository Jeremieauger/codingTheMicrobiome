winsorize <- function(x, q=0.05) {
  extrema <- quantile(x, c(q, 1-q))  
  x[x<extrema[1]] <- extrema[1]
  x[x>extrema[2]] <- extrema[2]
  x
}

library(readxl)
rsemDF <- read_csv("~/GitHub/codingTheMicrobiome/data/rsemDF.csv")
rsemExpect <- read_excel("~/GitHub/codingTheMicrobiome/data/rsemExpect.xlsx")
# Do you winsorize the data?
rsemExpect["expected_count"] <- lapply(rsemExpect["expected_count"], winsorize)
# Making the wide version of the DF
tmp <- subset(rsemExpect, select = -c(sample) )
wideExpect <- spread(tmp, day, expected_count)
# One line to make all objects specific to expected_count
controls = rsemExpect[rsemExpect$treatment == 0, ]; exposed = rsemExpect[rsemExpect$treatment == 1, ]; E0 = rsemExpect[rsemExpect$treatment == 1 & rsemExpect$day == 0, ]; E7 = rsemExpect[rsemExpect$treatment == 1 & rsemExpect$day == 7, ]; E90 = rsemExpect[rsemExpect$treatment == 1 & rsemExpect$day == 90, ]; C0 = rsemExpect[rsemExpect$treatment == 0 & rsemExpect$day == 0, ]; C7 = rsemExpect[rsemExpect$treatment == 0 & rsemExpect$day == 7, ]; C90 = rsemExpect[rsemExpect$treatment == 0 & rsemExpect$day == 90, ]; J0 = rsemExpect[rsemExpect$day == 0, ]; J7 = rsemExpect[rsemExpect$day == 7, ]; J90 = rsemExpect[rsemExpect$day == 90, ]


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

# Graphs and analysis
hist(rsemExpect$expected_count, breaks=100)
plot(rsemExpect$expected_count)

var(rsemExpect$expected_count)/mean(rsemExpect$expected_count)

boxplot(C0$expected_count, C7$expected_count, C90$expected_count, E0$expected_count, E7$expected_count, E90$expected_count, 
        outline = FALSE, main="RSEM", names=c("C0", "C7", "C90","E0", "E7", "E90"))

beanplot(C0$expected_count, C7$expected_count, C90$expected_count, E0$expected_count, E7$expected_count, E90$expected_count,
         log = "y", main="RSEM", names=c("C0", "C7", "C90","E0", "E7", "E90"))
beanplot(C0$expected_count, C7$expected_count, C90$expected_count, E0$expected_count, E7$expected_count, E90$expected_count,
         log = "", main="RSEM", names=c("C0", "C7", "C90","E0", "E7", "E90"))


model <- lm(expected_count ~ treatment + day + age + sex, data=rsemExpect)
summary(model)
plot(model)




model <- lm(expected_count ~ treatment + age + sex, data=J7)
summary(model)

model <- lm(expected_count ~ day + age + sex, data=exposed)
summary(model)

J0J7exposed <- exposed[exposed$day != 90, ]
model <- lm(expected_count ~ day + age + sex, data=J0J7exposed); summary(model)

J0J7Expect <- rsemExpect[rsemExpect$day != 90,  ]
model <- lm(expected_count ~ treatment + day + age + sex, data=J0J7Expect); summary(model)


J0J7Expect <- rsemExpect[rsemExpect$day != 90,  ]
model <- lm(expected_count ~ treatment + day, data=J0J7Expect); summary(model)

model <- lm(expected_count ~ treatment + day, data=J0); summary(model)
model <- lm(expected_count ~ treatment + day, data=J7); summary(model)

Wilcox--Exposed
wilcox.test(E0$expected_count, E7$expected_count, paired=TRUE)
wilcox.test(E7$expected_count, E90$expected_count, paired=TRUE)
wilcox.test(E0$expected_count, E90$expected_count, paired=TRUE)

wilcox.test(expected_count ~ treatment, data=rsemExpect)
wilcox.test(J7$expected_count ~ Treatment, data=DF)
wilcox.test(J90 ~ Treatment, data=DF)

wilcox.test(expected_count ~ treatment, data=rsemExpect)

wilcox.test((7-0) ~ treatment, data=wideExpect)

wilcox.test(expected_count ~ treatment, data=J0)
wilcox.test(expected_count ~ treatment, data=J7)
wilcox.test(expected_count ~ treatment, data=J90)

wilcox.test(controls$expected_count, E0$expected_count)
wilcox.test(controls$expected_count, E7$expected_count)
wilcox.test(controls$expected_count, E90$expected_count)

wilcox.test(controls$expected_count, E0$expected_count, paired = TRUE)
wilcox.test(controls$expected_count, E7$expected_count, paired = TRUE)
wilcox.test(controls$expected_count, E90$expected_count, paired = TRUE)

wilcox.test(controls$expected_count, E0$expected_count, alternative = "greater")
wilcox.test(controls$expected_count, E7$expected_count, alternative = "greater")
wilcox.test(controls$expected_count, E90$expected_count, alternative = "greater")

wilcox.test(controls$expected_count, E0$expected_count, alternative = "greater", paired = TRUE)
wilcox.test(controls$expected_count, E7$expected_count, alternative = "greater", paired = TRUE)
wilcox.test(controls$expected_count, E90$expected_count, alternative = "greater", paired = TRUE)

wilcox.test((7-0) ~ treatment, data = wideExpect)

wilcox.test((E7-E0))
rndVariance <- c(C7$expected_count-C0$expected_count, C90$expected_count-C7$expected_count, C90$expected_count-C0$expected_count)
wilcox.test(rndVariance, (E7$expected_count-E0$expected_count), alternative = "greater", paired = TRUE)
wilcox.test(rndVariance, (E90$expected_count-E7$expected_count), alternative = "greater", paired = TRUE)
wilcox.test(rndVariance, (E90$expected_count-E0$expected_count), alternative = "greater", paired = TRUE)

library(vegan)
library(gtools)
library(betareg)
library(vegan)

noZero <- function(list){
  list[list == 0] <- 0.0000001
  list[list == 1] <- 0.9999999
  list
}

toMinMax <- function(list){
  min.list <- min(list[list > 0], na.rm=TRUE)
  max.list <- max(list[list < 1], na.rm=TRUE)
  list[list == 0] <- min.list
  list[list == 1] <- max.list
  list
}

list <- rsemExpect$expected_count
# y' = (y – a)/(b – a)
# where b is the highest possible score on the test 
# and a is the smallest possible score
# y" = ([y'(N – 1) + 1/2] / N) 
# where N is the sample size 
betaNorm <- function(list){
  min.list <- min(list)
  max.list <- max(list)
  N <- length(list)
  list <- sapply(list, function(x) (x-min.list)/(max.list - min.list))
  list <- sapply(list, function(x) ((x*(N-1) + 0.5)/N))
  list
}


y <- decostand(rsemExpect$expected_count, method = "range")
n <- length(rsemExpect$expected_count)
y <- (y * (n - 1) + 0.5)/n
rsemExpect["decostand"] <- y  

rsemJ0J7 <- rsemExpect[rsemExpect$day != 90, ]
y <- betaNorm(rsemJ0J7$expected_count)
y <- decostand(rsemJ0J7$expected_count, method = "range")
n <- length(rsemJ0J7$expected_count)
y <- (y * (n - 1) + 0.5)/n
rsemJ0J7["decostand"] <- y  
model <- betareg(decostand ~ treatment + day + age + sex, data=rsemJ0J7)
summary(model)
plot(model)


rsemExpect["decostand"] <- decostand(rsemExpect$expected_count, method = "range")

rsemExpect["decostand"] <- toMinMax(decostand(rsemExpect$expected_count, method = "range"))
rsemExpect["decostand"] <- noZero(decostand(rsemExpect$expected_count, method = "range"))
rsemExpect["decostand"] <- betaNorm(rsemExpect$expected_count)

model <- betareg(decostand ~ treatment + day + age + sex, data=rsemExpect)
# model <- betareg(decostand ~ treatment + day*treatment, data=rsemExpect)
summary(model)
plot(model)


rsemJ0J7["decostand"] <- toMinMax(decostand(rsemJ0J7$expected_count, method = "range"))
rsemJ0J7["decostand"] <- noZero(decostand(rsemJ0J7$expected_count, method = "range"))
rsemJ0J7["decostand"] <- betaNorm(rsemJ0J7$expected_count)

model <- betareg(decostand ~ treatment + day + age + sex, data=rsemJ0J7)
model <- betareg(decostand ~ treatment + day*treatment, data=rsemJ0J7)
summary(model)
plot(model)





rsemExpect["minMax"] <- toMinMax(decostand(rsemExpect$expected_count, method = "range"))
rsemExpect["noZero"] <- noZero(decostand(rsemExpect$expected_count, method = "range"))
rsemExpect["betaNorm"] <- betaNorm(rsemExpect$expected_count)

rsemExpect["minMax"] <- as.numeric(toMinMax(decostand(rsemExpect$expected_count, method = "range")))
rsemExpect["noZero"] <- as.numeric(noZero(decostand(rsemExpect$expected_count, method = "range")))
rsemExpect["betaNorm"] <- as.numeric(betaNorm(rsemExpect$expected_count))



library(beanplot)
boxplot(rsemExpect["noZero"], rsemExpect["betaNorm"], rsemExpect["minMax"], outline = FALSE, main="RSEM", names=c("C0", "C7", "C90"))


beanplot(rsemExpect["noZero"], rsemExpect["betaNorm"], rsemExpect["minMax"])

boxplot(rsemExpect$noZero, rsemExpect$minMax)

hist(as.numeric(rsemExpect["minMax"]))
hist(as.numeric(rsemExpect["noZero"]))
hist(as.numeric(rsemExpect["betaNorm"]))


par ( mfrow = c ( 2, 2 ) )   #  4 graphics on 1 screen
#dev.off()
hist(rsemExpect$expected_count, breaks=100)
hist(rsemExpect$noZero, breaks=100)
hist(rsemExpect$minMax, breaks=100)
hist(rsemExpect$betaNorm, breaks=100)

library(ggplot2)
install.packages("devtools")
library(devtools)
install_github("easyGgplot2", "kassambara")
library(easyGgplot2)
df <- cbind(rsemExpect$expected_count, rsemExpect$noZero, rsemExpect$minMax, rsemExpect$betaNorm)
ggplot2.dotplot(data=df)
# , xName='dose',yName='len')
len <- length(rsemExpect$expected_count)
df1 <- cbind(rsemExpect$expected_count, rep(1))
df2 <- cbind(rsemExpect$noZero, rep(2))
df3 <- cbind(rsemExpect$minMax, rep(3))
df4 <- cbind(rsemExpect$betaNorm, rep(4))
df <- data.frame(rbind( df2, df3, df4))
colnames(df) <- c("value", "group")
rownames(df) <- 1:nrow(df)
ggplot2.dotplot(data=df, xName='group', yName='value')


df1 <- cbind(winsorize(rsemExpect$expected_count), rep(1))
df2 <- cbind(winsorize(rsemExpect$noZero), rep(2))
df3 <- cbind(winsorize(rsemExpect$minMax), rep(3))
df4 <- cbind(winsorize(rsemExpect$betaNorm), rep(4))
df <- data.frame(rbind(df1, df2, df3, df4))
colnames(df) <- c("value", "group")
rownames(df) <- 1:nrow(df)

par(mfrow=c(2,2))
tmp <- cbind(winsorize(rsemExpect$noZero), rep(1))
colnames(tmp) <- c("value", "group")
rownames(tmp) <- 1:nrow(tmp)
tmp  <- data.frame(tmp)
ggplot2.dotplot(data=tmp, xName='group', yName='value', ytitle="Length")

p<-ggplot(tmp, aes(x=group, y=value)) + 
  geom_dotplot(binaxis='y', stackdir='center') +
  labs(x = "betaNorm", y = "Value")
p

df <- ToothGrowth
ggplot2.dotplot(data=df, xName='dose',yName='len',
                mainTitle="Plot of length according\n to the dose",
                xtitle="Dose (mg)", ytitle="Length")


df["supp"] <- NULL





