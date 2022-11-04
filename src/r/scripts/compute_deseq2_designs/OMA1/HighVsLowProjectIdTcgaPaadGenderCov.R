ddss <- DESeqDataSet(
  dds[, colData(dds)$project_id %in% "TCGA-PAAD"],
  design = ~ gender + OMA1_group_by_project_id
)

ddss <- DESeq(ddss)

ddssr <- lfcShrink(
  ddss,
  coef = "OMA1_group_by_project_id_high_vs_low",
  type = "apeglm"
)
