# This script should be sourced from
# src/r/scripts/compute_deseq2
ddss <- DESeqDataSet(
  dds[
    ,
    colData(dds)$project_id %in% "TCGA-SARC" &
    colData(dds)$paper_short_histo %in% "ULMS"
  ],
  design = ~ OPA1_group_by_paper_short_histo
)

ddss <- DESeq(ddss)

ddssr <- lfcShrink(
  ddss,
  coef = "OPA1_group_by_paper_short_histo_high_vs_low",
  type = "apeglm"
)
