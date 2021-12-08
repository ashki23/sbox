Sbox
----

``sbox`` command includes various Slurm commands at one place. Users can
use different options to find the information about the cluster and
their accounts and activities. Beyond the Slurm commands, ``sbox``
provides some Unix features including users’ groups, disk quotas and
starting ssh agents. The ssh-agent lets users communicate with clients
outside the cluster such as GitHub and GitLab or with other nodes within
the cluster via ssh without asking for the passphrase (you need the
passphrase to start the ssh-agent).

Command line options
~~~~~~~~~~~~~~~~~~~~

-  ``-h, --help``: Show the help message and exit.
-  ``-a, --account``: Return user’s Slurm accounts by using Slurm
   ``sacctmgr``. If the cluster does not use Slurm for users’ account
   management, it returns empty output.
-  ``-f, --fairshare``: Return users’ fairshare by using Slurm
   ``sshare`` command. If the cluster does not follow a fairshare model,
   it returns empty output.
-  ``-g, --group``: Return user’s posix groups by using Unix ``groups``
   command.
-  ``-q, --queue``: Return user’s jobs in the Slurm queue by Slurm using
   ``squeue`` command.
-  ``-j, --job``: Show a running/pending job info by using Slurm
   ``scontrol`` command. It requires a valid job ID as argument.
-  ``-c, --cpu``: Return computational resources including number of
   cores and amount of memory on each node. It uses Slurm ``sjstat``
   command.
-  ``-p, --partition``: Show cluster partitions by using Slurm ``sinfo``
   command.
-  ``-u, --user``: Store a user ID. By default it uses ``$USER`` as user
   ID for any query that needs a user ID. It can be used with other
   options to find the information for other users.
-  ``-v, --version``: Show program’s version number and exit.
-  ``--eff``: Show efficiency of a job. It requires a valid job ID as
   argument. It uses Slurm ``seff`` command for completed/finished jobs
   and Unix ``top`` command for a running job.
-  ``--history``: Return jobs history for last day, week, month or year.
   It requires one of the day/week/month/year options as an argument. It
   uses Slurm ``sacct`` command and returns empty output if the cluster
   does not use Slurm for users’ account management.
-  ``--pending``: Return user’s pending jobs by using Slurm ``squeue``
   command.
-  ``--running``: Return user’s running jobs by using Slurm ``squeue``
   command.
-  ``--cancel``: Cancel jobs by a single ID or a comma separated list of
   IDs using Slurm ``scancel`` command.
-  ``--qos``: Show user’s quality of services (QOS) and a list of
   available QOS in the cluster. It uses Slurm ``sacctmgr show assoc``
   command and returns empty output if the cluster does not use Slurm
   for users’ account management.
-  ``--quota``: Return user’s disk quotas. It uses ``lfs quota`` command
   for LFS systems and Unix ``df`` command for NFS systems. It returns
   pooled size of the disk if the cluster does not have user/group
   storage accounts.
-  ``--ncpu``: Show number of available cpus on the cluster using Slurm
   ``sinfo`` command.
-  ``--ncgu``: Show number of available gpus on the cluster using Slurm
   ``squeue`` and ``sinfo`` commands.
-  ``--gpu``: Show gpu resources including gpu cards’ name and numbers
   using Slurm ``sinfo`` command.
-  ``--license``: Show available license servers using Slurm
   ``scontrol`` command.
-  ``--reserve``: Show Slurm reservations using Slurm ``scontrol``
   command.
-  ``--topusage``: Show top usage users using Slurm ``sreport`` command.
-  ``--whodat``: Show users informations by UID. It uses ``ldapsearch``
   command and returns empty output if the cluster does not use LDAP.
-  ``--whodat2``: Show users informations by name. It uses
   ``ldapsearch``\ command and returns empty output if the cluster does
   not use LDAP.
-  ``--agent``: Start, stop and list user’s ssh-agents on the current
   host. It requires one of the start/stop/list options as an argument.
   Use ``ssh -o StrictHostKeyChecking=no`` to disable asking for host
   key acceptances.
-  ``--report``: Show current cluster utilization based on the running
   jobs. It uses slurm ``sinfo`` and ``squeue`` commands.
-  ``--report2``: Show cluster utilization based on ended jobs in last
   day. It uses Slurm ``sacct`` command.

**Examples**

Jobs histoty:

