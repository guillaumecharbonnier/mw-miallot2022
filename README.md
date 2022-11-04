# mw-miallot2022

Metaworkflow module for the analysis of TCGA Cancers with a focus on Sarcoma and VNN1.
A compiled version of the report is available [here](https://guillaumecharbonnier.github.io/mw-miallot2022). Some sections of these analyses were used for the article _The coenzyme A precursor pantethine mitigates sarcoma growth through promotion of type 1 immunity_, specifically the 
[co-expression network](https://guillaumecharbonnier.github.io/mw-miallot2022/3-results-2-wgcna-1-ProjectId-1-TcgaSarc.html#resultsWgcnaProjectIdTcgaSarc) and [correlations with deconvoluted cells](https://guillaumecharbonnier.github.io/mw-miallot2022/3-results-5-correlograms.html#tcga-sarc-only-with-cell-deconvolution)

To recompile the report:
```
git clone git@github.com:guillaumecharbonnier/mw-miallot2022.git
git clone git@github.com:guillaumecharbonnier/mw-lib.git
cd mw-miallot2022
snakemake out/bookdown/VNN1_sarcoma/index.html -j2 --use-conda
```

While designed with a focus on VNN1, these analyses could be easily adjusted to focus on other genes.
