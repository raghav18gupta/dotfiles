## Conda env backup

- To export:
    - Activate the environment you are interested in.
    - `conda env export > env-name.yaml`

- To restore:
    - `conda env create -f env-name.yaml`
