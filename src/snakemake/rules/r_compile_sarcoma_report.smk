rule r_compile_sarcoma_report:
    """
    TODO: write python function that take script path as argument, then take its dirname and parse all Rmd files in this directory looking for smi variables to return as a list.
    Test:
        out/bookdown/VNN1_sarcoma/index.html
        out/bookdown/OPA1_sarcoma/index.html
        out/bookdown/OMA1_sarcoma/index.html
    """
    input:
        rmd = "src/rmd/{filler}/index.Rmd",
        smi = rmd_bookdown_smi_dep
    output:
        html = "out/bookdown/{filler}/index.html"
    log:
        "out/bookdown/{filler}/log"
    benchmark:
        "out/bookdown/{filler}/benchmark.tsv"
    wildcard_constraints:
        filler = "VNN1_sarcoma|OPA1_sarcoma|OMA1_sarcoma"
    conda:
        "../envs/r_rmd_sarcoma.yaml"
    script:
        "../../r/scripts/compile_bookdown.R"

rule r_compile_all_sarcoma_reports:
    input:
        "out/bookdown/VNN1_sarcoma/index.html",
        "out/bookdown/OPA1_sarcoma/index.html",
        "out/bookdown/OMA1_sarcoma/index.html"