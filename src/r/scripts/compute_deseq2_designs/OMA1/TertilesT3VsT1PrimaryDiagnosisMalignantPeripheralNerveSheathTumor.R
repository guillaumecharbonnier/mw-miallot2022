ddss <- DESeqDataSet(
  dds[, colData(dds)$primary_diagnosis %in% "Malignant peripheral nerve sheath tumor"],
  design = ~ gender + OMA1_tertiles_by_primary_diagnosis
)

ddss <- DESeq(ddss)
# resultsNames(dds) # lists the coefficients

## ddssr means DeseqDataSubSetResult
ddssr <- lfcShrink(
  ddss,
  coef = "OMA1_tertiles_by_primary_diagnosis_T3_vs_T1",
  type = "apeglm"
)
