#!/usr/bin/sh

########## Define Resources Needed with SBATCH Lines ##########
#SBATCH --job-name=panaroo # give your job a name for easier identification (same as -J)
#SBATCH --ntasks=1     # number of tasks - how many tasks (nodes) does your job require? (same as -n)
#SBATCH --cpus-per-task=32 # number of CPUs (or cores) per task (same as -c)
#SBATCH --mem=160G     # memory required per node - amount of memory (in bytes)
#SBATCH --partition=batch
#SBATCH --output=/
#SBATCH --error=/
#SBATCH -v

########## Diplay the job context ######
echo Job: $SLURM_JOB_NAME with ID $SLURM_JOB_ID
echo Running on host `hostname`
echo Job started at `date '+%T %a %d %b %Y'`
echo Directory is `pwd`
echo Using $SLURM_NTASKS processors across $SLURM_NNODES nodes

######### Assign path variables ########
INPUT_DIRECTORY=
OUTPUT_DIRECTORY=
ALIGNMENT=

########## modules/env to load ###########
source 
conda activate panaroo
umask g+rwx

########## Running panaroo ###########

panaroo -i $INPUT_DIRECTORY/*.gff -o $OUTPUT_DIRECTORY \
  --clean-mode strict \
  -c 0.95 -f 0.7 \
  -a core \
  --aligner mafft \
  --codons \
  --core_threshold 0.95 \
  -t 10 

conda deactivate &&

########## Loading iqtree  ###########
conda activate iqtree
umask g+rwx
cd $OUTPUT_DIRECTORY

########## Running IQ  ###########
iqtree -s $ALIGNMENT -m MFP -B 1000 -T AUTO

conda deactivate

##### Final time stamp ######
echo Job finished at `date '+%T %a %d %b %Y'`