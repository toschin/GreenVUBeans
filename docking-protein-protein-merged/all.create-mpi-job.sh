#!/bin/bash

filename="docking-protein-protein-merged-mpi-"
config_file="all-mpi-jobs.cfg.txt"
script_file="create-mpi-job.sh"

# Skip the first line
sed 1d "$config_file" | while IFS=$'\t' read -r ncores nodes tasks_per_node
do
    # Launch create-mpi-job.sh with the arguments
    bash "$script_file" "$filename" "$ncores" "$nodes" "$tasks_per_node"
done