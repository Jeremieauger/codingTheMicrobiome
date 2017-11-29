#'## tiré de source("https://raw.githubusercontent.com/nutterb/StudyPlanning/master/R/sim_wilcoxon.R")
#'
#' @name sim_wilcoxon
#' @export sim_wilcoxon
#' @importFrom parallel detectCores
#' @importFrom parallel makeCluster
#' @importFrom parallel clusterSetRNGStream
#' @importFrom parallel parSapply
#' @importFrom parallel stopCluster
#' 
#' @title Simulate the Power of a Wilcoxon Rank Sum Test
#' @description Generates random samples from any two specified distributions
#'   and compares the samples by a Wilcoxon rank sum test.  Power is calculated
#'   as the proportion of tests that correctly reject the null hypothesis.
#'   
#' @param n Total sample size
#' @param ... two distribution functions should be entered.  See 'Details'.
#' @param weights a list of vectors giving the proposed weights for the two
#'   groups.  Each vector will be normalized.
#' @param alpha Significance level for the test.
#' @param nsim Number of simulations to run per set of conditions
#' @param seed The value of the random number generator seed (for reproducibility)
#' @param ncores The number of cores to use in parallel processing.
#' 
#' @details Distribution functions should be entered as a valid random variable
#'   generating function, but excluding the first argument.  For example, to 
#'   sample from a Poisson distribution with a mean of 3, one would enter
#'   \code{rpois(lambda=3)}.  Multiple values may be given to an argument to 
#'   generate power under multiple conditions, such as
#'   \code{rpois(lambda=c(3, 5, 7))}.
#' 
#' @return Returns a data frame with the following fields:
#' \enumerate{
#'   \item \code{n_total} Total sample size
#'   \item \code{n1} Group 1 sample size
#'   \item \code{n2} Group 2 sample size
#'   \item \code{k} The proportion of the total sample size allotted to Group 1
#'   \item \code{alpha} Significance level
#'   \item \code{power} Estimate of simulated power
#'   \item \code{nsim} Number of simulations performed
#'   \item \code{pop1_param} Parameters for the random sampling of group 1
#'   \item \code{pop2_param} Parameters for the random sampling of group 2
#'   \item \code{pop1_dist} Random sampling function for group 1
#'   \item \code{pop2_dist} Random sampling function for group 2
#' }
#'       
#' @author Benjamin Nutter
#' @examples
#' sim_wilcoxon(n=30, 
#'              weights=list(c(1, 1), c(1, 3)),
#'              rpois(lambda=c(2.1, 3.1, 4.1)),
#'              rpois(lambda=3.53),
#'              nsim=100)
#' 
sim_wilcoxon <- function(n, 
                         ...,
                         weights=list(c(1, 1)),
                         alpha=0.05,
                         nsim = 10000, 
                         seed = NULL,
                         ncores = 1){
  
  if (ncores > parallel::detectCores()) stop("You requested more cores than are available on the machine.")
  
  #* Determine the weight proportion
  k <- sapply(weights, function(x) x[1] / sum(x))
  
  #* Extract the list of distributions
  dist.list <- as.character(substitute(list(...)))[-1]
  
  #* Extract distribution names
  dist.fn <- lapply(dist.list, function(x) substr(x, 1, regexpr("[(]", x)-1))
  names(dist.fn) <- paste0("pop", 1:length(dist.fn), "_dist")
  
  #* Extract distribution arguments
  dist.args <- lapply(dist.list, 
                      function(x){
                        x <- paste0("list(", substr(x, regexpr("[(]", x) + 1, nchar(x) - 1), ")")
                        x <- eval(parse(text=x))
                        x <- expand.grid(x)
                        for (i in 1:length(x)){
                          x[i] <- paste(names(x)[i], x[, i], sep="=")
                        }
                        x <- apply(x, 1, paste, collapse=", ")
                        return(x)
                      })
  names(dist.args) <- paste0("pop", 1:length(dist.args), "_param")
  
  #* Generate the data frame for storing results
  .param <- expand.grid(c(list(n_total=n,
                               n1 = NA,
                               n2 = NA,
                               k = k,
                               alpha = alpha,
                               power = NA,
                               nsim = nsim),
                          dist.args),
                        stringsAsFactors=FALSE)
  .param$n1 <- with(.param, round(n_total * k))
  .param$n2 <- with(.param, n_total - n1)
  .param <- cbind(.param, dist.fn, stringsAsFactors=FALSE)
  
  simulate <- function(r, .param, nsim){
    x.param <- c(list(n = .param$n1[r]), 
                 eval(parse(text=paste0("list(", .param$pop1_param[r], ")"))))
    x <- lapply(1:nsim, function(x, r) do.call(.param$pop1_dist[r], x.param), r)
    
    y.param <- c(list(n = .param$n2[r]),
                 eval(parse(text=paste0("list(", .param$pop2_param[r], ")"))))
    y <- lapply(1:nsim, function(y, r) do.call(.param$pop2_dist[r], y.param), r)
    
    signif <- sapply(1:nsim, function(s, .param) wilcox.test(x[[s]], y[[s]], data=.param)$p.value, .param)
    
    sum(signif <= 0.05) / nsim
  }
  
  if (ncores <= 1){
    if (!is.null(set.seed)) set.seed(seed)
    .param$power <- sapply(1:nrow(.param), simulate, .param, nsim)
  }
  else{
    cl <- parallel::makeCluster(ncores)
    if (!is.null(seed)) parallel::clusterSetRNGStream(cl, seed)
    .param$power <- parallel::parSapply(cl, 1:nrow(.param), simulate, .param, nsim)
    parallel::stopCluster(cl)
  }
  
  return(.param)
}


