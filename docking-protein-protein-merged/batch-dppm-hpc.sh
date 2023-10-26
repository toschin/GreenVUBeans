#!/bin/bash
#SBATCH --job-name=dppm-hpc-batch

job1_id=$(sbatch --job-name="dppm-hpc-100" haddock3 docking-protein-protein-hpc-100.cfg --restart=0 | awk '{print $NF}')
echo "jobid1: $job1_id"
sbatch --job-name="dppm-hpc-4949" --dependency=afterany:$job1_id haddock3 docking-protein-protein-hpc-4949.cfg --restart=0
