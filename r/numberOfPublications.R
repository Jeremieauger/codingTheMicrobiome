library('yarrr')

microbiomePubliPerYear <- read_csv("~/Github/codingTheMicrobiome/data/microbiomePubliPerYear.csv")


par(las=-2)
pirateplot(formula = Number ~ Year,
           data = subset(microbiomePubliPerYear, Year > 1989),
           xlab = "Year",
           ylab = "Number of publications",
           main = "Publications indexed with \"Microbiome\" \n in pubmed by year",  
           bar.f.o = 0.3, bar.b.o = 1,
           pal = "blue")


pirateplot(-log10(Ratio) ~ Time, data = DFLM18, avg.line.fun = median,
           ylab = "Normalised Counts (log10)", main = main, point.cex = 2,
           bar.f.o = 0.7, bar.b.o = 1, bean.f.o = 0.0, bean.b.o = 0,
           hdi.iter = 0)