.. code:: bash

   [user@lewis4-r630-login-node675 ~]$ sbox --hist day
   -------------------------------------------------------------------------------- Jobs History - Last Day ---------------------------------------------------------------------
        JobID   User Account      State Partition     QOS NCPU NNod ReqMem              Submit   Reserved               Start    Elapsed                 End             NodeList
   ---------- ------ ------- ---------- --------- ------- ---- ---- ------ ------------------- ---------- ------------------- ---------- ------------------- --------------------
     23126125  user  general  COMPLETED Interact+ intera+    1    1    2Gn 2021-07-28T01:25:05   00:00:00 2021-07-28T01:25:05   00:00:03 2021-07-28T01:25:08 lewis4-c8k-hpc2-nod+
     23126126  user  general  COMPLETED Interact+ intera+    1    1    2Gn 2021-07-28T01:25:13   00:00:00 2021-07-28T01:25:13   00:00:03 2021-07-28T01:25:16 lewis4-c8k-hpc2-nod+
     23126127  user  general  COMPLETED Interact+ intera+    1    1    2Gn 2021-07-28T01:25:20   00:00:00 2021-07-28T01:25:20   00:00:08 2021-07-28T01:25:28 lewis4-c8k-hpc2-nod+
     23126128  user  genera+  COMPLETED Interact+ intera+    1    1    2Gn 2021-07-28T01:25:49   00:00:00 2021-07-28T01:25:49   00:00:03 2021-07-28T01:25:52 lewis4-c8k-hpc2-nod+
     23126129  user  genera+  COMPLETED Interact+ intera+    1    1    2Gn 2021-07-28T01:26:05   00:00:00 2021-07-28T01:26:05   00:00:06 2021-07-28T01:26:11 lewis4-c8k-hpc2-nod+
     23126130  user  genera+  COMPLETED       Gpu  normal    1    1    2Gn 2021-07-28T01:26:38   00:00:02 2021-07-28T01:26:40   00:00:11 2021-07-28T01:26:51 lewis4-z10pg-gpu3-n+
     23126131  user  genera+ CANCELLED+       Gpu  normal    1    1    2Gn 2021-07-28T01:27:43   00:00:01 2021-07-28T01:27:44   00:01:03 2021-07-28T01:28:47 lewis4-z10pg-gpu3-n+

Jobs efficiency for running and compeleted jobs:

.. code:: bash

   [user@lewis4-r630-login-node675 ~]$ sbox --eff 23227816
   ------------------------------------- Job Efficiency -------------------------------------
      PID USER      PR  NI    VIRT    RES     SHR  S   %CPU   %MEM   TIME+   COMMAND
    47262 user      20   0  115700   3888     1600 S   0.0    0.0    0:00.03 bash
    47346 user      20   0  113292   149298   1256 S   99.0   23.0   0:13.30 python

   RES: shows resident memory which is accurate representation of how much actual physical memory a process is consuming
   %CPU: shows the percentage of the CPU that is being used by the process

.. code:: bash

   [user@lewis4-r630-login-node675 ~]$ sbox --eff 23126131
   ------------------------------------- Job Efficiency -------------------------------------
   Job ID: 23126131
   Cluster: lewis4
   User/Group: user/user
   State: COMPLETED (exit code 0)
   Cores: 1
   CPU Utilized: 00:11:01
   CPU Efficiency: 48.59% of 00:21:03 core-walltime
   Memory Utilized: 445.80 MB
   Memory Efficiency: 24.24% of 2.00 GB

Accounts, fairshares, and groups:

.. code:: bash

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

Disk quotas:

.. code:: bash

   [user@lewis4-r630-login-node675 ~]$ sbox --quo
   ------------------------------------- user /home storage -------------------------------------
         File         Used  Use%  Avail  Size  Type
         /home/user   996M  20%   4.1G   5.0G  nfs4
   -----------------------------------------------------------------------------------------------
   ------------------------------------- user /data storage -------------------------------------
        Filesystem    used   quota   limit   grace   files   quota   limit   grace
             /data  85.89G      0k    105G       - 1477223       0       0       -
   -----------------------------------------------------------------------------------------------

Jobs in the queue:

.. code:: bash

   [user@lewis4-r630-login-node675 ~]$ sbox -q
   ----------------------------------- Jobs in the Queue ------------------------------------
                JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             23150514     Lewis jupyter-    user   R       5:29      1 lewis4-r630-hpc4-node537

Cluster resources:

.. code:: bash

   [user@lewis4-r630-login-node675 ~]$ sbox --ngpu
   ------------------------------------- Number of GPUs -------------------------------------
   Partition Gpu has 19 gpus available out of 27 (70%)
   Partition gpu3 has 15 gpus available out of 15 (100%)
   Partition gpu4 has 4 gpus available out of 12 (33%)

.. code:: bash

   [user@lewis4-r630-login-node675 ~]$ sbox --ncpu
   ------------------------------------- Number of CPUs -------------------------------------
   Partition Interactive has 158 cpus available out of 160 (99%)
   Partition Lewis has 161 cpus available out of 2344 (7%)
   Partition Serial has 42 cpus available out of 48 (88%)
   Partition Dtn has 35 cpus available out of 36 (97%)
   Partition hpc3 has 24 cpus available out of 456 (5%)
   Partition hpc4 has 79 cpus available out of 1008 (8%)
   Partition hpc4rc has 58 cpus available out of 952 (6%)
   Partition hpc5 has 70 cpus available out of 1400 (5%)
   Partition hpc6 has 0 cpus available out of 2976 (0%)
   Partition General has 1837 cpus available out of 7008 (26%)
   Partition Gpu has 383 cpus available out of 412 (93%)

