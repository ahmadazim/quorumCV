## Load volume.1mL, volume.3mL, volume.5mL
load('./volume.xmL.R') 
load("C:/Users/Ahmad Abdel-Azim/Documents/Research/Maryam QS Exp/.RData")

# Average replicates across time
mean.1mL <- tapply(volume.1mL$illumin, volume.1mL$time, mean)
mean.1mL <- data.frame(time = as.numeric(names(mean.1mL)), illumin.mean = mean.1mL)
mean.3mL <- tapply(volume.3mL$illumin, volume.3mL$time, mean)
mean.3mL <- data.frame(time = as.numeric(names(mean.3mL)), illumin.mean = mean.3mL)
mean.5mL <- tapply(volume.5mL$illumin, volume.5mL$time, mean)
mean.5mL <- data.frame(time = as.numeric(names(mean.5mL)), illumin.mean = mean.5mL)

# Superimposed Plot
dev.off()
jpeg("C:/Users/Ahmad Abdel-Azim/Documents/Research/Maryam QS Exp/Science Fair Project/Fig.2.jpeg", units = "in", width = 9.5, height = 5, res = 500)

par(mar = c(5,4.5,4,8.2), xpd = T)
plot(mean.1mL$time, mean.1mL$illumin.mean, pch = 16, xlim=c(0, 6809), col = 'dodgerblue4', cex = 1.1, ylab = "Illumination Intensity (RGB value)", xlab = "Time (minutes)", ylim = c(1,200))
lines(smooth.spline(mean.1mL$time, mean.1mL$illumin.mean, spar = 0.45), lwd=4, col = 'dodgerblue4')
#points(volume.1mL$time, volume.1mL$illumin, xlim=c(0, 2000), col = 'dark green')

minor.tick(nx = 2, ny=5, tick.ratio=0.75)

points(mean.3mL$time, mean.3mL$illumin.mean, pch = 16, cex = 1.1, col = 'maroon')
lines(smooth.spline(mean.3mL$time, mean.3mL$illumin.mean, spar = 0.45), lwd=4, col = 'maroon')
#points(volume.3mL$time, volume.3mL$illumin, xlim=c(1640, 6809), col = 'dark green')

points(mean.5mL$time, mean.5mL$illumin.mean, pch = 16, cex = 1.1, col = 'seagreen3')
lines(smooth.spline(mean.5mL$time, mean.5mL$illumin.mean, spar = 0.45), lwd=4, col = 'seagreen3')
#points(volume.5mL$time, volume.5mL$illumin, xlim=c(3000, 6809), col = 'dark green')

legend(7500,150, pch = 16, lty = 1, lwd = 3, col = c("dodgerblue4", "maroon", "seagreen3"), 
       legend=c("1 mL", "3 mL", "5 mL"), cex = 1.1, pt.cex = 1.1, border = NA)
dev.off()


# Barplot of maximum illumination intensities
y <- c(72.5, 40.5, 9)
x <- c("5mL", "3mL", "1mL")

dev.off()
jpeg("C:/Users/Ahmad Abdel-Azim/Documents/Research/Maryam QS Exp/Science Fair Project/Fig.2.bar.jpeg", units = "in", width = 9.5, height = 3.5, res = 500)

par(mar = c(5,4,4,3), xpd = T)
barplot(y, names.arg = x, las = 1, cex.lab = 1.1, horiz = T, border = "black", col = c("seagreen3", "maroon", "dodgerblue4"), xlim = c(0, 80), xlab = "Time (hours)")
minor.tick(nx=5, ny=0, tick.ratio=0.75)
text(12.8, y=2.9, label = "9 hours", pos = 3, cex = 1.1, col = "black")
text(45.3, y=1.7, label = "40.5 hours", pos = 3, cex = 1.1, col = "black")
text(77.3, y=0.45, label = "72.5 hours", pos = 3, cex = 1.1, col = "black")
dev.off()



