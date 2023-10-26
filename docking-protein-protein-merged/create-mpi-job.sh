#!/bin/bash/

filename=$1
cfg_template="template/${filename}template.cfg"
job_template="template/${filename}template.job"

cfg_template_ncores="___NCORES___"
job_template_nodes="___NODES___"
job_template_tasks_per_node="___TASKS_PER_NODE___"

# script that accepts ncores, nodes, tasks_per_node as cli arguments and replaces them in template files

# get cli arguments
ncores=$2
nodes=$3
tasks_per_node=$4

#create cfg and job files with ncores in filename
cfg_file="${filename}${ncores}.cfg"
job_file="${filename}${ncores}.job"

echo "filename: $job_file, ncores: $ncores, nodes: $nodes, tasks_per_node: $tasks_per_node"

# copy template files
cp $cfg_template $cfg_file
cp $job_template $job_file

# replace ncores in cfg file
sed -i "s/$cfg_template_ncores/$ncores/g" $cfg_file

# replace nodes and tasks_per_node in job file
sed -i "s/$cfg_template_ncores/$ncores/g" $job_file
sed -i "s/$job_template_nodes/$nodes/g" $job_file
sed -i "s/$job_template_tasks_per_node/$tasks_per_node/g" $job_file
