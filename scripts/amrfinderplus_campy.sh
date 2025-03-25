#!/usr/bin/sh
 ########## Define Resources Needed with SBATCH Lines ##########
#SBATCH --job-name=amrfinderplus # give your job a name for easier identification (same as -J)
#SBATCH --ntasks=1     # number of tasks - how many tasks (nodes) does your job require? (same as -n)
#SBATCH --cpus-per-task=16 # number of CPUs (or cores) per task (same as -c)
#SBATCH --mem=50G     # memory required per node - amount of memory (in bytes)
#SBATCH --partition=batch
#SBATCH --output= #Standard output
#SBATCH --error= #Standard error log
#SBATCH -v

########## Diplay the job context ######
echo Job: $SLURM_JOB_NAME with ID $SLURM_JOB_ID
echo Running on host `hostname`
echo Job started at `date '+%T %a %d %b %Y'`
echo Directory is `pwd`
echo Using $SLURM_NTASKS processors across $SLURM_NNODES nodes

######### Assign path variables ########
OUTPUT_DIRECTORY=
output_file=

########## modules/env to load ###########
source 
conda activate amrfinderplus
umask g+rwx

####### Runninng AmrFinderPlus ##########
python /amrfinder.py

conda deactivate &&

########## Concatenating files #############
cd $OUTPUT_DIRECTORY

echo -e "AccessionNum\tProtein_identifier\tContig_id\tStart\tStop\tStrand\tGene_symbol\tSequence_name\tScope\tElement_type\tElement_subtype\tClass\tSubclass\tMethod\tTarget_length\tReference_sequence_length\t%_Coverage_of_reference_sequence\t%Identity_to_reference_sequence\tAlignment_length\tAccession_of_closest_Sequence\tName_of_closest_sequence\tHMM_id\tHMM_description" > "$output_file"

# Concatenate all files, but keep only the header from the first file and modify the filename

for f in *.tsv; do
  filename=${f%_*}
  tail -n +2 $f >> "$output_file"
done

##### Final time stamp ######
echo Job finished at `date '+%T %a %d %b %Y'`
