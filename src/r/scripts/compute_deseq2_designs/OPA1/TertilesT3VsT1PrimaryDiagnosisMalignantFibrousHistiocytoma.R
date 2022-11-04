ddss <- DESeqDataSet(
  dds[, colData(dds)$primary_diagnosis %in% "Malignant fibrous histiocytoma"],
  design = ~ gender + OPA1_tertiles_by_primary_diagnosis
)

ddss <- DESeq(ddss)
# resultsNames(dds) # lists the coefficients

## ddssr means DeseqDataSubSetResult
ddssr <- lfcShrink(
  ddss,
  coef = "OPA1_tertiles_by_primary_diagnosis_T3_vs_T1",
  type = "apeglm"
)
