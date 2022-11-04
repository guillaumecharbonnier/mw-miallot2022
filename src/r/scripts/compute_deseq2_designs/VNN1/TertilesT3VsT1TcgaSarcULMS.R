# This script should be sourced from
# src/r/scripts/compute_deseq2
ddss <- DESeqDataSet(
  dds[
    ,
    colData(dds)$project_id %in% "TCGA-SARC" &
    colData(dds)$paper_short_histo %in% "ULMS"
  ],
  design = ~ VNN1_tertiles_by_paper_short_histo
)

ddss <- DESeq(ddss)

ddssr <- lfcShrink(
  ddss,
  coef = "VNN1_tertiles_by_paper_short_histo_T3_vs_T1_vs_low",
  type = "apeglm"
)
