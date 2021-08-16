Quick install
=============

-  Download and extract the `latest Sbox release <https://github.com/ashki23/sbox/releases/latest>`__.
-  Update the ``./config`` file based on the cluster information. Review
   `Configuration <https://sbox.readthedocs.io/en/latest/requirements.html#configuration>`__ to learn more.
-  To access a JupyerLab session, install Anaconda and create the required virtual environments and modulefiles. Review
   `Requirements <https://sbox.readthedocs.io/en/latest/requirements.html#requirements>`__ to learn more.
-  Place a modulefile for Sbox under ``$MODULEPATH/sbox``. You can find the Sbox template modulefile in `here <https://github.com/ashki23/sbox/blob/main/templates/1.2.lua>`__.

Requirements
============

Sbox requires Slurm and Python >= 3.6.8. The ``interactive jupyter``
command requires Anaconda and an environment module system
(e.g. `Lmod <https://lmod.readthedocs.io/en/latest/>`__) in addition to
Slurm and Python. To use R and Julia in JupyterLab sessions, we need R and irkernel as well as Julia to be installed.

Note that Sbox options might require some other Unix commands. Review
the options requirement under the `command line options <https://sbox.readthedocs.io/en/latest/sbox.html#command-line-options>`__.

The following shows how to install Anaconda and create the required
virtual envs and modulefiles.

Python kernel (Anaconda)
------------------------

The ``interactive jupyter`` command provides a JupyterLab interface for
running Python and many scientific packages by using Anaconda. To
install Anaconda, find the latest version of Anaconda from
`here <https://www.anaconda.com/products/individual#linux>`__ and run:

.. code:: bash

   wget https://repo.anaconda.com/archive/Anaconda3-<year.month>-Linux-x86_64.sh
   bash Anaconda3-<year.month>-Linux-x86_64.sh -b -p /<cluster software path>/anaconda/<year.month>

In the above lines, update ``<year.month>`` (e.g. ``2021.05``) based on
the Anaconda version and ``<cluster software path>``
(e.g. ``/cluster/software/``) based on the cluster path.

To load Anaconda by ``modeule load`` command, create the following
modeulefile under ``$MODULEPATH/anaconda/<year.month>.lua``:

.. code:: lua

   -- -*- lua -*-

   whatis([[Name : anaconda]])
   whatis([[Version : <year.month>]])
   whatis([[Target : x86_64]])
   whatis([[Short description : Python3 distribution including conda and 250+ scientific packages.]])
   help([[Python3 distribution including conda and 250+ scientific packages.]])

   -- Create environment variables
   local this_root = "/<cluster software path>/anaconda/<year.month>"

   prepend_path("PATH", this_root .. "/bin", ":")
   prepend_path("LIBRARY_PATH", this_root .. "/lib", ":")
   prepend_path("LD_LIBRARY_PATH", this_root .. "/lib", ":")
   prepend_path("MANPATH", this_root .. "/share/man", ":")
   prepend_path("INCLUDE", this_root .. "/include", ":")
   prepend_path("C_INCLUDE_PATH", this_root .. "/include", ":")
   prepend_path("CPLUS_INCLUDE_PATH", this_root .. "/include", ":")
   prepend_path("PKG_CONFIG_PATH", this_root .. "/lib/pkgconfig", ":")
   setenv("ANACONDA_ROOT", this_root)

Or adding the following tcl modulefile under
``$MODULEPATH/anaconda/<year.month>``:

.. code::

   #%Module1.0
   ## Metadata ###########################################
   set this_module        anaconda
   set this_version       <year.month>
   set this_root          /<cluster software path>/${this_module}/${this_version}
   set this_docs          https://docs.anaconda.com/
   set this_module_upper  [string toupper ${this_module}]
   ## Module #############################################
   proc ModulesHelp { } {
           global this_module this_version this_root this_docs
           puts stderr "****************************************************"
           puts stderr "Name:          ${this_module}"
           puts stderr "Version:       ${this_version}"
           puts stderr "Documentation: ${this_docs}"
           puts stderr "****************************************************\n"
   }

   module-whatis "Set up environment for ${this_module} ${this_version}"

   prepend-path  PATH  ${this_root}/bin
   prepend-path  LIBRARY_PATH  ${this_root}/lib
   prepend-path  LD_LIBRARY_PATH  ${this_root}/lib
   prepend-path  MANPATH  ${this_root}/share/man
   prepend-path  INCLUDE  ${this_root}/include
   prepend-path  C_INCLUDE_PATH  ${this_root}/include
   prepend-path  CPLUS_INCLUDE_PATH  ${this_root}/include
   prepend-path  PKG_CONFIG_PATH  ${this_root}/lib/pkgconfig
   setenv        ${this_module_upper}_ROOT  ${this_root}

