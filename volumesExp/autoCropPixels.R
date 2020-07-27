install.packages("GA")
library(GA)

install.packages("magick")
library(magick)
tt3 <- image_read("C:/Users/Ahmad Abdel-Azim/Documents/Research/Maryam QS Exp/Pics/(final)Trial_1_3TT/time_0690/IMG_8835.JPG")
print(tt3)

# image_crop(tt3, "100x150+50+70") #crop out width:100px and height:150px starting +50px from the left
# image_rotate(tt3, 45) # rotate image 45 degrees clockwise

image_write(tt3, path = "C:/Users/Ahmad Abdel-Azim/Documents/Research/Maryam QS Exp/tt3.JPG", format = "JPG")

install.packages("jpeg")
library(jpeg)
tt3.jpeg <- readJPEG("C:/Users/Ahmad Abdel-Azim/Documents/Research/Maryam QS Exp/tt3.JPG")
dim(tt3.jpeg)

maxRow <- tt3.jpeg[max(rowSums(tt3.jpeg)),]
maxRow_index <- which(rowSums(tt3.jpeg) == max(rowSums(tt3.jpeg))) # 1611
plot(smooth.spline(maxRow, spar=0.5))
smoothPeaks <- predict(smooth.spline(maxRow, spar=0.5), x = seq(from = 1, to = 5000, by = 0.1))
plot(smoothPeaks)

install.packages("quantmod")
library(quantmod)
maxtt = findPeaks(smoothPeaks$y, thr = 0)
maxtt3 = sort(smoothPeaks$y[maxtt], decreasing = TRUE)[1:3]
x <- 0; y <- 0
for(i in 1:3){
  x[i] <- smoothPeaks$x[smoothPeaks$y == maxtt3[i]]
  y[i] <- maxtt3[i]
}
points(x, y, cex = 2)

x <- sort(x)

tt3 <- image_annotate(tt3, "1mL", size = 30, color = "red", location = paste0("+", x[1], "+", maxRow_index))
tt3 <- image_annotate(tt3, "3mL", size = 30, color = "red", location = paste0("+", x[2], "+", maxRow_index))
tt3 <- image_annotate(tt3, "5mL", size = 30, color = "red", location = paste0("+", x[3], "+", maxRow_index))
tt3


# Random rectangles to optimize
tt1 <- image_read("C:/Users/Ahmad Abdel-Azim/Documents/Research/Maryam QS Exp/tt1.jpg")
tt1.jpeg <- readJPEG("C:/Users/Ahmad Abdel-Azim/Documents/Research/Maryam QS Exp/tt1.jpg")
tt1.jpeg <- tt1.jpeg[,,1]
dim(tt1.jpeg)

# Top left: 656, 1332
# Bottom right: 872,1456
# Width = 216, height = 124

tt1.jpeg <- round(tt1.jpeg)
tt1.jpeg[tt1.jpeg == 0] = -1

rect <- 0
for(i in 1:2026){
  for(j in 1:780){
    rect[(780*(i-1) + j)] <- sum(tt1.jpeg[i:(i+124), j:(j+216)])
  }
}
1337*780 < 1042739
780-(1337*780-1042739)

#1337,659 --> PERFECT!!!! (3 pixels off of my prediction, but probably more right than me)


tt1.jpeg <- as.data.frame(tt1.jpeg)
optFitness <- function(dx= 50, dy= 50) sum(tt1.jpeg[1337:(1337+dy), 659:(659+dx)])
GA <- ga(type = "real-valued", 
         fitness =  optFitness,
         lower = c(-658, -1336), upper = c(337, 813), 
         popSize = 50, maxiter = 1000, run = 100)

plot(GA)
summary(GA)
summary(GA)
# -- Genetic Algorithm ------------------- 
#   
#   GA settings: 
#   Type                  =  real-valued 
# Population size       =  50 
# Number of generations =  1000 
# Elitism               =  2 
# Crossover probability =  0.8 
# Mutation probability  =  0.1 
# Search domain = 
#   x1    x2
# lower -658 -1336
# upper  337   813
# 
# GA results: 
#   Iterations             = 107 
# Fitness function value = 18589 
# Solutions = 
#   x1         x2
# [1,] 214.0523  147.82985
# [2,] 214.0551  -88.95236
# [3,] 214.0893   83.50347
# [4,] 214.1638   40.04396
# [5,] 214.0266 -134.62079


# 659 - 783
# 1337 - 1484, 1248 - 1337, 1337 - 1421, 1202 - 1337




library(imager)
library(ggplot2)
library(dplyr)
rbinom(100*100,1,.001) %>% as.cimg(x=100,y=100)
blobs <- isoblur(points,5)

