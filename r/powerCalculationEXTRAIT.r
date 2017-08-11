#========================================================================================
# Ma section
#========================================================================================
library('MASS')

DF <- read.csv("~/GitHub/codingTheMicrobiome/r/2017-01-10_extractedReadsRatio.csv")

j0Tr <- subset(DF, Treatment == 1, select = "J0")
j7Tr <- subset(DF, Treatment == 1, select = "J7")
j90Tr <- subset(DF, Treatment == 1, select = "J90")

set.seed(123)

#' Exponential
fitdistr(j0Tr$J0, "exponential") # 6212.466
fitdistr(j7Tr$J7, "exponential") # 5701.688
sim_wilcoxon(n=36,                 # total sample size
             weights=list(c(1, 1)), # equal sample size per group
             rexp(rate = fitdistr(j0Tr$J0, "exponential")$estimate),     # distribution of first sample
             rexp(rate = fitdistr(j7Tr$J7, "exponential")$estimate),    # distribution of second sample
             nsim=10000)


#' Exponential
fitdistr(j0Tr$J0, "exponential") # 6212.466
fitdistr(j7Tr$J7, "exponential") # 5701.688
sim_wilcoxon(n=36,                 # total sample size
             weights=list(c(1, 1)), # equal sample size per group
             rexp(rate = 6212.466),     # distribution of first sample
             rexp(rate = 5701.688),    # distribution of second sample
             nsim=10000)


#' Beta distribution ***** MUST BE MULTIPLICATED BY 1000 TO FIT THE DISTRIBUTION *****
fitdistr(j0Tr$J0, "beta", start=list(shape1=2,shape2=5)) # 
fitdistr(j7Tr$J7, "beta", start=list(shape1=2,shape2=5)) # 
sim_wilcoxon(n=36,                 # total sample size
             weights=list(c(1, 1)), # equal sample size per group
             rbeta(shape1=0.9122174, shape2=4.6727713),     # distribution of first sample
             rbeta(shape1=0.5158790, shape2=2.2174285),    # distribution of second sample
             nsim=1000)


#' Beta distributionX1000
fitdistr(j0Tr$J0*1000, "beta", start=list(shape1=2,shape2=5)) # 0.9122174   4.6727713
fitdistr(j7Tr$J7*1000, "beta", start=list(shape1=2,shape2=5)) # 0.5158790   2.2174285
sim_wilcoxon(n=36,                 # total sample size
             weights=list(c(1, 1)), # equal sample size per group
             rbeta(shape1=0.9122174, shape2=4.6727713),     # distribution of first sample
             rbeta(shape1=0.5158790, shape2=2.2174285),    # distribution of second sample
             nsim=1000)


#=========================================================================================
# Section pour le calcul du D de Cohen
#=========================================================================================

# from "https://stackoverflow.com/questions/15436702/estimate-cohens-d-for-effect-size"
cohens_d <- function(x, y) {
  lx <- length(x)- 1
  ly <- length(y)- 1
  md  <- abs(mean(x) - mean(y))        ## mean difference (numerator)
  csd <- lx * var(x) + ly * var(y)
  csd <- csd/(lx + ly)
  csd <- sqrt(csd)                     ## common sd computation
  
  cd  <- md/csd                        ## cohen's d
}

res <- cohens_d(j0Tr$J0, j7Tr$J7)
res
# same result, with library 'lsr'
library(lsr)
cohensD(j0Tr$J0, j7Tr$J7)

#=========================================================================================
# Autres calculs et graphiques
#=========================================================================================

summary(j0Tr$J0)
var(j0Tr$J0)

summary(j7Tr$J7)

summary(j90Tr$J90)

data <- rbind(cbind(j0Tr$J0, rep('0', length(j0Tr$J0))),
      cbind(j7Tr$J7, rep('7', length(j7Tr$J7))),
      cbind(j90Tr$J90, rep('90', length(j90Tr$J90))))
colnames(data) <- c("value", "time")

pirateplot(value ~ time, data = data)


data <- rbind(cbind(j0Tr, rep('0', length(j0Tr$J0))),
              cbind(j7Tr, rep('7', length(j7Tr$J7))),
              cbind(j90Tr, rep('90', length(j90Tr$J90))))
colnames(data) <- c("value", "time")

data <- melt(cbind(j0Tr, j7Tr, j90Tr))

pirateplot(log(value) ~ variable, data = data)

# 2017-08-08  plot the simulated distributions?
fitdistr(j0Tr$J0*1000, "beta", start=list(shape1=2,shape2=5)) # 0.9122174   4.6727713
fitdistr(j7Tr$J7*1000, "beta", start=list(shape1=2,shape2=5)) # 0.5158790   2.2174285
fitdistr(j90Tr$J90*1000, "beta", start=list(shape1=2,shape2=5)) # not working!!!

plot(density(rbeta(n=18, shape1=0.9122174, shape2=4.6727713)), col = "black"); lines(density(rbeta(n=18, shape1=0.5158790, shape2=2.2174285)), col = "blue")
plot(density(j0Tr$J0), col = "black"); lines(density(j7Tr$J7), col = "blue"); lines(density(j90Tr$J90), col = "green")

# comparing raw to fitted data
plot(density(j0Tr$J0*1000), col = "blue", main = "compare rbeta D0"); lines(density(rbeta(n=18, shape1=0.9122174, shape2=4.6727713)), col = "red")
plot(density(j7Tr$J7*1000), col = "blue", main = "compare rbeta D7"); lines(density(rbeta(n=18, shape1=0.5158790, shape2=2.2174285)), col = "red")

# 
fitdistr(j0Tr$J0*1000, "exponential") # 0.9122174   4.6727713
fitdistr(j7Tr$J7*1000, "beta", start=list(shape1=2,shape2=5)) # 0.5158790   2.2174285
fitdistr(j90Tr$J90*1000, "beta", start=list(shape1=2,shape2=5)) # not working!!!

plot(density(j7Tr$J7*1000), col = "blue", main = "compare rbeta D7"); lines(density(rbeta(n=18, shape1=0.5158790, shape2=2.2174285)), col = "red")