R kernel
--------

Users can run R scripts within a JupterLab notebook by
``interactive jupyter -k r``. To have R, irkernel and many other R
packages, we can create the following env including
`r-essentials <https://docs.anaconda.com/anaconda/user-guide/tasks/using-r-language/>`__
from Anaconda:

.. code:: bash

   cd /<cluster software path>/anaconda/<year.month>
   ./bin/conda create -n r-essentials-<R version> -c conda-forge r-essentials r-base r-irkernel jupyterlab

In the above lines, ``<cluster software path>`` and ``<year.month>``
should be updated based on the Anaconda path and ``<R version>``
(e.g. ``4.0.3``) based on the version of R in the env.

The following modulefile should be added to
``$MODULEPATH/r-essentials/<R version>.lua`` to be able to load the R
env:

.. code:: lua

   -- -*- lua -*-

   whatis([[Name : r-essentials]])
   whatis([[Version : <R version>]])
   whatis([[Target : x86_64]])
   whatis([[Short description : A conda environment for R and 80+ scientific packages.]])
   help([[A conda environment for R and 80+ scientific packages.]])

   -- Create environment variables
   local this_root = "/<cluster software path>/anaconda/envs/r-essentials-<R version>"

   prepend_path("PATH", this_root .. "/bin", ":")
   prepend_path("LIBRARY_PATH", this_root .. "/lib", ":")
   prepend_path("LD_LIBRARY_PATH", this_root .. "/lib", ":")
   prepend_path("MANPATH", this_root .. "/share/man", ":")
   prepend_path("INCLUDE", this_root .. "/include", ":")
   prepend_path("C_INCLUDE_PATH", this_root .. "/include", ":")
   prepend_path("CPLUS_INCLUDE_PATH", this_root .. "/include", ":")
   prepend_path("PKG_CONFIG_PATH", this_root .. "/lib/pkgconfig", ":")
   setenv("RESSENTIALS_ROOT", this_root)

Or adding a tcl modulefile similar to the above tcl template for Anaconda.

Julia kernel
------------

The ``interactive jupyter -k julia`` command provides Julia from a
JupyterLab notebook. Julia can be installed from
`Spack <https://spack.io/>`__,
`source <https://julialang.org/downloads/>`__ or
`Anaconda <https://anaconda.org/conda-forge/julia>`__. The following
shows how to install Julia from Anaconda (Note that if Julia have
been installed on the cluster, you can skip this section and use the
available Julia module instead).

.. code:: bash

   cd /<cluster software path>/anaconda/<year.month>
   ./bin/conda create -n julia-<version> -c conda-forge julia

In the above lines, ``<cluster software path>`` and ``<year.month>``
should be updated based on the Anaconda path and ``<version>``
(e.g. ``1.6.1``) based on the version of Julia in the env.

The following modulefile should be added to
``$MODULEPATH/julia/<version>.lua``:

.. code:: lua

   -- -*- lua -*-

   whatis([[Name : julia]])
   whatis([[Version : <version>]])
   whatis([[Target : x86_64]])
   whatis([[Short description : The Julia Language: A fresh approach to technical computing]])
   help([[The Julia Language: A fresh approach to technical computing]])

   -- Create environment variables
   local this_root = "/<cluster software path>/anaconda/envs/julia-<version>"

   prepend_path("PATH", this_root .. "/bin", ":")
   prepend_path("LIBRARY_PATH", this_root .. "/lib", ":")
   prepend_path("LD_LIBRARY_PATH", this_root .. "/lib", ":")
   prepend_path("MANPATH", this_root .. "/share/man", ":")
   prepend_path("INCLUDE", this_root .. "/include", ":")
   prepend_path("C_INCLUDE_PATH", this_root .. "/include", ":")
   prepend_path("CPLUS_INCLUDE_PATH", this_root .. "/include", ":")
   prepend_path("PKG_CONFIG_PATH", this_root .. "/lib/pkgconfig", ":")
   setenv("JULIA_ROOT", this_root)

Or adding a tcl modulefile similar to the above tcl template for Anaconda.

Note that the first time that users run ``interactive jupyter -k julia``,
Julia Jupyter kernal (IJulia) will be installed under ``~/.julia``.

On demand Python pakages
------------------------

Popular Python pakages that are not available in Anaconda can be added
to ``interactive jupyter -e``. For instance the following shows how to
create a TensorFlow (TF) env:

