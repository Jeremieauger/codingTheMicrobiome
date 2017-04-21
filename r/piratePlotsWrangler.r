Call:

	lm(formula = expected_count ~ day, data = foxCo2DF)

	Residuals:
	   Min     1Q Median     3Q    Max 
	-72856 -37810 -24860  -4182 788841 

	Coefficients:
				Estimate Std. Error t value Pr(>|t|)   
	(Intercept)    72866      25986   2.804  0.00737 **
	day            -5098       5250  -0.971  0.33656   
	---
	Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

	Residual standard error: 127300 on 46 degrees of freedom
	Multiple R-squared:  0.02009,	Adjusted R-squared:  -0.001212 
	F-statistic: 0.9431 on 1 and 46 DF,  p-value: 0.3366




par(mfrow=c(1,4), cex.main = 2)
pirateplot(formula = log(expected_count) ~ day, avg.line.fun = median, 
           hdi.iter = 0, 
           data = mebCo2DF, 
           main = "Aérobique - Sans Atb")

pirateplot(formula = log(expected_count) ~ day, avg.line.fun = median,  
           hdi.iter = 0,
           data = foxCo2DF,
           main = "Aérobique - Céfoxitine")

pirateplot(formula = log(expected_count) ~ day, avg.line.fun = median,  
           hdi.iter = 0,
           data = mebAnaDF,
           main = "Anaérobique - Sans Atb")

pirateplot(formula = log(expected_count) ~ day, avg.line.fun = median,  
           hdi.iter = 0,
           data = foxAnaDF,
           main = "Anaérobique - Céfoxitine")


pal=piratepal("southpark")
pirateplot(formula = log(expected_count) ~ day, avg.line.fun = median,
           data = foxAnaDF,
           pal = pal
           main = "Anaérobique - Céfoxitine")




> wilcox.test(subset(foxCo2DF, day == "0")$expected_count, 
+             subset(foxCo2DF, day == "7")$expected_count,
+             paired = TRUE)

		Wilcoxon signed rank test
	V = 194, p-value = 0.2182
	alternative hypothesis: true location 
	shift is not equal to 0



> wilcox.test(subset(rsemExpect, day == 0 & treatment == 1)$expected_count, 
+             subset(rsemExpect, day == 7 & treatment == 1)$expected_count, 
+             paired = TRUE)

	Wilcoxon signed rank test with continuity correction
			V = 99, p-value = 0.2977
			alternative hypothesis: true location shift is not equal to 0




### Making the comparative plots in pirate plots
par(mfrow=c(1,1))
### Ray
elenQte <- read.csv("~/GitHub/codingTheMicrobiome/r/elenQte_FromRay.csv")
library(reshape)
stackedDF <- melt(elenQte, id=c("ID", "Treatment"))
colnames(stackedDF) <- c('Patient0', 'Treatment', 'Time', 'Ratio')
pirateplot(formula = log(Ratio) ~ Time + Treatment, avg.line.fun = median, 
           hdi.iter = 0,
           data = stackedDF, 
           main = "Ray-Meta")
### BWA
DFLM <- read.csv("~/GitHub/codingTheMicrobiome/r/bwaForLm.csv")
pirateplot(formula = log(Ratio) ~ Time + Treatment, avg.line.fun = median, 
           hdi.iter = 0,
           data = DFLM, 
           main = "Burrows-Wheeler Aligner")

### RSEM - TPM + expect
rsemDF <- read.csv("~/GitHub/codingTheMicrobiome/data/rsemDF.csv")
# sample patient day treatment age sex expected_count     TPM FPKM
par(mfrow=c(1,1))
pirateplot(formula = log(TPM) ~ day + treatment, avg.line.fun = median, 
           hdi.iter = 0,
           data = rsemDF, 
           main = "Transcripts Per Million (TPM)")

pirateplot(formula = log(expected_count) ~ day + treatment, avg.line.fun = median, 
           hdi.iter = 0,
           data = rsemDF, 
           main = "Expected Count")






pirateplot(formula = log(expected_count) ~ day, avg.line.fun = median, 
           hdi.iter = 0,
           data = subset(rsemDF, treatment == 1),
           main = "Expected Count")



> pirateplot(formula = log(expected_count) ~ day, avg.line.fun = median, 
+            data = subset(rsemDF, treatment == 1),
+            main = "RSEM\nExpected Count", xlab = "Temps (jours)")





