rule r_download_tcga:
    output:
        dds = "out/r/download_tcga/dds.rds"
    log:
        "out/r/download_tcga/log"
    benchmark:
        "out/r/download_tcga/benchmark.tsv"
    conda:
        "../envs/r_rmd_sarcoma.yaml"
    script:
        "../../r/scripts/download_tcga.R"
