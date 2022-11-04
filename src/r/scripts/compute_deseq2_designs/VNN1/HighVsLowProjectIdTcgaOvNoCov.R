ddss <- DESeqDataSet(
  dds[, colData(dds)$project_id %in% "TCGA-OV"],
  design = ~ VNN1_group_by_project_id
)

ddss <- DESeq(ddss)

ddssr <- lfcShrink(
  ddss,
  coef = "VNN1_group_by_project_id_high_vs_low",
  type = "apeglm"
)
