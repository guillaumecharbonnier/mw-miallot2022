ddss <- DESeqDataSet(
  dds[, colData(dds)$project_id %in% "TCGA-MESO"],
  design = ~ gender + primary_diagnosis + OMA1_group_by_project_id
)

ddss <- DESeq(ddss)

ddssr <- lfcShrink(
  ddss,
  coef = "OMA1_group_by_project_id_high_vs_low",
  type = "apeglm"
)
