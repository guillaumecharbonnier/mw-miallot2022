ddss <- DESeqDataSet(
  dds[, colData(dds)$project_id %in% "TCGA-ESCA"],
  design = ~ gender + primary_diagnosis + VNN1_tertiles_by_project_id
)

ddss <- DESeq(ddss)

ddssr <- lfcShrink(
  ddss,
  coef = "VNN1_tertiles_by_project_id_T3_vs_T1_vs_low",
  type = "apeglm"
)
