ddss <- DESeqDataSet(
  dds[, colData(dds)$primary_diagnosis %in% "Malignant peripheral nerve sheath tumor"],
  design = ~ gender + VNN1_tertiles_by_primary_diagnosis
)

ddss <- DESeq(ddss)
# resultsNames(dds) # lists the coefficients

## ddssr means DeseqDataSubSetResult
ddssr <- lfcShrink(
  ddss,
  coef = "VNN1_tertiles_by_primary_diagnosis_T3_vs_T1",
  type = "apeglm"
)
