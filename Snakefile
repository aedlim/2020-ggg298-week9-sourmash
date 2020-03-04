rule all:
    input: "all.cmp.hist.png",
        "all.cmp.dendro.png",
        "all.cmp.matrix.png"

rule download_genomes: 
    output:
        "1.fa.gz",
        "2.fa.gz",
        "3.fa.gz",
        "4.fa.gz",
        "5.fa.gz"
    shell:
        """wget https://osf.io/t5bu6/download -O 1.fa.gz
        wget https://osf.io/ztqx3/download -O 2.fa.gz
        wget https://osf.io/w4ber/download -O 3.fa.gz
        wget https://osf.io/dnyzp/download -O 4.fa.gz
        wget https://osf.io/ajvqk/download -O 5.fa.gz"""

rule sourmash_compute:
    input: "{sample}.fa.gz"
    output: "{sample}.fa.gz.sig"
    shell: "sourmash compute -k 31 {wildcards.sample}.fa.gz"

rule sourmash_compare:
    input: "1.fa.gz.sig",
        "2.fa.gz.sig",
        "3.fa.gz.sig",
        "4.fa.gz.sig",
        "5.fa.gz.sig"
    output: "all.cmp",
        "all.cmp.labels.txt"
    shell: "sourmash compare {input} -o all.cmp"

rule sourmash_plot:
    input: "all.cmp"
    output: "all.cmp.matrix.png"
    shell: "sourmash plot --labels {input}"
