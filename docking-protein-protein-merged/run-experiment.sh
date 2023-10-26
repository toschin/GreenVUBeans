#!/bin/bash

job1=docking-protein-protein-local-32.cfg
job2=docking-protein-protein-hpc-1-50.cfg
job3=docking-protein-protein-hpc-1-100.cfg
job4=docking-protein-protein-hpc-1-4949.cfg
job5=docking-protein-protein-hpc-32-50.cfg
job6=docking-protein-protein-hpc-32-100.cfg
job7=docking-protein-protein-hpc-32-4949.cfg
job8=docking-protein-protein-local-8.cfg
job9=docking-protein-protein-local-16.cfg
job10=docking-protein-protein-hpc-16-50.cfg
job11=docking-protein-protein-hpc-16-100.cfg
job12=docking-protein-protein-hpc-16-4949.cfg

job1_id=$( sbatch --job-name="$job1"  --nodelist=gl6                                 haddock3 $job1  | awk '{print $NF}') # local
job2_id=$( sbatch --job-name="$job2"                 --dependency=afterany:$job1_id  haddock3 $job2  | awk '{print $NF}')
job3_id=$( sbatch --job-name="$job3"                 --dependency=afterany:$job2_id  haddock3 $job3  | awk '{print $NF}')
job4_id=$( sbatch --job-name="$job4"                 --dependency=afterany:$job3_id  haddock3 $job4  | awk '{print $NF}')
job5_id=$( sbatch --job-name="$job5"                 --dependency=afterany:$job4_id  haddock3 $job5  | awk '{print $NF}')
job6_id=$( sbatch --job-name="$job6"                 --dependency=afterany:$job5_id  haddock3 $job6  | awk '{print $NF}')
job7_id=$( sbatch --job-name="$job7"                 --dependency=afterany:$job6_id  haddock3 $job7  | awk '{print $NF}')
job8_id=$( sbatch --job-name="$job8"  --nodelist=gl6 --dependency=afterany:$job7_id  haddock3 $job8  | awk '{print $NF}') # local
job9_id=$( sbatch --job-name="$job9"  --nodelist=gl6 --dependency=afterany:$job8_id  haddock3 $job9  | awk '{print $NF}') # local
job10_id=$(sbatch --job-name="$job10"                --dependency=afterany:$job9_id  haddock3 $job10 | awk '{print $NF}')
job11_id=$(sbatch --job-name="$job11"                --dependency=afterany:$job10_id haddock3 $job11 | awk '{print $NF}')
job12_id=$(sbatch --job-name="$job12"                --dependency=afterany:$job11_id haddock3 $job12 | awk '{print $NF}')

cat > check-jobs.sh << EOF
#!/bin/bash
sacct -o jobid,jobname%50,cluster,Node,state,start,end,elapsed,MaxRSS,AveRSS,ConsumedEnergy,AveDiskRead,AveDiskWrite,AveVMSize,NCPUS \
    -j $job1_id,$job2_id,$job3_id,$job4_id,$job5_id,$job6_id,$job7_id,$job8_id,$job9_id,$job10_id,$job11_id,$job12_id \
    > experiment-data.txt
cp experiment-data.txt ~/haddock3/data/
EOF