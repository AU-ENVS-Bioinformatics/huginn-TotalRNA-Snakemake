from snakemake.utils import min_version
min_version("6.0")
configfile: "config.yaml"

shell("echo Retrive external scripts...")
if not os.path.exists(".external_scripts"):
    os.makedirs(".external_scripts")
    shell("wget -O .external_scripts/run_MetaRib.py https://raw.githubusercontent.com/AU-ENVS-Bioinformatics/TotalRNA-Snakemake/main/workflow/external_scripts/run_MetaRib.py")

module total_rna:
    snakefile:
        github("AU-ENVS-Bioinformatics/TotalRNA-Snakemake", path="workflow/Snakefile", branch="main")
    config: config

use rule * from total_rna

use rule MetaRib from total_rna as MetaRib with:
    params:
        script=".external_scripts/run_MetaRib.py"
