install.packages("jpeg")
library("jpeg")
sample1 <- readJPEG("C:/Users/Ahmad Abdel-Azim/Documents/Research/Maryam QS Exp/IMG_8733.JPG")
sample2 <- readJPEG("C:/Users/Ahmad Abdel-Azim/Documents/Research/Maryam QS Exp/IMG_8734.JPG")

# Convert the 3D array to a matrix of #rrggbb values
sample1 <- as.raster(sample1)
sample2 <- as.raster(sample2)

# Create a count table
tab1 <- table(sample1)
tab2 <- table(sample2)

# Convert to a data.frame
tab1 <- data.frame(Color = names(tab1), Count = as.integer(tab1))
tab2 <- data.frame(Color = names(tab2), Count = as.integer(tab2))

# Extract red/green/blue values
RGB1 <- t(col2rgb(tab1$Color))
RGB2 <- t(col2rgb(tab2$Color))

tab1 <- cbind(tab1, RGB1)
tab2 <- cbind(tab2, RGB2)

# Preview
head(tab1)
head(tab2)

# Weighted mean of colors (return average values of RGB for each pixel)
values1 <- data.frame(pixel.intens = c(
  weighted.mean(tab1$red, tab1$Count),
  weighted.mean(tab1$green, tab1$Count),
  weighted.mean(tab1$blue, tab1$Count)
), row.names = c("Red", "Green", "Blue"))

values2 <- data.frame(pixel.intens = c(
  weighted.mean(tab2$red, tab2$Count),
  weighted.mean(tab2$green, tab2$Count),
  weighted.mean(tab2$blue, tab2$Count)
), row.names = c("Red", "Green", "Blue"))

# Plotting RGB in barplot
par(mfrow = c(1,2))
barplot(values1$pixel.intens, col = c("red","green","blue"), main = "IMG_8733.JPG", 
        names.arg = c("Red", "Green", "Blue"), ylab = "Pixel Intensity")

barplot(values2$pixel.intens, col = c("red","green","blue"), main = "IMG_8734.JPG", 
        names.arg = c("Red", "Green", "Blue"), ylab = "Pixel Intensity")


countPixels <- function(img) {
  read <- readJPEG(img)
  
  # Convert the 3D array to a matrix of #rrggbb values
  read <- as.raster(read)
  
  # Create a count table
  tab <- table(read)
  
  # Convert to a data.frame
  tab <- data.frame(Color = names(tab), Count = as.integer(tab))
  
  # Extract red/green/blue values
  RGB <- t(col2rgb(tab$Color))
  
  tab <- cbind(tab, RGB)
  
  # Weighted mean of colors (return average values of RGB for each pixel)
    R <- weighted.mean(tab$red, tab$Count)
    G <- weighted.mean(tab$green, tab$Count)
    B <- weighted.mean(tab$blue, tab$Count)
    Avg <- mean(c(R, G, B))
  
  return(c(R, G, B, Avg)) 
}



times <- c('0000', '0030', '0060', '0090', '0120', '0150', '0180', '0240', '0270', '0330', '0390', '0690', '0720', '0780', 
           '0840', '0930', '1020', '1140', '1260', '1380', '1530', '2250', '2490', '2640')
files <- list.files("C:/Users/Ahmad Abdel-Azim/Documents/Research/Maryam QS Exp/Pics/Trial 1 (R)")

#read 1mL pics
df1 = data.frame(R = 0, G = 0, B = 0, Avg = 0, Time = 0, Rep = 0)

for (i in times) {
  pic = paste0("s_", i)
  pic = paste0(pic, "_1mL_*")
  pic <- files[grep(pattern = pic, x = files)]
  print(pic)
  x <- data.frame(R = 0, G = 0, B = 0, Avg = 0, Time = 0, Rep = 0)
  for (j in 1:length(pic)) {
    y <- countPixels(paste0("C:/Users/Ahmad Abdel-Azim/Documents/Research/Maryam QS Exp/Pics/Trial 1 (R)/", pic[j]))
    x <- rbind(x, data.frame(R = y[1], G = y[2], B = y[3], Avg = y[4], Time = i, Rep = j))
    x <- x[x$R > 0,]
  }
  df1 <- rbind(df1, x)
}
df1 <- df1[df1$R > 0,]
df1[,7] <- 1
colnames(df1)[which(names(df1) == "V7")] <- "Volume"


# read 3mL pics
df3 = data.frame(R = 0, G = 0, B = 0, Avg = 0, Time = 0, Rep = 0)

for (i in times) {
  pic = paste0("s_", i)
  pic = paste0(pic, "_3mL_*")
  pic <- files[grep(pattern = pic, x = files)]
  print(pic)
  x <- data.frame(R = 0, G = 0, B = 0, Avg = 0, Time = 0, Rep = 0)
  for (j in 1:length(pic)) {
    y <- countPixels(paste0("C:/Users/Ahmad Abdel-Azim/Documents/Research/Maryam QS Exp/Pics/Trial 1 (R)/", pic[j]))
    x <- rbind(x, data.frame(R = y[1], G = y[2], B = y[3], Avg = y[4], Time = i, Rep = j))
    x <- x[x$R > 0,]
  }
  df3 <- rbind(df3, x)
}
df3 <- df3[df3$R > 0,]
df3[,7] <- 3
colnames(df3)[which(names(df3) == "V7")] <- "Volume"


