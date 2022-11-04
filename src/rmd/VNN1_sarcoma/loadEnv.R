# Load all R files in the "r" folder.
# Mostly my favourite functions and variables I rely on for Rmd docs
r_files <- c(
  list.files(
    path = "r",
    pattern = ".R$",
    full.names = TRUE
  )
)
lapply(r_files, source)

packages <- c(
  "data.table",
  "yaml",
  "TCGAbiolinks",
  "SummarizedExperiment",
  "ggpubr",
  "ggbeeswarm",
  "ggrepel",
  "ggcorrplot",
  "NMF",
  "ComplexHeatmap",
  "circlize",
  "dendextend",
  "dendsort",
  "pheatmap",
  "yaml",
  "httr",
  "styler",
  "GenomicRanges",
  "RColorBrewer",
  "DESeq2",
  "apeglm",
  "EnhancedVolcano",
  "WGCNA",
  "gprofiler2",
  "survival",
  "survminer",
  #' pdftools',
  "openxlsx",
  #' biomaRt',
  "clusterProfiler",
  "enrichplot",
  "org.Hs.eg.db",
  "ReactomePA",
  #' GOplot',
  #' plotly',
  "factoextra",
  "umap",
  "plyr",
  # "edgeR",
  #' ggcorrplot',
  #' GGally',
  #' scales',
  #' UpSetR',
  #' reticulate',
  "DT",
  "R.utils", # load bz2 with fread
  "knitr"
)

loadLibraries(packages)

theme_set(theme_bw())

# Retrieve the relative path used by Bookdown as output folder
book_from_rmd <- read_yaml("_bookdown.yml")$output_dir
mw_from_rmd <- sub("/[^\\.].*$", "", book_from_rmd)
book_from_mw <- gsub("\\.\\./", "", book_from_rmd)
dir.create(
  file.path(book_from_rmd, "plots"),
  recursive = TRUE,
  showWarnings = FALSE
)
dir.create(
  file.path(book_from_rmd, "rds"),
  recursive = TRUE,
  showWarnings = FALSE
)
symnumargs <- list(cutpoints = c(0, 1e-04, 0.001, 0.01, 0.05, 1), symbols = c("∗∗∗∗", "∗∗∗", "∗∗", "∗", "ns"))
# symnumargs <- list(cutpoints = c(0,  1e-10,  1e-09,  1e-08,  1e-07,  1e-06,  1e-05,  1e-04, 0.001, 0.01, 0.05, 1), symbols = c("∗∗∗∗", "∗∗∗", "∗∗", "∗", "ns"))
