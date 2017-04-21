winsorize <- function(x, q=0.05) {
  extrema <- quantile(x, c(q, 1-q))  
  x[x<extrema[1]] <- extrema[1]
  x[x>extrema[2]] <- extrema[2]
  x
}

library(readxl)
library(tidyr)
rsemDF <- read.csv("~/GitHub/codingTheMicrobiome/data/rsemDF.csv")
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

median(log(E0$expected_count))
log(median(E0$expected_count))

median(log(E7$expected_count))
log(median(E7$expected_count))


mean(log(winsorize(E0$expected_count)))
mean(log(winsorize(E7$expected_count)))
log(mean(winsorize(E7$expected_count)))
log(mean(winsorize(E0$expected_count)))





var(rsemExpect$expected_count)/mean(rsemExpect$expected_count)

boxplot(C0$expected_count, C7$expected_count, C90$expected_count, E0$expected_count, E7$expected_count, E90$expected_count, 
        outline = FALSE, main="RSEM", names=c("C0", "C7", "C90","E0", "E7", "E90"))

beanplot(C0$expected_count, C7$expected_count, C90$expected_count, E0$expected_count, E7$expected_count, E90$expected_count,
         log = "y", main="RSEM", names=c("C0", "C7", "C90","E0", "E7", "E90"))
beanplot(C0$expected_count, C7$expected_count, C90$expected_count, E0$expected_count, E7$expected_count, E90$expected_count,
         log = "", main="RSEM", names=c("C0", "C7", "C90","E0", "E7", "E90"))

par(mfrow=c(1,2))
beanplot(C0$expected_count, C7$expected_count, C90$expected_count, E0$expected_count, E7$expected_count, E90$expected_count,
         overallline = "median", log = "y", main="RSEM-Log", names=c("C0", "C7", "C90","E0", "E7", "E90"))
beanplot(C0$expected_count, C7$expected_count, C90$expected_count, E0$expected_count, E7$expected_count, E90$expected_count,
         overallline = "median", log = "", main="RSEM", names=c("C0", "C7", "C90","E0", "E7", "E90"))




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
  list <- sapply(list, function(x) ((x*(N-1) + 0.25)/N))
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
model <- betareg(minMax ~ treatment + day + age + sex, data=rsemExpect)
# model <- betareg(decostand ~ treatment + day*treatment, data=rsemExpect)
summary(model)
plot(model)

model <- betareg(noZero ~ treatment + day + age + sex, data=rsemExpect)
model <- betareg(betaNorm ~ treatment + day + age + sex, data=rsemExpect)
model <- betareg(betaNorm ~ treatment + day, data=rsemExpect)
model <- betareg(minMax ~ treatment + day, data=rsemExpect)
summary(model)

rsemExpect$minMax



rsemExpect$

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


hist(rsemExpect["minMax"])
hist(rsemExpect["minMax"])
hist(rsemExpect["noZero"])
hist(rsemExpect["betaNorm"])

hist(winsorize(rsemExpectpect$expected_count), main = "expected_count", breaks=100)
hist(winsorize(rsemExpect$noZero), main = "noZero", breaks=100)
hist(winsorize(rsemExpect$minMax), main = "minMax", breaks=100)
hist(winsorize(rsemExpect$betaNorm), main = "betaNorm", breaks=100)


dev.off()
par ( mfrow = c ( 2, 2 ) )   #  4 graphics on 1 screen
hist(winsorize(rsemExpect$expected_count), breaks=100, main = "expected_count")
hist(rsemExpect$noZero, breaks=100, main = "noZero")
hist(rsemExpect$minMax, breaks=100, main = "minMax")
hist(rsemExpect$betaNorm, breaks=100, main = "betaNorm")

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

par(mfrow=c(1,4))
dev.off()
boxplot(winsorize(rsemExpect$expected_count), main = "expected_count")
boxplot(winsorize(rsemExpect$noZero), main = "noZero")
boxplot(winsorize(rsemExpect$minMax), main = "minMax")
boxplot(winsorize(rsemExpect$betaNorm), main = "betaNorm")

dev.off()
par(mfrow=c(1,4))
beanplot(winsorize(rsemExpect$expected_count), main = "expected_count")
beanplot(rsemExpect$noZero, main = "noZero")
beanplot(rsemExpect$minMax, main = "minMax")
beanplot(rsemExpect$betaNorm, main = "betaNorm")

