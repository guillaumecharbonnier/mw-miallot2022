# This script should be called from
# snakemake rule r_compute_deseq2
log <- file(snakemake@log[[1]], open="wt")
sink(log)

library(DESeq2)

dds <- readRDS(snakemake@input[["dds"]])

source(
  paste0(
    "src/r/scripts/compute_deseq2_designs/",
    snakemake@wildcards[["design"]],
    ".R"
  )
)

saveRDS(
  object = ddss,
  file = snakemake@output[["ddss"]]
)

saveRDS(
  object = ddssr,
  file = snakemake@output[["ddssr"]]
)
