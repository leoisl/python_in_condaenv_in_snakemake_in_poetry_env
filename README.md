# python_in_condaenv_in_snakemake_in_poetry_env

This repo tries to reproduce a possible issue with snakemake, conda and python in virtual environment.

## How to reproduce

1. Clone this repo;
2. `poetry install`;
3. Run the pipeline using the `python` wrapper: `poetry run test_snakemake`;
4. Inspect the log file and see that the `.venv/bin/python` is getting precedence over the conda env `python`,
e.g. this is what I get (see [this Snakefile](Snakefile) for more details of what this pipeline is doing):
```
+ which python
/home/leandro/git/python_in_condaenv_in_snakemake_in_poetry_env/.venv/bin/python
+ python --version
Python 3.11.5
+ echo /home/leandro/git/python_in_condaenv_in_snakemake_in_poetry_env/.venv/bin:/home/leandro/git/python_in_condaenv_in_snakemake_in_poetry_env/.snakemake/conda/cf2434e94d9e6d52b98003b48d3de462_/bin:/home/leandro/miniconda3/condabin:/home/leandro/.cargo/bin:/home/leandro/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/leandro/Applications/mendeleydesktop-1.19.4-linux-x86_64/bin:/home/leandro/edirect
/home/leandro/git/python_in_condaenv_in_snakemake_in_poetry_env/.venv/bin:/home/leandro/git/python_in_condaenv_in_snakemake_in_poetry_env/.snakemake/conda/cf2434e94d9e6d52b98003b48d3de462_/bin:/home/leandro/miniconda3/condabin:/home/leandro/.cargo/bin:/home/leandro/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/leandro/Applications/mendeleydesktop-1.19.4-linux-x86_64/bin:/home/leandro/edirect
+ PATH=/home/leandro/git/python_in_condaenv_in_snakemake_in_poetry_env/.snakemake/conda/cf2434e94d9e6d52b98003b48d3de462_/bin:/home/leandro/git/python_in_condaenv_in_snakemake_in_poetry_env/.venv/bin:/home/leandro/git/python_in_condaenv_in_snakemake_in_poetry_env/.snakemake/conda/cf2434e94d9e6d52b98003b48d3de462_/bin:/home/leandro/miniconda3/condabin:/home/leandro/.cargo/bin:/home/leandro/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/leandro/Applications/mendeleydesktop-1.19.4-linux-x86_64/bin:/home/leandro/edirect
+ which python
/home/leandro/git/python_in_condaenv_in_snakemake_in_poetry_env/.snakemake/conda/cf2434e94d9e6d52b98003b48d3de462_/bin/python
+ python --version
Python 3.8.18
```

5. The same behaviour is also observed by trying to do this more "manually", e.g.:
```
source .venv/bin/activate
snakemake -j1 --use-conda --forceall
```

6. With the `shell` directive is ok-ish, as we can modify the `PATH` variable and get things working... but I could not
make it work with the `script` directive.