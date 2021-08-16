-- -*- lua -*-

help(
[[
Sbox is a toolbox for Slurm that provides information about users' activities and facilitate access to the cluster resources from terminal or JupyterLab.
]]
)

whatis("Name: sbox")
whatis("Version: 1.2")
whatis("Category: Applications, Interactive")
whatis("Keywords: Slurm, Jupyter")
whatis("URL: https://sbox.readthedocs.io/")
whatis("Description: Small toolbox for Slurm")

-- Create environment variables (UPDATE THE PATH)
local this_root = "/cluster/software/path/sbox/1.2"

prepend_path("PATH", this_root .. "/bin", ":")
prepend_path("MANPATH", this_root .. "/share/man", ":")
setenv("SBOX_ROOT", this_root)
