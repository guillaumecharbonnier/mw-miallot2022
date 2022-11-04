rule r_export_mixture_lm22_to_cibersortx:
    input:
        vsd = "out/r/download_tcga/vsd.rds",
        lm22 = "inp/cibersortx/LM22.txt"
    output:
        tsv = "out/r/export_mixture_lm22_to_cibersortx/mixture.tsv"
    log:
        "out/r/export_mixture_lm22_to_cibersortx/log"
    benchmark:
        "out/r/export_mixture_lm22_to_cibersortx/benchmark.tsv"
    conda:
        "../envs/r_rmd_sarcoma.yaml"
    script:
        "../../r/scripts/export_mixture_lm22_to_cibersortx.R"

