This repository is the Huginn-version of the [TotalRNA pipeline](https://github.com/AU-ENVS-Bioinformatics/TotalRNA-Snakemake). 

For more information, please the repository above. Otherwise, let's get started!. I'm going to assume that you are gonna clone the repository. However, notice that it only consist of the Snakefile and the config.yaml file. You can always copy paste it. 

```bash
conda activate snakemake
git clone https://github.com/AU-ENVS-Bioinformatics/huginn-TotalRNA-Snakemake/ TotalRNA-Snakemake-Project
cd TotalRNA-Snakemake-Project
```

Symlink your reads to the reads folder. 
```bash
ln -s /path/to/reads/ reads
```

If you want to rename all the samples, then run
```bash
snakemake -c1 rename
```
You can customize the renaming in the config.yaml file. Instead, if you want to use the original names, then run

```bash 
snakemake -c1 skip_rename
```

Now, you can run the pipeline. We will use conda to manage the dependencies. Because those are already in Huginn, we can avoid reinstalling them. Check that everything is in order by running the dry-run.
```bash
snakemake -n --use-conda --conda-prefix /software/TotalRNA-Snakemake --cores 100
```

Remember to use screen, tmux or nohup. 

```bash
snakemake --use-conda --conda-prefix /software/TotalRNA-Snakemake --cores 100
```

You will find some reports in the qc/ folder. You should check the notebook notebook/annotree.ipynb and rerun with custom parameters if necessary. 
