#!/bin/bash
#SBATCH --job-name=dppm-mpi-batch-2-nodes

job1=docking-protein-protein-merged-mpi-4.job
job2=docking-protein-protein-merged-mpi-32.job
job3=docking-protein-protein-merged-mpi-64.job

job1_name=dppm-mpi-4
job2_name=dppm-mpi-32
job3_name=dppm-mpi-64

job1_id=$(sbatch --job-name="$job1_name" $job1 | awk '{print $NF}')
echo "jobid1: $job1_id"
job2_id=$(sbatch --job-name="$job2_name" --dependency=afterany:$job1_id $job2 | awk '{print $NF}')
echo "jobid2: $job2_id"
sbatch --job-name="$job3_name" --dependency=afterany:$job2_id $job3
