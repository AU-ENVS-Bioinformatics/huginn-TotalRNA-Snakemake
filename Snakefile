from snakemake.utils import min_version
min_version("6.0")
configfile: "config.yaml"
print(config)
exit(1)
module total_rna:
    snakefile:
        github("AU-ENVS-Bioinformatics/TotalRNA-Snakemake", path="workflow/Snakefile", branch="main")
    config: config

use rule * from total_rna


