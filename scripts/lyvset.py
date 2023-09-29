import os
import urllib
import re

Genomes_file = open( "[Directory] ST982.txt" ) #Text file with all the genomes to be used in this pipeline. File is used instead of a directory in order to edit which genomes are utilized easily
Genomes_pair = Genomes_file.readlines() #Here, you are reading all of the file names within a specific folder readlines enable this fx 

for i in Genomes_pair: #Here, we are stripping tabs and spaces from file names 
	i = i.rstrip("\n")
	i = i.rstrip("\r") 
	print (i)
	pairGenome = i.split("\t")  
	RefGenome = str(pairGenome[0])  #Here, we place all of the integers within our file that we read and strip into an array. In this case, each TW# Will be in an array that is called RefGenome
	os.system("singularity run /opt/software/lyveset/lyveset.1.1.4f.sif shuffleSplitReads.pl --numcpus 8 -o /[output directory]" +RefGenome+ "/interleaved /[input file directory]/" +RefGenome+ "/*fastq.gz")
	print(RefGenome + "_DONE")
#Adapted from Dr. Heather Blankenship, Ph.D., who wrote the first draft of this script.
