##final project code

library(genepop)
library(readxl)
library(tidyverse)

##had to go in excel and separate the sheets in the workbook into two diff workbooks
microsatellite_genotype <- read_excel("Microsatellite genotype data.xlsx")
sampling_info <- read_excel("sampling_information.xlsx")
mtDNA_haplotypes <- read.table("Haplotypes of mtDNA-final.txt", sep = '\t', fill = T)

##save haplotype data as characters for grep
mtDNA_haplotypes[] <- lapply(mtDNA_haplotypes, as.character)

##formatting mtDNA_haplotypes into fasta format
mtDNA_haplotypes <- subset(mtDNA_haplotypes, V3=="") 
mtDNA_haplotypes$V2 <- NULL
mtDNA_haplotypes$V3 <- NULL

##save the cleaned up tables
write.table(mtDNA_haplotypes, "mtDNA_haplotypes.fasta",quote = F, row.names = F,
            col.names = F)

## genepop
##getting the table into genepop format. Had to go in and edit by hand

microsatellite_genotype[c(2),] =  paste(microsatellite_genotype[c(2),], ",", sep = "")
colnames(microsatellite_genotype) <- microsatellite_genotype[c(2),] ##rename columns
microsatellite_genotype <- microsatellite_genotype[-c(1, 2),] ##remove top two rows, now useless
microsatellite_genotype$`Individual ID,` =  paste(microsatellite_genotype$`Individual ID,`, ",")
  ##add commas to every ID

microsatellite_genotype[] <- lapply(microsatellite_genotype, as.character)

## any position that has one char has a 0 added in front so every position has
##2 character, genepop format
for (col in 3:ncol(microsatellite_genotype)){
  for (row in 1:nrow(microsatellite_genotype)) {
    n <- microsatellite_genotype[row, col]
    if(nchar(n)!= 2) {
      n = paste("0", n, sep = "")
    }
    microsatellite_genotype[row, col] <- n
  }
}  

##combine the two columns for each locus, so every locus has 4 numbers,
##two number for each allele, genepop format
for (n in 3:11){
  microsatellite_genotype[,c(n)] <- do.call(paste, c(microsatellite_genotype[,c(n,n+1)], sep = "")) 
  microsatellite_genotype <- microsatellite_genotype[,-c(n+1)]
}

##separate each population by the word pop
microsatellite_genotype <- add_row(microsatellite_genotype,`Individual ID,`='pop',
                                   `Population,` = 'NA', .before = 1)
for (row in 2:218) {
  x <- microsatellite_genotype[row, c(2)]
  y <- microsatellite_genotype[row+1, c(2)]
  if(x != "NA"){
    if(x != y){
      microsatellite_genotype <- add_row(microsatellite_genotype,
                                         `Individual ID,`='pop',`Population,` = 'NA',
                                         .after = row)
    }
  }
}
##remove population column
microsatellite_genotype$`Population,` <- NULL

write.table(microsatellite_genotype, "microsatellite_geno_pop.txt", na = "" ,quote = F,
            row.names = F, append = F)
##remove individual id colname and add comma between loci
##Open microsattelit_geno_pop.txt and hit enter after "Individual ID,"
##so that it is the first line and the next is the list of loci
##remove the comma after SSR9(H33)

##hardy-weinburg
test_HW("microsatellite_geno_pop.txt", which = "Proba", outputFile = "HW_microsatellite.txt.P", settingsFile = "",
        enumeration = FALSE, dememorization = 10000, batches = 100,iterations = 1000,
        verbose = interactive())

##linkage disequilibrium
test_LD("microsatellite_geno_pop.txt", outputFile = "LD_microsatellite.txt", settingsFile = "",
        dememorization = 10000, batches = 100, iterations = 5000,
        verbose = interactive())
write_LD_tables("microsatellite_geno_pop.txt", outputFile = "", verbose = interactive())

##FST
Fst("microsatellite_geno_pop.txt", sizes = FALSE, pairs = FALSE, outputFile = "FST_microsatellite.txt",
    dataType = "Diploid", verbose = interactive())
