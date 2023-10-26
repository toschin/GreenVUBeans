#!/bin/bash/

filename="docking-protein-protein-local-"
cfg_template="template/${filename}template.cfg"

cfg_template_node="___NODE___"
cfg_template_ncores="___NCORES___"

# script that accepts ncores, nodes, tasks_per_node as cli arguments and replaces them in template files

# get cli arguments
node=$1
ncores=$2

#create cfg and job files with ncores in filename
cfg_file="$filename$ncores-$node.cfg"

echo "filename: $cfg_file, node: $node, ncores: $ncores"

# copy template files
cp $cfg_template $cfg_file

# replace ncores in cfg file
sed -i "s/$cfg_template_ncores/$ncores/g" $cfg_file
sed -i "s/$cfg_template_node/$node/g" $cfg_file
