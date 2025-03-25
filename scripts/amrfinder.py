from decimal import *
import os

Genomes_file = open( "/mnt/gs21/scratch/rodri651/campy_ids.txt" ) #Text file with all the genomes to be used in this pipeline. File is used instead of a directory in order to easily edit which genomes are utilized
Genomes_pair = Genomes_file.readlines() #Here you are reading all of the file names within a specific folder readlines enables this fx 

for i in Genomes_pair: #Here we are stripping tabs and spaces from file names 
	i = i.rstrip("\n")
	i = i.rstrip("\r") 
	print (i)
	pairGenome = i.split("\t")  
	RefGenome = str(pairGenome[0])  #Here we place all of the integers within our file that we read and stripped into an array. In this case each TW# Will be in an array that is called RefGenome
	os.system("amrfinder -n /mnt/gs21/scratch/rodri651/genomes_allcj/"+RefGenome+".fasta -O Campylobacter --plus --name" + " " +RefGenome+" --nucleotide_output /mnt/gs21/scratch/rodri651/campy_outputs/amrfinderplus/"+RefGenome+"_amr.fasta -o /mnt/gs21/scratch/rodri651/campy_outputs/amrfinderplus/"+RefGenome+".tsv")
	print(RefGenome + "_DONE")