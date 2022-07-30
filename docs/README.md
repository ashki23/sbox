# Creating readthedocs page

- Create a conda env including `sphinx` and `pandoc`:

```bash
conda create -n sphinx -c conda-forge sphinx pandoc
conda activate sphinx
```

- For the first time, we need to create a `conf.py`, `index.rst` and `Makefile`. Sphinx comes with a script called `sphinx-quickstart` that sets up a source directory and creates a default conf.py with the most useful configuration values from a few questions it asks you. To use this, run:

```bash
sphinx-quickstart
```

- Now we can update `index.rst` and add other pages in `rst`. Also, we can add any HTML template layouts to `_templates`, or any images or pdf files to `_statics` directory.
  - Note that, in this project we just need to update the `index.rst` file and other `rst` files will be generated from the main `../README.md` by running `docs-generator.sh` script.

- Run the `docs-generator.sh` to create `rst` files from `../README.md`:

```bash
cd _static
source docs-generator.sh
```

The `docs-generator.sh` also will generate the man files automatically in `../share/man/man1/`.

- To review the HTML files run:

```bash
make html
```

The html pages will be available under `_build/html` path. Note that for readthedoc project, we do not need the HTML file, therefore its better add the `docs/_build` directory to the `../.gitignore` file.
