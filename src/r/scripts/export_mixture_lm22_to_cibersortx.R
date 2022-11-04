log <- file(snakemake@log[[1]], open="wt")
sink(log)

library(DESeq2)
library(data.table)

vsd <- readRDS(snakemake@input[["vsd"]])

lm22 <- fread(readRDS(snakemake@input[["lm22"]])

# Cibersortx provides limited storage so values are rounded
# and only the genes in the signature matrix are kept
d <- data.table(
  GeneSymbol = rowData(vsd)$hugo_symbol,
  round(
    assay(vsd),
    digits = 3
  )
)

d <- d[GeneSymbol %in% lm22$`Gene symbol`]

fwrite(
  x = d,
  file = snakemake@output[["tsv"]],
  sep = "\t"
)
