##final project code

library(genepop)
library(readxl)

##had to go in excel and separate the sheets in the workbook into two diff workbooks
microsatellite_genotype <- read_excel("Microsatellite genotype data.xlsx")
microsatellite_geno <- read_excel("simple_microsatellite.xlsx", col_names = T)
sampling_info <- read_excel("sampling_information.xlsx")
mtDNA_haplotypes <- read.table("Haplotypes of mtDNA-final.txt", sep = '\t', fill = T)


##save haplotype data as characters for grep
mtDNA_haplotypes[] <- lapply(mtDNA_haplotypes, as.character)

mtDNA_haplotypes <- subset(mtDNA_haplotypes, V3=="") 
mtDNA_haplotypes$V2 <- NULL
mtDNA_haplotypes$V3 <- NULL

help("write.table")
##save the cleaned up tables
write.table(mtDNA_haplotypes, "mtDNA_haplotypes.fasta",quote = F, row.names = F,
            col.names = F)
write.table(microsatellite_geno, "microsatellite_geno.txt")



## genepop
##getting the table into genepop format. Had to go in and edit by hand
micro_geno_pop <- read_excel("Microsatellite_genepop_data.xlsx")

keeps <- c("Individual_ID","SSR1", "SSR2", "SSR3", "SSR4", "SSR5",
           "SSR6", "SSR7", "SSR8", "SSR9")
df = micro_geno_pop[keeps]
df$Individual_ID =  paste(df$Individual_ID, ",")
df <- data.frame(lapply(df, function(x) {gsub("POP ,", "pop", x)}))
write.table(df, "microsatellite_geno_pop.txt", na = "" ,quote = F, row.names = F, append = F)
##remove individual id colname and add comma between loci

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
