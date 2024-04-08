
# Result Plot with no custom window

par(mar=c(0,5,1,1))
layout(matrix(c(1,2), 2, 1, byrow = TRUE), widths=c(1,1), heights=c(1,1.25))

plot(Picard1_standardized, type = "l", ylim = c(-10, 15), xlim = c(150, 1300), axes = FALSE, xaxt = "n", yaxt = "n", 
     xlab = "Picard1 Depth (metres)", ylab = "Gamma Ray (gAPI)", cex.lab = 1.25)
lines(Bounty1_on_Picard1_depth, col = "red")
axis(2, at = c(-10,0,10), cex.axis = 1.25, las = 1)
legend("topright", legend = c("Picard-1", "Bounty-1", "Minilya-1"), col = c("black", "red", "blue"), lty = 1, cex = 1.5, bty = "n")

par(mar=c(5,5,0,1))

plot(Picard1_standardized, type = "l", ylim = c(-10, 15), xlim = c(150, 1300), axes = FALSE, yaxt = "n", 
     xlab = "Picard1 Depth (metres)", ylab = "Gamma Ray  (gAPI)", cex.lab = 1.25)
lines(Minilya1_on_Picard1_depth, col = "blue")
axis(1, at = c(150,200,400,600,800,1000,1200,1320), cex.axis = 1.25, las = 1)
axis(2, at = c(-10,0,10), cex.axis = 1.25, las = 1)


# Result Plot with custom window 

par(mar=c(0,5,1,1))
layout(matrix(c(1,2), 2, 1, byrow = TRUE), widths=c(1,1), heights=c(1,1.25))

plot(Picard1_standardized, type = "l", ylim = c(-10, 15), xlim = c(150, 1300), axes = FALSE, xaxt = "n", yaxt = "n", 
     xlab = "Picard1 Depth (metres)", ylab = "Gamma Ray (gAPI)", cex.lab = 1.25)
lines(Bounty1_on_Picard1_depth_CW, col = "red")
axis(2, at = c(-10,0,10), cex.axis = 1.25, las = 1)
legend("topright", legend = c("Picard-1", "Bounty-1", "Minilya-1"), col = c("black", "red", "blue"), lty = 1, cex = 1.5, bty = "n")

par(mar=c(5,5,0,1))

plot(Picard1_standardized, type = "l", ylim = c(-10, 15), xlim = c(150, 1300), axes = FALSE, yaxt = "n", 
     xlab = "Picard1 Depth (metres)", ylab = "Gamma Ray  (gAPI)", cex.lab = 1.25)
lines(Minilya1_on_Picard1_depth_CW, col = "blue")
axis(1, at = c(150,200,400,600,800,1000,1200,1320), cex.axis = 1.25, las = 1)
axis(2, at = c(-10,0,10), cex.axis = 1.25, las = 1)
