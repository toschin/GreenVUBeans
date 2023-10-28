# GreenVUBeans
Project for the Green Lab course at VU Amsterdam (2023)

## Run experiment
The files necessary to run the experiment are available in the directory ``docking-protein-protein-merged``, which is the example on which our study is based. 

The first step for running the experiment is to have [HADDOCK3](https://github.com/haddocking/haddock3) installed on your environment. 

Three scripts were written to run the different aspects of the experiments:
* ``run-experiment.sh``: this script runs all the HPC config needed with the local config on the GL6 node.
* ``run-experiment-local.sh``: this script runs the local config on the nodes GL2 and GL5.
* ``run-experiment-2.sh``: this script is used to re-run the HPC config with parameter concat 1 and queue limit 100, because the result of the first was suspicuous.

Before running the scripts, make sure that the relevant config files are copied onto your environment. For example, when running ``run-experiment-2.sh``, you need the file ``docking-protein-protein-hpc-1-100-2nd.cfg``.

Once the jobs launched by the script for running the experiment are done, another script is created to fetch the results. Those scripts are:
* ``check-jobs.sh`` created from ``run-experiment.sh``: this script exports the data needed for our analysis (runtime, energy consumed, memory used) from the runs into a file ``experiment-data.txt``.
* ``check-jobs-local.sh`` created from ``run-experiment-local.sh``: this script exports the data needed for our analysis (runtime, energy consumed, memory used) from the runs into a file ``experiment-data-local.txt``.
* ``check-jobs-2.sh`` created from ``run-experiment-2.sh``: this script exports the data needed for our analysis (runtime, energy consumed, memory used) from the runs into a file ``experiment-data-2.txt``.

After running these last scripts, the experiment runs are done and the corresponding data is extracted; ready for analysis.


## Analyse data

Two scripts are available for analysing the results of our experiment in the ``src`` directory.

* The file ``preprocessing/preprocessing.Rmd`` is used to preprocess the data before the real analysis.
* The file ``analysis/analysis.Rmd`` contains all the relevant commands that we used to analyse our data and can be used as a roadmap in order to read the results section of the report.