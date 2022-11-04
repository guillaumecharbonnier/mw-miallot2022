ddss <- DESeqDataSet(
  dds[, colData(dds)$primary_diagnosis %in% "Malignant fibrous histiocytoma"],
  design = ~ gender + OPA1_group_by_primary_diagnosis
)

ddss <- DESeq(ddss)
# resultsNames(dds) # lists the coefficients

## ddssr means DeseqDataSubSetResult
ddssr <- lfcShrink(
  ddss,
  coef = "OPA1_group_by_primary_diagnosis_high_vs_low",
  type = "apeglm"
)
