ddss <- DESeqDataSet(
  dds[, colData(dds)$project_id %in% "TCGA-ESCA"],
  design = ~ gender + primary_diagnosis + OPA1_group_by_project_id
)

ddss <- DESeq(ddss)

ddssr <- lfcShrink(
  ddss,
  coef = "OPA1_group_by_project_id_high_vs_low",
  type = "apeglm"
)
