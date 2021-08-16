# Sbox

Sbox is a toolbox for Slurm that provides information about users' accounts and jobs as well as information about the cluster resources. Sbox also can help Slurm admins to collect users' information by users ID and jobs ID. Interactive command uses Slurm `srun` and `sbatch` commands  to request resources interactively including running a Jupyter server on the cluster.

## Commands

- `sbox`
- `interactive`

## Sbox

`sbox` command includes various Slurm commands at one place. Users can use different options to find the information about the cluster and their accounts and activities. Beyond the Slurm commands, `sbox` provides some Unix features including users' groups, disk quotas and starting ssh agents. The ssh-agent lets users communicate with clients outside the cluster such as GitHub and GitLab or with other nodes within the cluster via ssh without asking for the passphrase (you need the passphrase to start the ssh-agent).

### Command line options

- `-h, --help`: Show the help message and exit.
- `-a, --account`: Return user's Slurm accounts by using Slurm `sacctmgr`. If the cluster does not use Slurm for users' account management, it returns empty output.
- `-f, --fairshare`: Return users' fairshare by using Slurm `sshare` command. If the cluster does not follow a fairshare model, it returns empty output.
- `-g, --group`: Return user's Posix groups by using Unix `groups` command.
- `-q, --queue`: Return user's jobs in the Slurm queue by Slurm using `squeue` command.
- `-j, --job`: Show a running/pending job info by using Slurm `scontrol` command. It requires a valid job ID as argument.
- `-c, --cpu`: Return computational resources including number of cores and amount of memory on each node. It uses Slurm `sjstat` command. 
- `-p, --partition`: Show cluster partitions by using Slurm `sinfo` command.
- `-u, --user`: Store a user ID. By default it uses `$USER` as user ID for any query that needs a user ID. It can be used with other options to find the information for other users.
- `-v, --version`: Show program's version number and exit.
- `--eff`: Show efficiency of a job. It requires a valid job ID as argument. It uses Slurm `seff` command for completed/finished jobs and Unix `top` command for a running job.
- `--history`: Return jobs history for last day, week, month or year. It requires one of the day/week/month/year options as an argument. It uses Slurm `sacct` command and return empty output if the cluster does not use Slurm for users' account management.
- `--pending`: Return user's pending jobs by using Slurm `squeue` command.
- `--running`: Return user's running jobs by using Slurm `squeue` command.
- `--qos`: Show user's quality of services (QOS) and a list of available QOS in the cluster. It uses Slurm `sacctmgr show assoc` command and return empty output if the cluster does not use Slurm for users' account management.
- `--quota`: Return user's disk quotas. It uses LFS `lfs quota` command for LFS systems and Unix `df` command for NFS systems. It returns pooled size of the disk if the cluster does not have user/group storage accounts.
- `--ncpu`: Show number of available cpus on the cluster using Slurm `sinfo` command.
- `--ncgu`: Show number of available gpus on the cluster using Slurm `squeue` and `sinfo` commands.
- `--gpu`: Show gpu resources including gpu cards' name and numbers using Slurm `sinfo` command.
- `--license`: Show available license servers using Slurm `scontrol` command.
- `--reserve`: Show Slurm reservations using Slurm `scontrol` command.
- `--topusage`: Show top usage users using Slurm `sreport` command.
- `--agent`: Start, stop and list user's ssh-agents on the current host. It requires one of the start/stop/list options as an argument. Use `ssh -o StrictHostKeyChecking=no` to disable asking for host key acceptances.

**Examples**

See jobs' histoty:

