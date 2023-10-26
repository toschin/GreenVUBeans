#!/bin/bash

job1=docking-protein-protein-local-2-gl5.cfg
job2=docking-protein-protein-local-2-GreenLab-STF.cfg
job3=docking-protein-protein-local-4-gl5.cfg
job4=docking-protein-protein-local-4-GreenLab-STF.cfg
job5=docking-protein-protein-local-8-gl5.cfg
job6=docking-protein-protein-local-8-GreenLab-STF.cfg
job7=docking-protein-protein-local-32-gl5.cfg
job8=docking-protein-protein-local-16-gl5.cfg

job1_id=$(sbatch --job-name="$job1" --nodelist=gl5                                         haddock3 $job1 | awk '{print $NF}')
job2_id=$(sbatch --job-name="$job2" --nodelist=GreenLab-STF --dependency=afterany:$job1_id haddock3 $job2 | awk '{print $NF}')
job3_id=$(sbatch --job-name="$job3" --nodelist=gl5          --dependency=afterany:$job2_id haddock3 $job3 | awk '{print $NF}')
job4_id=$(sbatch --job-name="$job4" --nodelist=GreenLab-STF --dependency=afterany:$job3_id haddock3 $job4 | awk '{print $NF}')
job5_id=$(sbatch --job-name="$job5" --nodelist=gl5          --dependency=afterany:$job4_id haddock3 $job5 | awk '{print $NF}')
job6_id=$(sbatch --job-name="$job6" --nodelist=GreenLab-STF --dependency=afterany:$job5_id haddock3 $job6 | awk '{print $NF}')
job7_id=$(sbatch --job-name="$job7" --nodelist=gl5          --dependency=afterany:$job6_id haddock3 $job7 | awk '{print $NF}')
job8_id=$(sbatch --job-name="$job8" --nodelist=gl5          --dependency=afterany:$job7_id haddock3 $job8 | awk '{print $NF}')

cat > check-jobs-local.sh << EOF
#!/bin/bash
sacct -o jobid,jobname%50,cluster,Node,state,start,end,elapsed,MaxRSS,AveRSS,ConsumedEnergy,AveDiskRead,AveDiskWrite,AveVMSize,NCPUS \
    -j $job1_id,$job2_id,$job3_id,$job4_id,$job5_id,$job6_id,$job7_id,$job8_id \
    > experiment-data-local.txt
cp experiment-data-local.txt ~/haddock3/data/
EOF