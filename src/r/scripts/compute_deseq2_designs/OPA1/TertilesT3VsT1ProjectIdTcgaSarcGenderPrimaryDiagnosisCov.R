ddss <- DESeqDataSet(
  dds[, colData(dds)$project_id %in% "TCGA-SARC"],
  design = ~ gender + primary_diagnosis + OPA1_tertiles_by_project_id
)

ddss <- DESeq(ddss)

ddssr <- lfcShrink(
  ddss,
  coef = "OPA1_tertiles_by_project_id_T3_vs_T1_vs_low",
  type = "apeglm"
)