```bash
[user@lewis4-r630-login-node675 ~]$ module load sbox
[user@lewis4-r630-login-node675 ~]$ sbox --hist day
-------------------------------------------------------------------------------- Jobs History - Last Day --------------------------------------------------------------------------------
     JobID   User Account      State Partition     QOS NCPU NNod ReqMem              Submit   Reserved               Start    Elapsed                 End             NodeList    JobName 
---------- ------ ------- ---------- --------- ------- ---- ---- ------ ------------------- ---------- ------------------- ---------- ------------------- -------------------- ---------- 
  23126125  user  general  COMPLETED Interact+ intera+    1    1    2Gn 2021-07-28T01:25:05   00:00:00 2021-07-28T01:25:05   00:00:03 2021-07-28T01:25:08 lewis4-c8k-hpc2-nod+       bash 
  23126126  user  general  COMPLETED Interact+ intera+    1    1    2Gn 2021-07-28T01:25:13   00:00:00 2021-07-28T01:25:13   00:00:03 2021-07-28T01:25:16 lewis4-c8k-hpc2-nod+       bash 
  23126127  user  general  COMPLETED Interact+ intera+    1    1    2Gn 2021-07-28T01:25:20   00:00:00 2021-07-28T01:25:20   00:00:08 2021-07-28T01:25:28 lewis4-c8k-hpc2-nod+       bash 
  23126128  user  genera+  COMPLETED Interact+ intera+    1    1    2Gn 2021-07-28T01:25:49   00:00:00 2021-07-28T01:25:49   00:00:03 2021-07-28T01:25:52 lewis4-c8k-hpc2-nod+       bash 
  23126129  user  genera+  COMPLETED Interact+ intera+    1    1    2Gn 2021-07-28T01:26:05   00:00:00 2021-07-28T01:26:05   00:00:06 2021-07-28T01:26:11 lewis4-c8k-hpc2-nod+       bash 
  23126130  user  genera+  COMPLETED       Gpu  normal    1    1    2Gn 2021-07-28T01:26:38   00:00:02 2021-07-28T01:26:40   00:00:11 2021-07-28T01:26:51 lewis4-z10pg-gpu3-n+       bash 
  23126131  user  genera+ CANCELLED+       Gpu  normal    1    1    2Gn 2021-07-28T01:27:43   00:00:01 2021-07-28T01:27:44   00:01:03 2021-07-28T01:28:47 lewis4-z10pg-gpu3-n+ jupyter-py 
```

Find a job's efficiency:

```bash
[user@lewis4-r630-login-node675 ~]$ sbox --eff 23148125
------------------------------------- Job Efficiency -------------------------------------
Job ID: 23126131
Cluster: lewis4
User/Group: user/user
State: CANCELLED (exit code 0)
Cores: 1
CPU Utilized: 00:00:01
CPU Efficiency: 1.59% of 00:01:03 core-walltime
Memory Utilized: 45.80 MB
Memory Efficiency: 2.24% of 2.00 GB
```

Find accounts, fairshares, and groups:

```bash
[user@lewis4-r630-login-node675 ~]$ sbox -afg
---------------------------------------- Accounts ----------------------------------------
rcss-gpu  root  general-gpu  rcss  general

--------------------------------------- Fairshare ----------------------------------------
             Account       User  RawShares  NormShares    RawUsage  EffectvUsage  FairShare 
-------------------- ---------- ---------- ----------- ----------- ------------- ---------- 
root                       user     parent    1.000000           0      0.000000   1.000000 
general-gpu                user          1    0.000005        3942      0.000016   0.098089 
rcss                       user          1    0.001391        1327      0.001147   0.564645 
general                    user          1    0.000096     3196356      0.000243   0.174309 
rcss-gpu                   user          1    0.000181           0      0.000000   0.999976 

----------------------------------------- Groups -----------------------------------------
user : user rcss gaussian biocompute rcsslab-group rcss-maintenance rcss-cie software-cache
```

Find disk quotas:

```bash
[user@lewis4-r630-login-node675 ~]$ sbox --quo
------------------------------------- user /home storage -------------------------------------
      File         Used  Use%  Avail  Size  Type
      /home/user   996M  20%   4.1G   5.0G  nfs4
-----------------------------------------------------------------------------------------------
------------------------------------- user /data storage -------------------------------------
     Filesystem    used   quota   limit   grace   files   quota   limit   grace
          /data  85.89G      0k    105G       - 1477223       0       0       -
-----------------------------------------------------------------------------------------------
```

Fine jobs in the queue:

```bash
[user@lewis4-r630-login-node675 ~]$ sbox -q
----------------------------------- Jobs in the Queue ------------------------------------
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
          23150514     Lewis jupyter-    user   R       5:29      1 lewis4-r630-hpc4-node537

```

## Interactive

`interactive` is an alias for using cluster interactively using Slurm `srun` command. The `interactive jupyter` command lets users work on the cluster from a Jupyter interface. The command submits a batch file by `sbatch` command and runs a Jupyter server on the cluster. Multiple kernels and environments can be applied to use different software and packages in JupyterLab.

### Command line options

