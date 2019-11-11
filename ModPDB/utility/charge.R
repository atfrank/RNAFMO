# hack to combine start and end of fragments with phosphate positions
f <- read.table("fragment_begins.txt")$V1
l <- read.table("fragment_ends.txt")$V1
p <- read.table("P_atoms.txt")$V1
d <- data.frame(f=f,l=l,p=0)
for (i in seq_along(p)){
  for (j in 1:nrow(d)){
    if ((p[i]>d$f[j]) && (p[i]<d$l[j])){d$p[j] = p[i]}
  }
}
write.table(d, file = "compare_P_and_end.txt", col.names = FALSE, row.names = FALSE, quote = FALSE)
