#!/bin/bash

job1=docking-protein-protein-hpc-1-100-2nd.cfg

job1_id=$(sbatch --job-name="$job1" haddock3 $job1 | awk '{print $NF}')

cat > check-jobs-2.sh << EOF
#!/bin/bash
sacct -o jobid,jobname%50,cluster,Node,state,start,end,elapsed,MaxRSS,AveRSS,ConsumedEnergy,AveDiskRead,AveDiskWrite,AveVMSize,NCPUS \
    -j $job1_id \
    > experiment-data-2.txt
cp experiment-data-2.txt ~/haddock3/data/
EOF