- `-h, --help`: Show this help message and exit
- `-A, --account`: Slurm account name or project id
- `-n, --ntasks`: Number of tasks (cpus)
- `-N, --nodes`: Number of nodes
- `-p, --partition`: Partition name
- `-t, --time`: Number of hours (based on the partitions timelimit)
- `-l, --license`: Add a license to an interactive session
- `-m, --mem`: Amount of memory per GB
- `-g, --gpu`: Number of gpus
- `-k, --kernel`: Jupyter kernel for python, r, julia. The default kernel is python.
- `-e, --environment`: Python environment(s) for a JupyterLab session

**Examples**

Use the cluster interactively:

```bash
[user@lewis4-r630-login-node675 bin]$ module load sbox
[user@lewis4-r630-login-node675 ~]$ interactive
Logging into Interactive partition with 2G memory, 1 cpu for 2 hours ... 
[user@lewis4-r7425-htc5-node835 ~]$ 
```

Use the cluster interactively with more time and resources:

```bash
[user@lewis4-r630-login-node675 ~]$ interactive --mem 16 -n 6 -t 4
Logging into Interactive partition with 16G memory, 6 cpu for 4 hours ... 
[user@lewis4-r7425-htc5-node835 ~]$
```

Use the cluster interactively with a license:

```bash
[user@lewis4-r630-login-node675 ~]$ interactive --mem 16 -n 6 -t 4 -l matlab
Logging into Interactive partition with 16G memory, 6 cpu for 4 hours with a matlab license ... 
[user@lewis4-r7425-htc5-node835 ~]$
```

Use a Gpu interactively:

```bash
[user@lewis4-r630-login-node675 ~]$ interactive -p Gpu
Logging into Gpu partition with 1 gpu, 2G memory, 1 cpu for 2 hours ... 
[user@lewis4-r730-gpu3-node431 ~]$
```

Use JupyterLab:
```bash
[user@lewis4-r630-login-node675 ~]$ interactive jupyter
Logging into Lewis partition with 2G memory, 1 cpu for 2 hours ...
Starting Jupyter server (it might take about a couple minutes) ...
Starting Jupyter server ...
Starting Jupyter server ...

Jupyter Notebook is running.

Open a new terminal in your local computer and run:
ssh -NL 8888:lewis4-r630-hpc4-node303:8888 user@lewis.rnet.missouri.edu

After that open a browser and go:
http://127.0.0.1:8888/?token=9e223bd179d228e0e334f8f4a85dfd904eebd0ab9ded7e55

To stop the server run the following on the cluster:
scancel 23150533
```

Use TensorFlow with JupyterLab:
```bash
[user@lewis4-r630-login-node675 ~]$ interactive jupyter -A general-gpu -p gpu3 --mem 16 -t 8 -e tensorflow
Logging into gpu3 partition with 1 gpu, 16G memory, 1 cpu for 8 hours with account general-gpu ...
Starting Jupyter server (it might take about a couple minutes) ...
Starting Jupyter server ...
Starting Jupyter server ...
...
```

Use R with JupyterLab:
```bash
interactive jupyter -k r
Logging into Lewis partition with 2G memory, 1 cpu for 2 hours ...
Starting Jupyter server (it might take about a couple minutes) ...
Starting Jupyter server ...
Starting Jupyter server ...
...
```

## Quick install

