
nVals = seq(100, 500, by = 100)
distTypes = c("gaussian", "t1", "t5")

result <- NULL
for (n in nVals) {
  for (dist in distTypes) {
    oFile <- paste("n", n, "dist", dist, ".txt", sep = "")
    dat <- as.matrix(read.table(oFile, header = TRUE))
    dat <- rbind(c(n, "PrimeAvg", dat[1], dist), c(n, "SampAvg", dat[2], dist))
    result <- rbind(result, dat)
  }
}

library(tidyr)
Table <- as.data.frame(result)
colnames(Table) <- c("n", "Method", "MSE", "Dist")
Table <- spread(Table, Dist, MSE)
print(Table[, c(1, 2, 3, 5, 4)])

