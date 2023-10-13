rule test:
    output:
        "log.txt"
    conda: "env.yaml"
    shell:
        """
        set -x
        {{
            which python  # want conda python as I am using conda: "env.yaml" - does not work 
            python --version  # want 3.8 - does not work
            
            echo $PATH  # we can see ./.venv/bin having priority over the conda env
            
            # set conda env first in $PATH
            PATH="$CONDA_PREFIX"/bin:$PATH
            
            which python  # now we have conda python
            python --version  # now we have 3.8
        }} > {output} 2>&1
        """
