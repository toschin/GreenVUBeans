#!/bin/bash
sacct -o jobid,jobname%50,cluster,Node,state,start,end,elapsed,MaxRSS,AveRSS,ConsumedEnergy,AveDiskRead,AveDiskWrite,AveVMSize,NCPUS     -j 29411,29412,29413,29414,29415,29416,29417,29418,29419,29420,29421,29422     > experiment-data.txt
cp experiment-data.txt ~/haddock3/data/
