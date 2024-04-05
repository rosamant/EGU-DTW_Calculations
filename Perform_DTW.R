# Import packages

library(dtw)
library(DescTools)
library(astrochron)

# Import Picard1 and Minilya1 datasets

# Import datasets Picard1 and Minilya1
Picard1 <- read.csv("path/to/PICARD 1.csv", header=TRUE, stringsAsFactors=FALSE)
Minilya1 <- read.csv("path/to/Minilya_1.csv", header=TRUE, stringsAsFactors=FALSE)

# Data selection: limit datasets to the required depth range
Picard1 = Picard1[c(83:7750),] # Data required till Eocene-Miocene Unconformity
Minilya1 = Minilya1[c(1:5613),] # Data required till Eocene-Miocene Unconformity

#### Rescaling and resampling of the data ####

# Linear interpolation of datasets
Picard1_interpolated <- linterp(Picard1, dt = 0.2, genplot = F)
Minilya1_interpolated <- linterp(Minilya1, dt = 0.2, genplot = F)

# Scaling the data
Pmean = Gmean(Picard1_interpolated$GR)
Pstd = Gsd(Picard1_interpolated$GR)
Picard1_scaled = (Picard1_interpolated$GR - Pmean)/Pstd
Picard1_rescaled = data.frame(Picard1_interpolated$DEPT, Picard1_scaled)

Mmean = Gmean(Minilya1_interpolated$GR)
Mstd = Gsd(Minilya1_interpolated$GR)
Minilya1_scaled = (Minilya1_interpolated$GR - Mmean)/Mstd
Minilya1_rescaled = data.frame(Minilya1_interpolated$DEPT, Minilya1_scaled)

# Resampling the data using moving window statistics
Picard1_scaled = mwStats(Picard1_rescaled, cols = 2, win = 3)
Picard1_standardized = data.frame(Picard1_scaled$Center_win, Picard1_scaled$Average)

Minilya1_scaled = mwStats(Minilya1_rescaled, cols = 2, win = 3)
Minilya1_standardized = data.frame(Minilya1_scaled$Center_win, Minilya1_scaled$Average)

# Plotting the rescaled and resampled data
plot(Picard1_standardized, type="l", xlim = c(150, 1300), ylim = c(-20, 20), xlab = "Picard1 Resampled Depth", ylab = "Normalized GR")
plot(Minilya1_standardized, type="l", xlim = c(150, 1100), ylim = c(-20, 20), xlab = "Minilya1 Resampled Depth", ylab = "Normalized GR")

#### DTW with custom step pattern asymmetricP1.1 but no custom window ####

# Perform dtw
system.time(al_m1_p1_ap1 <- dtw(Minilya1_standardized$Minilya1_scaled.Average, Picard1_standardized$Picard1_scaled.Average, keep.internals = T, step.pattern = asymmetricP1.1, open.begin = T, open.end = T))
plot(al_m1_p1_ap1, "threeway")

# Tuning the standardized data on reference depth scale
Minilya1_on_Picard1_depth = tune(Minilya1_standardized, cbind(Minilya1_standardized$Minilya1_scaled.Center_win[al_m1_p1_ap1$index1s], Picard1_standardized$Picard1_scaled.Center_win[al_m1_p1_ap1$index2s]), extrapolate = F)

dev.off()

# Plotting the data

plot(Picard1_standardized, type = "l", ylim = c(-20, 20), xlim = c(150, 1300), xlab = "Picard1 Resampled Depth", ylab = "Normalized GR")
lines(Minilya1_on_Picard1_depth, col = "red")

# DTW Distance measure
al_m1_p1_ap1$normalizedDistance
al_m1_p1_ap1$distance


#### DTW with custom step pattern asymmetricP1.1 and custom window ####

# create matrix for the custom window

compare.window <- matrix(data=TRUE,nrow=nrow(Minilya1_standardized),ncol=nrow(Picard1_standardized))
image(x=Picard1_standardized[,1],y=Minilya1_standardized[,1],z=t(compare.window),useRaster=TRUE)

# Assigning stratigraphic depth locations for reference and query sites

# Depth values for first datum
base_1_x <- Closest(370, Picard1_standardized[,1],which=TRUE)
base_1_y <- Closest(320, Minilya1_standardized[,1],which=TRUE)

# Depth values for second datum
base_2_x <- Closest(430, Picard1_standardized[,1],which=TRUE)
base_2_y <- Closest(365, Minilya1_standardized[,1],which=TRUE)

# Depth values for third datum
base_3_x <- Closest(545, Picard1_standardized[,1],which=TRUE)
base_3_y <- Closest(480, Minilya1_standardized[,1],which=TRUE)