- Download and extract the [latest Sbox release](https://github.com/ashki23/sbox/releases/latest)
- Update the `./config` file based on the cluster information. Review "Configuration" to learn more. Find a config example under `./templates/config-rcss` 
- To access a JupyerLab session, install Anaconda and create the required virtual environments and modulefiles. Review "Requirements" to learn more
- Place a modulefile for Sbox under `$MODULEPATH/sbox` directory. As a template you may use `./templates/1.1.lua`

## Requirements

Sbox requires Slurm and Python >= 3.6.8. The `interactive jupyter` command requires Anaconda and an environment module system (e.g. [Lmod](https://lmod.readthedocs.io/en/latest/)) in addition to Slurm and Python. To use R and Julia kernels in `interactive jupyter`, we need R and irkernel as well as Julia to be installed. 

Note that Sbox options might require some other Unix commands. Review the options requirement under the command line options.

The following shows how to install Anaconda and create the required virtual envs and modulefiles.

### Python kernel (Anaconda)

The `interactive jupyter` command provides a JupyterLab interface for running Python and many scientific packages by using Anaconda. To install Anaconda, find the latest version of Anaconda from [here](https://www.anaconda.com/products/individual#linux) and run:

```bash
wget https://repo.anaconda.com/archive/Anaconda3-<year.month>-Linux-x86_64.sh
bash Anaconda3-<year.month>-Linux-x86_64.sh -b -p /<cluster software path>/anaconda/<year.month>
```

In the above lines, update `<year.month>` (e.g. `2021.05`) based on the Anaconda version and `<cluster software path>` (e.g. `/cluster/software/`) based on the cluster path.

To load  Anaconda by `modeule load` command, create the following modeulefile under `$MODULEPATH/anaconda/<year.month>.lua`:

```lua
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
```

Or the following tcl modulefile under `$MODULEPATH/anaconda/<year.month>`:

```tcl
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
```

### R kernel

Users can run R scripts within a JupterLab notebook by `interactive jupyter -k r`. To have R, irkernel and many other R packages, we can create the following env including [r-essentials](https://docs.anaconda.com/anaconda/user-guide/tasks/using-r-language/) from Anaconda:

```bash
cd /<cluster software path>/anaconda/<year.month>
./bin/conda create -n r-essentials-<R version> -c conda-forge r-essentials r-base r-irkernel jupyterlab
```

In the above lines, `<cluster software path>` and `<year.month>` should be updated based on the Anaconda path and `<R version>` (e.g. `4.0.3`) based on the version of R in the env.

The following modulefile should be added to `$MODULEPATH/r-essentials/<R version>.lua` to be able to load the R env:

```lua
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
setenv("ANACONDA_ROOT", this_root)
```

Or a tcl modulefile similar to the above tcl template for Anaconda.


### Julia kernel

The `interactive jupyter -k julia` command provides Julia from a JupyterLab notebook. Julia can be installed from [Spack](https://spack.io/), [source](https://julialang.org/downloads/) or [Anaconda](https://anaconda.org/conda-forge/julia). The following shows how to install Julia from an Anaconda (Note that if Julia have been installed on the cluster, you can skip this section and use the available Julia module instead).

```bash
cd /<cluster software path>/anaconda/<year.month>
./bin/conda create -n julia-<version> -c conda-forge julia
```

In the above lines, `<cluster software path>` and `<year.month>` should be updated based on the Anaconda path and `<version>` (e.g. `1.6.1`) based on the version of Julia in the env.

The following modulefile should be added to `$MODULEPATH/julia/<version>.lua`:


```lua
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
setenv("ANACONDA_ROOT", this_root)
```

Or a tcl modulefile similar to the above tcl template for Anaconda.

Note that the first time users run `interactive jupyter -k julia`, Julia Jupyter kernal (IJulia) will be installed under `~/.julia`.

### On demand Python pakages

Popular Python pakages that are not available in Anaconda can be added to `interactive jupyter -e`. For instance the following shows how to create a TensorFlow (TF) env:

```bash
cd /<cluster software path>/anaconda/<year.month> 
./bin/conda create -n tensorflow-gpu-<version> anaconda
./bin/conda install -n tensorflow-gpu-<version> tensorflow-gpu gpustat
```

Similarly, we can create a PyTorch (PT) env with:

```bash
cd /<cluster software path>/anaconda/<year.month> 
./bin/conda create -n pytorch-<version> anaconda
./bin/conda install -n pytorch-<version> -c pytorch pytorch gpustat
```

In the above lines, `<cluster software path>` and `<year.month>` should be updated based on the Anaconda path and `<version>` (e.g. `2.4.1`) based on the version of TF or PT.

For each env, we need to add a modulefile to `$MODULEPATH/<env name>/<version>.lua`. For instance `$MODULEPATH/tensorflow/<version>.lua` is:


```lua
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
setenv("ANACONDA_ROOT", this_root)
```

Or a tcl modulefile similar to the above tcl template for Anaconda.


## Configuration

The `sbox` and `interactive` commands are reading the required information from the below JSON config file.

```json

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
```

The config file includes:

- `disk_quota_paths`: A list of pathes to the disk for finding users quotas. By default the first input is considered as the users' home path
- `cpu_partition`: A list of computational partitions
- `gpu_partition`: A list of GPU partitions
- `interactive_partition_timelimit`: A dictionary of interactive partitions (i.e. users should access by `srun`) and their time limits (hour)
- `jupyter_partition_timelimit`: A dictionary of computational/gpu partitions that users can run Jupter servers interactively and their time limits (hour)
- `partition_qos`: A dictionary of partitions and the corresponding quality of services
- `kernel_module`: A dictionary of kernels and the corresponding modules
- `env_module`: A dictionary of Python virtual environments and the corresponding modules

For example:

```json
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
```
