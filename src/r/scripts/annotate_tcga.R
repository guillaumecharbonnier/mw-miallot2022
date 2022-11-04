log <- file(snakemake@log[[1]], open="wt")
sink(log)

library(DESeq2)

dds <- readRDS(snakemake@input[["dds"]])

names(colData(dds)) <- gsub(
  " ",
  "_",
  names(colData(dds))
)

dds <- dds[, !is.na(colData(dds)$gender)]

factor_cols <- c(
  "gender",
  "primary_diagnosis",
  "paper_short_histo",
  "project_id",
  "state"
)

for (col in factor_cols) {
  colData(dds)[[col]] <- factor(colData(dds)[[col]])
}

dds <- DESeqDataSet(
  dds,
  design = ~ gender + primary_diagnosis
)

# hugo_symbol can be recognized by knitPostDeseq2Template()
colnames(rowData(dds)) <- sub(
  pattern = "^external_gene_name$",
  replacement = "hugo_symbol",
  x = colnames(rowData(dds))
)

# keep <- rowSums(counts(dds)) >= 10
keep <- rowSums(counts(dds)) > ncol(dds)
dds <- dds[keep, ]
vsd <- varianceStabilizingTransformation(dds, blind = TRUE)
rm(keep)

define_gene_high_low_group_by_key <- function(
  d = vsd,
  ensembl_gene_id = "ENSG00000112299",
  key = c(
    "released",
    "primary_diagnosis",
    "project_id",
    "paper_short_histo"
  )
) {
  median_by_key <- sapply(
    levels(colData(vsd)[[key]]),
    function(l) {
      median(
        assay(vsd)[
          rownames(vsd) %in% ensembl_gene_id,
          colData(vsd)[[key]] %in% l
        ]
      )
    }
  )
  gene_group_by_key <- factor(
    ifelse(
      assay(vsd)[rownames(vsd) == ensembl_gene_id, ] > median_by_key[colData(vsd)[[key]]],
      "high",
      "low"
    ),
    levels = c("low", "high")
  )
  return(gene_group_by_key)
}

define_gene_tertiles_by_key <- function(
  d = vsd,
  ensembl_gene_id = "ENSG00000112299",
  key = c(
    "released",
    "primary_diagnosis",
    "project_id",
    "paper_short_histo"
  )
) {
  tertile1_by_key <- sapply(
    levels(colData(vsd)[[key]]),
    function(l) {
      quantile(
        assay(vsd)[
          rownames(vsd) %in% ensembl_gene_id,
          colData(vsd)[[key]] %in% l
        ],
        1/3
      )
    }
  )
  tertile2_by_key <- sapply(
    levels(colData(vsd)[[key]]),
    function(l) {
      quantile(
        assay(vsd)[
          rownames(vsd) %in% ensembl_gene_id,
          colData(vsd)[[key]] %in% l
        ],
        2/3
      )
    }
  )
  gene_group_by_key <- factor(
    ifelse(
      test = assay(vsd)[rownames(vsd) == ensembl_gene_id, ] < tertile1_by_key[colData(vsd)[[key]]],
      yes = "T1",
      no = ifelse(
        test = assay(vsd)[rownames(vsd) == ensembl_gene_id, ] > tertile2_by_key[colData(vsd)[[key]]],
        yes = "T3",
        no = "T2"
      )
    ),
    levels = c("T1", "T2", "T3")
  )
  return(gene_group_by_key)
}

# Add annotations related to VNN1 expression level
keys <- c(
  "state",
  "primary_diagnosis",
  "project_id",
  "paper_short_histo"
)

for (key in keys) {
  colData(vsd)[[paste0("VNN1_group_by_", key)]] <- define_gene_high_low_group_by_key(key = key)

  colData(vsd)[[paste0("VNN1_tertiles_by_", key)]] <- define_gene_tertiles_by_key(key = key)
  
  colData(vsd)[[paste0("OMA1_group_by_", key)]] <- define_gene_high_low_group_by_key(
    key = key,
    ensembl_gene_id = "ENSG00000162600"
  )
  colData(vsd)[[paste0("OMA1_tertiles_by_", key)]] <- define_gene_tertiles_by_key(
    key = key,
    ensembl_gene_id = "ENSG00000162600"
  )

  colData(vsd)[[paste0("OPA1_group_by_", key)]] <- define_gene_high_low_group_by_key(
    key = key,
    ensembl_gene_id = "ENSG00000198836"
  )
  colData(vsd)[[paste0("OPA1_tertiles_by_", key)]] <- define_gene_tertiles_by_key(
    key = key,
    ensembl_gene_id = "ENSG00000198836"
  )
}

colData(dds) <- colData(vsd)

saveRDS(
  object = vsd,
  file = snakemake@output[["vsd"]]
)

saveRDS(
  object = dds,
  file = snakemake@output[["dds"]]
)

problematic_cols <- unlist(
  lapply(
    colData(vsd),
    is.list
  )
)
write.csv(
  x = colData(vsd)[,!problematic_cols],
  file = snakemake@output[["csv"]]
)