Interactive
-----------

``interactive`` is an alias for using cluster interactively using Slurm
``srun`` and ``sbatch`` commands. The ``interactive jupyter`` provides a
JupyterLab interface for using scientific software including Python, R,
Julia, and their libraries. The command submits a batch file by
``sbatch`` command and runs a Jupyter server on the cluster. Multiple
kernels and environments can be applied to use different software and
packages in JupyterLab.

.. _command-line-options-1:

Command line options
~~~~~~~~~~~~~~~~~~~~

-  ``-h, --help``: Show this help message and exit.
-  ``-a, --account``: Slurm account name or project ID.
-  ``-n, --ntasks``: Number of tasks (cpus).
-  ``-N, --nodes``: Number of nodes.
-  ``-p, --partition``: Partition name.
-  ``-t, --time``: Number of hours based on the partitions timelimit.
-  ``-l, --license``: Add a license to an interactive session.
-  ``-m, --mem``: Amount of memory (per GB).
-  ``-g, --gpu``: Number of gpus.
-  ``-k, --kernel``: Jupyter kernel for python, r, julia. The default
   kernel is python.
-  ``-e, --environment``: Virtual environment(s) for a JupyterLab
   session.
-  ``-E, --myenv``: Path to a local virtual environment. The local
   virtual envs should contain JupyterLab.

**Examples**

Using the cluster interactively:

.. code:: bash

   [user@lewis4-r630-login-node675 ~]$ interactive
   Logging into Interactive partition with 2G memory, 1 cpu for 2 hours ... 
   [user@lewis4-r7425-htc5-node835 ~]$ 

Using the cluster interactively with more time and resources:

.. code:: bash

   [user@lewis4-r630-login-node675 ~]$ interactive --mem 16 -n 6 -t 4
   Logging into Interactive partition with 16G memory, 6 cpu for 4 hours ... 
   [user@lewis4-r7425-htc5-node835 ~]$

Using the cluster interactively with a license:

.. code:: bash

   [user@lewis4-r630-login-node675 ~]$ interactive --mem 16 -n 6 -t 4 -l matlab
   Logging into Interactive partition with 16G memory, 6 cpu for 4 hours with a matlab license ... 
   [user@lewis4-r7425-htc5-node835 ~]$

Using a Gpu interactively:

.. code:: bash

   [user@lewis4-r630-login-node675 ~]$ interactive -p Gpu
   Logging into Gpu partition with 1 gpu, 2G memory, 1 cpu for 2 hours ... 
   [user@lewis4-r730-gpu3-node431 ~]$

Using JupyterLab:

.. code:: bash

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

Using JupyterLab with R kernel:

.. code:: bash

   [user@lewis4-r630-login-node675 ~]$ interactive jupyter -k r
   Logging into Lewis partition with 2G memory, 1 cpu for 2 hours ...
   Starting Jupyter server (it might take about a couple minutes) ...
   Starting Jupyter server ...
   Starting Jupyter server ...
   ...

Using TensorFlow on JupyterLab by a different account and on a partition
with 16 GB memory for 8 hours:

.. code:: bash

   [user@lewis4-r630-login-node675 ~]$ interactive jupyter -a general-gpu -p gpu3 --mem 16 -t 8 -e tensorflow
   Logging into gpu3 partition with 1 gpu, 16G memory, 1 cpu for 8 hours with account general-gpu ...
   Starting Jupyter server (it might take about a couple minutes) ...
   Starting Jupyter server ...
   Starting Jupyter server ...
   ...

**Note**: Users can install other packages and mix local packages with
the premade environments. For example, for Python:

.. code:: bash

   pip install --target </path/my-packages/lib/> <pkg-name>
   export PYTHONPATH=</path/my-packages/lib/>:$PYTHONPATH

For R, run the following in R:

.. code:: r

   dir.create("<your/path/for/R/version>")
   install.packages("<pkg-name>", repos = "http://cran.us.r-project.org", lib = "<your/path/for/R/version>")
   .libPaths("<your/path/for/R/version>")

Using a local virtual environment:

.. code:: bash

   [user@lewis4-r630-login-node675 ~]$ interactive jupyter -E </path/to/local/env>
   Logging into Lewis partition with 2G memory, 1 cpu for 2 hours ...
   Starting Jupyter server (it might take about a couple minutes) ...
   Starting Jupyter server ...

**Note**: The local environments must include ``jupyterlab``. For R
environments, they must also contain ``r-irkernel``. For instance:

.. code:: bash

   conda create -p </path/to/local/env> -c conda-forge r-base jupyterlab r-irkernel
