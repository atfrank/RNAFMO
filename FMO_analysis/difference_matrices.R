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
  levelplot(mat_a-mat_b, las = 2, xlab = "Fragment I", ylab = "Fragment J", main = plotname, useRaster = FALSE, pretty = TRUE, at = seq(-40, 40, 5), col.regions = cols2 <- colorRampPalette(c("red","white", "blue"))(256))
}


setwd("~/Desktop/FMO-test/colleen/")

names = c("I","J","DL","Z","R","Q","EIJ.EI.EJ","dDIJ*.VIJ","total","Ees","Eex","Ect+mix","Edisp","Gsol")
decoys = list()
mats = list()

for (i in 1:6){
  decoys[[i]] = read.table(sprintf("2KOC_%s_PIEDA.out", i), col.names = names)
  mats[[i]] = pair_matrix(decoys[[i]] )
}

for (i in 2:6){
  pdf(file = sprintf("dE_1_%s.pdf", i), width = 4.5, height = 4.5, pointsize = 15)
  print(plot_difference(mats[[1]], mats[[i]], label = sprintf("decoy 1 vs %s", i)))
  dev.off()
}