# Use exemple
set.seed(123)
sim_wilcoxon(n=22,                 # total sample size
             weights=list(c(1, 1)), # equal sample size per group
             rpois(lambda=2.1),     # distribution of first sample
             rpois(lambda=3.53),    # distribution of second sample
             nsim=1000)

#========================================================================================
# Ma section
#========================================================================================

DF <- read.csv("~/GitHub/codingTheMicrobiome/r/2017-01-10_extractedReadsRatio.csv")

j0Tr <- subset(DF, Treatment == 1, select = "J0")
j7Tr <- subset(DF, Treatment == 1, select = "J7")
j90Tr <- subset(DF, Treatment == 1, select = "J90")

#' Poisson distribution
fitdistr(j0Tr$J0, "poisson") # 0.0001609667
fitdistr(j7Tr$J7, "poisson") # 0.0001753867
set.seed(123)
sim_wilcoxon(n=36,                 # total sample size
             weights=list(c(1, 1)), # equal sample size per group
             rpois(lambda=0.0001609667),     # distribution of first sample
             rpois(lambda=0.0001753867),    # distribution of second sample
             nsim=1000)

# plot(density(rpois(n=36,lambda=0.0001609667)))
# lines(density(rpois(n=36,lambda=0.0001753867)), col = "blue")


fitdistr(j0Tr$J0, "exponential")$estimate
#' Exponential
fitdistr(j0Tr$J0, "exponential") # 6212.466
fitdistr(j7Tr$J7, "exponential") # 5701.688
sim_wilcoxon(n=36,                 # total sample size
             weights=list(c(1, 1)), # equal sample size per group
             rexp(rate = fitdistr(j0Tr$J0, "exponential")$estimate),     # distribution of first sample
             rexp(rate = fitdistr(j7Tr$J7, "exponential")$estimate),    # distribution of second sample
             nsim=10000)

library('MASS')
fitdistr(j0Tr$J0, "exponential") # 6212.466
fitdistr(j7Tr$J7, "exponential") # 5701.688
sim_wilcoxon(n=36,                 # total sample size
             weights=list(c(1, 1)), # equal sample size per group
             rexp(rate = 6212.466),     # distribution of first sample
             rexp(rate = 5701.688),    # distribution of second sample
             nsim=10000)


# boxplot(rexp(18, rate = 6212.466), rexp(18, rate = 5701.688))
# n <- 18
# rbind(
#     cbind(rexp(n, rate = 6212.466), rep('0', n)), 
#     cbind(rexp(18, rate = 5701.688), rep('1', n))
# )

#pirateplot(log(value) ~ X2, melt(cbind(rexp(n, rate = 6212.466), rexp(n, rate = 5701.688))))


#' Beta distribution *****
library(MASS)
fitdistr(j0Tr$J0*1000, "beta", start=list(shape1=2,shape2=5)) # 0.9122174   4.6727713
fitdistr(j7Tr$J7*1000, "beta", start=list(shape1=2,shape2=5)) # 0.5158790   2.2174285
sim_wilcoxon(n=36,                 # total sample size
             weights=list(c(1, 1)), # equal sample size per group
             rbeta(shape1=0.9122174, shape2=4.6727713),     # distribution of first sample
             rbeta(shape1=0.5158790, shape2=2.2174285),    # distribution of second sample
             nsim=100000)




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

# Cauchy
fitdistr(j0Tr$J0*1000, "cauchy") # 0.11812807 0.08030487
plot(density(j0Tr$J0*1000), col = "blue", main = "compare cauchy D0"); lines(density(rcauchy(n=18, location = 0.11812807, scale = 0.08030487)), col = "red")


fitdistr(j7Tr$J7*1000, "cauchy") # 0.03771442 0.04051785
plot(density(j7Tr$J7*1000), col = "blue", main = "compare cauchy D7"); lines(density(rcauchy(n=18, location = 0.03771442, scale = 0.04051785)), col = "red")

fitdistr(winsorize(j90Tr$J90)*1000, "cauchy") # 0.045735156 0.021744474
plot(density(winsorize(j90Tr$J90)*1000), col = "blue", main = "compare cauchy D90"); lines(density(rcauchy(n=18, location = 0.045735156, scale = 0.021744474)), col = "red")


######################################################
# Testing to solve power calculations for d0-d7

n.wilcox.ord(power = 0.8, alpha = 0.05, t, p, q)
#library('samplesize')

n.wilcox.ord(power = 0.11, alpha = 0.05, t = 1, p, q)

######################################################



