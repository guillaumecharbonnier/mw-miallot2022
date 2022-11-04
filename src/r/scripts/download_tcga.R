library(TCGAbiolinks)

projects <- c(
  "TCGA-SARC",
  "TCGA-OV",
  "TCGA-ESCA",
  "TCGA-PAAD",
  "TCGA-MESO",
  "TCGA-BRCA",
  "TCGA-LIHC",
  "TCGA-BLCA",
  "TCGA-STAD",
  "TCGA-LUSC",
  "TCGA-LUAD"
)

query <- GDCquery(
  project = projects,
  data.category = "Transcriptome Profiling",
  data.type = "Gene Expression Quantification",
  file.type = "htseq.counts"
)

gdc_dir <- dirname(snakemake@output[["dds"]])

dir.create(
  gdc_dir,
  recursive = TRUE,
  showWarnings = FALSE
)

GDCdownload(
  query,
  method = "api",
  directory = gdc_dir,
  files.per.chunk = 10
)

dds <- GDCprepare(
  query,
  directory = gdc_dir
)

saveRDS(
  object = dds,
  file = snakemake@output[["dds"]]
)