beanplot(winsorize(rsemExpect$expected_count), main = "expected_count", log="")
beanplot(rsemExpect$noZero, main = "noZero", log="")
beanplot(rsemExpect$minMax, main = "minMax", log="")
beanplot(rsemExpect$betaNorm, main = "betaNorm", log="")


# Normalise, simply
rsemExpect["minMax"] <- as.numeric(toMinMax(decostand(rsemExpect$expected_count, method = "range")))
rsemExpect["noZero"] <- as.numeric(noZero(decostand(rsemExpect$expected_count, method = "range")))
rsemExpect["betaNorm"] <- as.numeric(betaNorm(rsemExpect$expected_count))

# Winsorize, then normalise
rsemExpect["minMax"] <- as.numeric(toMinMax(decostand(winsorize(rsemExpect$expected_count), method = "range")))
rsemExpect["noZero"] <- as.numeric(noZero(decostand(winsorize(rsemExpect$expected_count), method = "range")))
rsemExpect["betaNorm"] <- as.numeric(betaNorm(winsorize(rsemExpect$expected_count)))


E0E7 <- rsemExpect[rsemExpect$day != 90 & rsemExpect$treatment == 1, ]

model <- betareg(betaNorm ~ treatment + day + age + sex, data=rsemExpect)
model <- lm(betaNorm ~ day, data=E0E7)
model <- lm(expected_count ~ day, data=E0E7)
model <- lm(betaNorm ~ day + age + sex, data=E0E7)
summary(model)

model <- betareg(betaNorm ~ day + age + sex, data=rsemExpect)


wilcox.test(subset(rsemExpect, day == 0 & treatment == 1)$expected_count, 
            subset(rsemExpect, day == 7 & treatment == 1)$expected_count, 
            paired = TRUE)

### johanna, 22 fév
#counts~ day + age + sex + (1|B)

head(rsemExpect)
rsemExpect["patient0"] <- as.integer(gsub('[a-zA-Z]', '', rsemExpect$patient))
fit <- lm(betaNorm ~ treatment + day + age + sex + (1 | patient0), data = rsemExpect)
fit <- betareg(betaNorm ~ treatment + day + age + sex + (patient0), data = rsemExpect)

fit <- betareg(betaNorm ~ day + age + sex , data = rsemExpect)
fit <- betareg(betaNorm ~ day, data = rsemExpect)
fit <- betareg(minMax ~ day, data = rsemExpect)
summary(fit)

rsemExpect["patient0"] <- toPatient0(rsemExpect["patient"])


### 
#
# Making the logfoldchange
#
###

winsorize <- function(x, q=0.05) {
  extrema <- quantile(x, c(q, 1-q))  
  x[x<extrema[1]] <- extrema[1]
  x[x>extrema[2]] <- extrema[2]
  x
}

library(readxl)
library(tidyr)
rsemDF <- read.csv("~/GitHub/codingTheMicrobiome/data/rsemDF.csv")
rsemExpect <- read.csv("~/GitHub/codingTheMicrobiome/data/rsemExpect.csv")
# Do you winsorize the data?
rsemExpect["expected_count"] <- lapply(rsemExpect["expected_count"], winsorize)
# Making the wide version of the DF
tmp <- subset(rsemExpect, select = -c(sample) )
wideExpect <- spread(tmp, day, expected_count)
colnames(wideExpect) <- c("patient", "treatment", "age", "sex", "J0", "J7", "J90")

wideExpect["0"]

wideExpect['Fc'] = (wideExpect$J7 - wideExpect$J0) / wideExpect$J0
wideExpect['H0'] = rep_len(0, length(wideExpect$J0))

wilcox.test(wideExpect$Fc, wideExpect$H0)

wilcox.test(subset(wideExpect, treatment == 1)$Fc, 
            subset(wideExpect, treatment == 1)$H0)


library(yarrr)
pirateplot(formula = Fc ~ treatment, avg.line.fun = median, 
           hdi.iter = 0, pal = c("blue"), point.cex = 2,
           inf.method = "iqr",
           data = subset(wideExpect, treatment == 1),
           main = "fold Change", ylab = "Fold Change")


median((wideExpect$`7` - wideExpect$`0`) / wideExpect$`0`)
median(wideExpect$`7`/wideExpect$`0`)

median(wideExpect$`7`)
median(wideExpect$`0`)

(J7-J0)/J0

