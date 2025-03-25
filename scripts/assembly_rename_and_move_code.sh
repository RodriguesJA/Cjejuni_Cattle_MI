#rename assemblies based on folder
find . -type f -name ".fastq" -printf "/%P\n" | while read FILE ;
cp **/*.fastq /f/Cattle_Genomes/Process_Reads/reads/