#read 5mL pics
df5 = data.frame(R = 0, G = 0, B = 0, Avg = 0, Time = 0, Rep = 0)

for (i in times) {
  pic = paste0("s_", i)
  pic = paste0(pic, "_5mL_*")
  pic <- files[grep(pattern = pic, x = files)]
  print(pic)
  x <- data.frame(R = 0, G = 0, B = 0, Avg = 0, Time = 0, Rep = 0)
  for (j in 1:length(pic)) {
    y <- countPixels(paste0("C:/Users/Ahmad Abdel-Azim/Documents/Research/Maryam QS Exp/Pics/Trial 1 (R)/", pic[j]))
    x <- rbind(x, data.frame(R = y[1], G = y[2], B = y[3], Avg = y[4], Time = i, Rep = j))
    x <- x[x$R > 0,]
  }
  df5 <- rbind(df5, x)
}
df5 <- df5[df5$R > 0,]
df5[,7] <- 5
colnames(df5)[which(names(df5) == "V7")] <- "Volume"


df <- rbind(df1, df3, df5)
View(df[order(df$Time),])


#plotting
pts1 <- tapply(df1$Avg, df1$Time, mean)
pts3 <- tapply(df3$Avg, df3$Time, mean)
pts5 <- tapply(df5$Avg, df5$Time, mean)

plot(pts1, pch = 16, col = "blue", cex = 1.5, ylim = c(0, 255))
lm.1 <- lm(Avg ~ poly(Time, 2), df1)
lines(predict(lm.1), col = "blue", type = "l", lwd = 4, lty = 1)

points(pts3, pch = 16, col = "black", cex = 1.5)
lm.3 <- lm(Avg ~ poly(Time, 2), df3)
lines(predict(lm.3), col = "black", type = "l", lwd = 4, lty = 1)

points(pts5, pch = 16, col = "green", cex = 1.5)
lm.5 <- lm(Avg ~ poly(Time, 2), df5)
lines(predict(lm.5), col = "green", type = "l", lwd = 4, lty = 1)





## Examining trends in quorum sensing 
# 1mL
plot(as.numeric(df1$Time)[as.numeric(df1$Time) < 390], df1$Avg[as.numeric(df1$Time) < 390], pch = 16, col = "blue", cex = 1.5, ylab = "Average RGB Value", xlab = "Time (minutes)")
plot(as.numeric(df1$Time)[as.numeric(df1$Time) < 390], log(df1$Avg[as.numeric(df1$Time) < 390]), pch = 16, col = "blue", cex = 1.5, ylab = "Average RGB Value", xlab = "Time (minutes)")
lm.1log <- lm(log(df1$Avg[as.numeric(df1$Time) < 390]) ~ as.numeric(df1$Time)[as.numeric(df1$Time) < 390])
abline(a = 3.199713, b = 0.006146, col = "black", lwd = 4, lty = 3)

plot(as.numeric(df1$Time)[as.numeric(df1$Time) < 390], resid(lm.1log), pch = 16, col = "black", cex = 1.2, ylab = "Residuals", xlab = "Time (minutes)")
abline(0,0, lwd = 2, lty = 1)

# 3mL
plot(as.numeric(df3$Time)[as.numeric(df3$Time) < 1020], df3$Avg[as.numeric(df3$Time) < 1020], pch = 16, col = "orange", cex = 1.5, ylab = "Average RGB Value", xlab = "Time (minutes)")
plot(as.numeric(df3$Time)[as.numeric(df3$Time) < 1020], log(df3$Avg[as.numeric(df3$Time) < 1020]), pch = 16, col = "orange", cex = 1.5, ylab = "Average RGB Value", xlab = "Time (minutes)")
lm.3log <- lm(log(df3$Avg[as.numeric(df3$Time) < 1020]) ~ as.numeric(df3$Time)[as.numeric(df3$Time) < 1020])
abline(a = 2.804562, b = 0.002705, col = "black", lwd = 4, lty = 3)

plot(as.numeric(df3$Time)[as.numeric(df3$Time) < 1020], resid(lm.3log), pch = 16, col = "black", cex = 1.2, ylab = "Residuals", xlab = "Time (minutes)")
abline(0,0, lwd = 2, lty = 1)

# 5mL
plot(as.numeric(df5$Time)[as.numeric(df5$Time) < 1260], df5$Avg[as.numeric(df5$Time) < 1260], pch = 16, col = "green", cex = 1.5, ylab = "Average RGB Value", xlab = "Time (minutes)")
plot(as.numeric(df5$Time)[as.numeric(df5$Time) < 1260], log(df5$Avg[as.numeric(df5$Time) < 1260]), pch = 16, col = "green", cex = 1.5, ylab = "Average RGB Value", xlab = "Time (minutes)")
lm.5log <- lm(log(df5$Avg[as.numeric(df5$Time) < 1260]) ~ as.numeric(df5$Time)[as.numeric(df5$Time) < 1260])
abline(a = 2.658345, b = 0.002244, col = "black", lwd = 4, lty = 3)

plot(as.numeric(df5$Time)[as.numeric(df5$Time) < 1260], resid(lm.5log), pch = 16, col = "black", cex = 1.2, ylab = "Residuals", xlab = "Time (minutes)")
abline(0,0, lwd = 2, lty = 1)





