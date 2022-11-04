# These functions define default arguments for Rmd templates defined in this folder.


#' @params cols is a vector of column names to keep in the produced DataTable.
knitDatasetPropertiesTemplate <- function(
  vsd = vsd,
  key = c("primary_diagnosis", "paper_short_histo"),
  chunk_label_prefix = opts_current$get("label")) {

  src <- knitr::knit_expand("templates/datasetProperties.Rmd")
  res <- knitr::knit_child(
    text = unlist(src),
    envir = environment(),
    quiet = TRUE
  )
  cat(res, sep = "\n")
}

