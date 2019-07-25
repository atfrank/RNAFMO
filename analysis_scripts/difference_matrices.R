pair_matrix <- function(PIEDA, term = "EIJ.EI.EJ", nfrags = 14){
  # reads in pieda output file created using Facio and writes out the matrix
  mat = matrix(NA, ncol = nfrags, nrow = nfrags)
  for (h in 1:nrow(PIEDA)){
    i =  PIEDA[h, "I"]
    j =  PIEDA[h, "J"]
    mat[i, j] = PIEDA[h, term]
    #mat[j, i] = PIEDA[h, term]
  }
  return(mat)
}

plot_difference <- function(mat_a, mat_b, label = ""){
  # plot difference matrix
  require(lattice)
  plotname = sprintf("%s: dE: %4.3f", label, sum(mat_a-mat_b, na.rm = TRUE))
  levelplot(mat_a-mat_b, las = 2, xlab = "Fragment I", ylab = "Fragment J", main = plotname, useRaster = FALSE, pretty = TRUE, at = seq(-40, 40, 5))
}


setwd("~/Desktop/FMO-test/")

names = c("I","J","DL","Z","R","Q","EIJ.EI.EJ","dDIJ*.VIJ","total","Ees","Eex","Ect+mix","Edisp","Gsol")
decoy_1 = read.table("~/Desktop/FMO-test/output_1_PIEDA_.out", col.names = names)
decoy_11 = read.table("~/Desktop/FMO-test/output_11_PIEDA_.out", col.names = names)
decoy_21 = read.table("~/Desktop/FMO-test/output_21_PIEDA_.out", col.names = names)
decoy_31 = read.table("~/Desktop/FMO-test/output_31_PIEDA_.out", col.names = names)

mat_1 = pair_matrix(decoy_1)
mat_11 = pair_matrix(decoy_11)
mat_21 = pair_matrix(decoy_21)
mat_31 = pair_matrix(decoy_31)


pdf(file = "dE_1_11.pdf", width = 4.5, height = 4.5, pointsize = 15)
plot_difference(mat_1, mat_11, label = "decoy 1 vs 11")
dev.off()

pdf(file = "dE_1_21.pdf", width = 4.5, height = 4.5, pointsize = 15)
plot_difference(mat_1, mat_21, label = "decoy 1 vs 11")
dev.off()

pdf(file = "dE_1_31.pdf", width = 4.5, height = 4.5, pointsize = 15)
plot_difference(mat_1, mat_31, label = "decoy 1 vs 11")
dev.off()
