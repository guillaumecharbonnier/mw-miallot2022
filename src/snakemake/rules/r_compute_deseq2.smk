rule r_compute_deseq2:
    """
    out/r/compute_deseq2/Vnn1HighVsLowTcgaSarcMFS_ddss.rds
    """
    input:
        dds = "out/r/annotate_tcga/dds.rds",
    output:
        ddss = "out/r/compute_deseq2/{design}_ddss.rds",
        ddssr = "out/r/compute_deseq2/{design}_ddssr.rds",
    log:
        "out/r/compute_deseq2/{design}.log"
    benchmark:
        "out/r/compute_deseq2/{design}.benchmark.tsv"
    conda:
        "../envs/r_deseq2.yaml"
    script:
        "../../r/scripts/compute_deseq2.R"
