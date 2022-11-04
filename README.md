# mw-miallot2022

Metaworkflow module for the analysis of TCGA Cancers with a focus on Sarcoma and VNN1.

To recompile the report:
```
git clone git@github.com:guillaumecharbonnier/mw-miallot2022.git
git clone git@github.com:guillaumecharbonnier/mw-lib.git
cd mw-miallot2022
snakemake out/bookdown/VNN1_sarcoma/index.html -j2 --use-conda
```

A compiled version of the report is available [here](https://guillaumecharbonnier.github.io/mw-miallot2022).
