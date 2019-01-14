
library(tidyverse)
zeep <- read_csv("zeep.csv")
zeep
zeep.pca <- prcomp(zeep, scale=TRUE)
pca.var <- zeep.pca$sdev^2
pca.var.per <- round(pca.var/sum(pca.var)*100, 1)
barplot(pca.var.per, main="Scree Plot", xlab="Principal Component", ylab="Percent Variation")


