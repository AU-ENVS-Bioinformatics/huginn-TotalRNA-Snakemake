from snakemake.utils import min_version
import re
from pathlib import Path

min_version("6.0")


configfile: "config.yaml"


shell("echo Retrive external scripts...")
if not os.path.exists(".external_scripts"):
    os.makedirs(".external_scripts")
    shell(
        "wget -O .external_scripts/run_MetaRib.py https://raw.githubusercontent.com/AU-ENVS-Bioinformatics/TotalRNA-Snakemake/main/workflow/external_scripts/run_MetaRib.py"
    )


module total_rna:
    snakefile:
        github(
            "AU-ENVS-Bioinformatics/TotalRNA-Snakemake",
            path="workflow/Snakefile",
            branch="main",
        )
    config:
        config


use rule * from total_rna


use rule MetaRib from total_rna as MetaRib with:
    params:
        script=".external_scripts/run_MetaRib.py",


rule rename_novogene:
    output:
        touch("results/rename.done"),
    run:
        assert os.path.exists("reads/"), "No reads directory found"
        basenames = [f for f in os.listdir("reads/") if f.endswith(".fq.gz")]
        infiles = [os.path.join("reads/", f) for f in basenames]
        regex = re.compile(r"(.+)_.+_(\d+)_.+-.+_.+_(\d).fq.gz")
        try:
            matches = [regex.match(f) for f in basenames if regex.match(f)]
            outfiles = [
                f"results/renamed_raw_reads/{m.group(1)}{m.group(2)}_R{m.group(3)}.fq.gz"
                for m in matches
            ]
        except:
            print("There was an error parsing the reads")
        for original, target in zip(infiles, outfiles):
            src, dest = Path(original).absolute(), Path(target).absolute()
            dest.parent.mkdir(parents=True, exist_ok=True)
            if not dest.exists():
                src.rename(dest)
                print(f"{original} -> {dest}")
            else:
                print(f"File {dest} already exists, skipping")
