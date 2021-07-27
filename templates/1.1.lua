-- -*- lua -*-

help(
[[
Sbox is a small toolbox for Slurm that provides information about users' accounts, jobs, and cluster resources.
Sbox Interactive command uses srun to request resources interactively through a terminal or Jupyter Notebook.
]]
)

whatis("Name: sbox")
whatis("Version: 1.1")
whatis("Category: Applications, Interactive")
whatis("Keywords: Slurm, Jupyter")
whatis("URL: https://github.com/ashki23/sbox")
whatis("Description: Small toolbox for Slurm")

-- Create environment variables
local sbox_dir   = "/cluster/software/sbox/1.1"
local sbox_bin   = "/cluster/software/sbox/1.1/bin"

prepend_path("PATH", sbox_bin)
setenv("SBOX_ROOT", sbox_dir)
