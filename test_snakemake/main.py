def main():
    from snakemake import shell
    shell("snakemake -j1 --use-conda --forceall")

if __name__ == "__main__":
    main()