.. code:: bash

   cd /<cluster software path>/anaconda/<year.month> 
   ./bin/conda create -n tensorflow-gpu-<version> anaconda
   ./bin/conda install -n tensorflow-gpu-<version> tensorflow-gpu gpustat

Similarly, we can create a PyTorch (PT) env with:

.. code:: bash

   cd /<cluster software path>/anaconda/<year.month> 
   ./bin/conda create -n pytorch-<version> anaconda
   ./bin/conda install -n pytorch-<version> -c pytorch pytorch gpustat

In the above lines, ``<cluster software path>`` and ``<year.month>``
should be updated based on the Anaconda path and ``<version>``
(e.g. ``2.4.1``) based on the version of TF or PT.

For each env, we need to add a modulefile to
``$MODULEPATH/<env name>/<version>.lua``. For instance
``$MODULEPATH/tensorflow/<version>.lua`` is:

.. code:: lua

   -- -*- lua -*-

   whatis([[Name : tensorflow]])
   whatis([[Version : <version>]])
   whatis([[Target : x86_64]])
   whatis([[Short description : Python3 distribution including TensorFlow and 250+ scientific packages.]])
   help([[Python3 distribution including TensorFlow and 250+ scientific packages.]])

   -- Create environment variables
   local this_root = "/<cluster software path>/anaconda/envs/tensorflow-gpu-<version>"

   prepend_path("PATH", this_root .. "/bin", ":")
   prepend_path("LIBRARY_PATH", this_root .. "/lib", ":")
   prepend_path("LD_LIBRARY_PATH", this_root .. "/lib", ":")
   prepend_path("MANPATH", this_root .. "/share/man", ":")
   prepend_path("INCLUDE", this_root .. "/include", ":")
   prepend_path("C_INCLUDE_PATH", this_root .. "/include", ":")
   prepend_path("CPLUS_INCLUDE_PATH", this_root .. "/include", ":")
   prepend_path("PKG_CONFIG_PATH", this_root .. "/lib/pkgconfig", ":")
   setenv("TENSORFLOW_ROOT", this_root)

Or adding a tcl modulefile similar to the above tcl template for Anaconda.

configuration
=============

The ``sbox`` and ``interactive`` commands are reading the required
information from the below JSON config file.

.. code:: json


   {
       "disk_quota_paths": [],
       "cpu_partition": [],
       "gpu_partition": [],
       "interactive_partition_timelimit": {},
       "jupyter_partition_timelimit": {},
       "partition_qos": {},
       "kernel_module": {},
       "env_module": {}
   }

The config file includes:

-  ``disk_quota_paths``: A list of paths to the disks for finding users
   quotas. By default the first input is considered as the users’ home path.
-  ``cpu_partition``: A list of computational partitions.
-  ``gpu_partition``: A list of GPU partitions.
-  ``interactive_partition_timelimit``: A dictionary of interactive
   partitions (i.e. users should access by ``srun``) and their time
   limits (hour). The first input is considered as the default partition.
-  ``jupyter_partition_timelimit``: A dictionary of computational/gpu
   partitions that users can run Jupter servers interactively and their
   time limits (hour). The first input is considered as the default partition.
-  ``partition_qos``: A dictionary of partitions and the corresponding
   quality of services.
-  ``kernel_module``: A dictionary of kernels and the corresponding modules.
   A Python kernel is required (review `here <https://sbox.readthedocs.io/en/latest/requirements.html#python-kernel-anaconda>`__).
-  ``env_module``: A dictionary of Python virtual environments and the corresponding modules.

For example:

.. code:: json

   {
       "disk_quota_paths": ["/home", "/data", "/gprs", "/storage/htc"],
       "cpu_partition": ["Interactive","Lewis","Serial","Dtn","hpc3","hpc4","hpc4rc","hpc5","hpc6","General","Gpu"],
       "gpu_partition": ["Gpu","gpu3","gpu4"],
       "interactive_partition_timelimit": {
       "Interactive": 4,
       "Dtn": 4,
       "Gpu": 2
       },
       "jupyter_partition_timelimit": {
       "Lewis": 8,
       "hpc4": 8,
       "hpc5": 8,
       "hpc6": 8,
       "gpu3": 8,
       "gpu4": 8,
       "Gpu": 2
       },
       "partition_qos": {
       "Interactive": "interactive",
       "Serial": "seriallong",
       "Dtn": "dtn"
       },
       "kernel_module": {
           "python": "anaconda",
           "r": "r-essentials",
           "julia": "julia"
       },
       "env_module": {
       "tensorflow-v1.9": "tensorflow/1.9.0",
       "tensorflow": "tensorflow",
       "pytorch": "pytorch"
       }
   }
