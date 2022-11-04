log <- file(snakemake@log[[1]], open="wt")
sink(log)

# It is actually a bad idea to leave Rmd files in output directory because then r-server mistakes the folder with a Shiny app, instead of loading the index.html.

# outdir <- dirname(snakemake@output[["html"]])

# file.remove(
#   list.files(
#     path = outdir,
#     pattern = ".Rmd$",
#     full.names = TRUE
#   )
# )

# file.copy(
#   dirname(snakemake@input[["rmd"]]),
#   dirname(outdir),
#   recursive = TRUE
# )

# setwd(outdir)

# file.remove("_main.Rmd")
# source("styler.R")
# bookdown::render_book("index.Rmd")


