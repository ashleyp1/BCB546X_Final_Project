##final project code

library(readxl)

##had to go in excel and separate the sheets in the workbook into two diff workbooks
microsatellite_genotype <- read_excel("Microsatellite genotype data.xlsx")
sampling_info <- read_excel("sampling_information.xlsx")

mtDNA_haplotypes <- read.table("Haplotypes of mtDNA-final.txt", sep = '\t', fill = T)