# Depth values for fourth datum
base_4_x <- Closest(1010, Picard1_standardized[,1],which=TRUE)
base_4_y <- Closest(810, Minilya1_standardized[,1],which=TRUE)

# Depth values for fifth datum
base_5_x <- Closest(1190, Picard1_standardized[,1],which=TRUE)
base_5_y <- Closest(940, Minilya1_standardized[,1],which=TRUE)

# Assigning depth uncertainty "slack" to the tie-points

# Create a matrix to store the comparison window
compare.window <- matrix(data = TRUE, nrow = nrow(Minilya1_standardized), ncol = nrow(Picard1_standardized))

# Slack provided based on specific indices 

compare.window[(base_1_y+300):nrow(Minilya1_standardized),1:(base_1_x-300)] <- 0
compare.window[1:(base_1_y-300),(base_1_x+300):ncol(compare.window)] <- 0

compare.window[(base_2_y+400):nrow(Minilya1_standardized),1:(base_2_x-400)] <- 0
compare.window[1:(base_2_y-300),(base_2_x+300):ncol(compare.window)] <- 0

compare.window[(base_3_y+400):nrow(Minilya1_standardized),1:(base_3_x-400)] <- 0
compare.window[1:(base_3_y-300),(base_3_x+300):ncol(compare.window)] <- 0

compare.window[(base_4_y+400):nrow(Minilya1_standardized),1:(base_4_x-400)] <- 0
compare.window[1:(base_4_y-300),(base_4_x+300):ncol(compare.window)] <- 0

compare.window[(base_5_y+500):nrow(Minilya1_standardized),1:(base_5_x-500)] <- 0
compare.window[1:(base_5_y-400),(base_5_x+400):ncol(compare.window)] <- 0

# Visualize the comparison window
image(x=Picard1_standardized[,1],y=Minilya1_standardized[,1],z=t(compare.window),useRaster=TRUE)

# Convert the comparison window matrix to logical values
compare.window <- sapply(as.data.frame(compare.window), as.logical)
compare.window <- unname(as.matrix(compare.window))

image(x=Picard1_standardized[,1],y=Minilya1_standardized[,1],z=t(compare.window),useRaster=TRUE)

# Define a custom window function for use in DTW
win.f <- function(iw,jw,query.size, reference.size, window.size, ...) compare.window >0

# Perform dtw with custom window
system.time(al_m1_p1_ap1 <- dtw(Minilya1_standardized$Minilya1_scaled.Average, Picard1_standardized$Picard1_scaled.Average, keep.internals = T, step.pattern = asymmetricP1.1, window.type = win.f, open.end = T, open.begin = F))
plot(al_m1_p1_ap1, type = "threeway")

# Dtw Density plot (Custom Window Visualization)
plot(al_m1_p1_ap1, type = "density", xaxt = "n", yaxt = "n", xlab = "Minilya-1", ylab = "Picard-1", cex.lab = 1.25)
axis(1, at = c(113,1113,2113,3113,4113), labels = c(200,400,600,800,1000), cex.axis = 1.25)
axis(2, at = c(743,2243,3743,5243), labels = c(300,600,900,1200), cex.axis = 1.25)

# DTW Distance measure
al_m1_p1_ap1$normalizedDistance
al_m1_p1_ap1$distance

image(y = Picard1_standardized[,1], x = Minilya1_standardized[,1], z = compare.window, useRaster = T)
lines(Minilya1_standardized$Minilya1_scaled.Center_win[al_m1_p1_ap1$index1], Picard1_standardized$Picard1_scaled.Center_win[al_m1_p1_ap1$index2], col = "white", lwd = 2)

# Tuning the standardized data on reference depth scale
Minilya1_on_Picard1_depth = tune(Minilya1_standardized, cbind(Minilya1_standardized$Minilya1_scaled.Center_win[al_m1_p1_ap1$index1s], Picard1_standardized$Picard1_scaled.Center_win[al_m1_p1_ap1$index2s]), extrapolate = F)

dev.off()

# Plotting the data

plot(Picard1_standardized, type = "l", ylim = c(-20, 20), xlim = c(150, 1300), xlab = "Picard1 Resampled Depth", ylab = "Normalized GR (Minilya-1)")
lines(Minilya1_on_Picard1_depth, col = "red")

plot(Minilya1_on_Picard1_depth, type = "l", ylim = c(-20, 20), xlim = c(150, 1300), xlab = "Picard1 Resampled Depth", ylab = "Minilya-1")
