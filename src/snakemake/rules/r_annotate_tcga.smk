rule r_annotate_tcga:
    input:
        dds = "out/r/download_tcga/dds.rds"
    output:
        dds = "out/r/annotate_tcga/dds.rds",
        vsd = "out/r/annotate_tcga/vsd.rds",
        csv = "out/r/annotate_tcga/sample_metadata.csv"
    log:
        "out/r/annotate_tcga/log"
    benchmark:
        "out/r/annotate_tcga/benchmark.tsv"
    conda:
        "../envs/r_rmd_sarcoma.yaml"
    script:
        "../../r/scripts/annotate_tcga.R"
