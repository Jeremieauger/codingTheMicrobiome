z <- rep(c(0,1), rep(6,2))
par=(mfrow=c(1,2))
plot(z, c(before, after),
     xaxt="n", ylab="Response",
     xlab="", xlim=c(-0.5, 1.5))
axis(side=1, at=c(0,1), c("Before","After"))
segments(rep(0,6), before, rep(1,6), after, col=1)     

boxplot(before,after,names=c("Before","After"),ylab="Response")
