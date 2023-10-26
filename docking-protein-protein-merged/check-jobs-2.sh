#!/bin/bash
sacct -o jobid,jobname%50,cluster,Node,state,start,end,elapsed,MaxRSS,AveRSS,ConsumedEnergy,AveDiskRead,AveDiskWrite,AveVMSize,NCPUS     -j 34314     > experiment-data-2.txt
cp experiment-data-2.txt ~/haddock3/data/
