##final project code

library(readxl)

##had to go in excel and separate the sheets in the workbook into two diff workbooks
microsatellite_genotype <- read_excel("Microsatellite genotype data.xlsx")
sampling_info <- read_excel("sampling_information.xlsx")

mtDNA_haplotypes <- read.table("Haplotypes of mtDNA-final.txt", sep = '\t', fill = T)


##save haplotype data as characters for grep
mtDNA_haplotypes[] <- lapply(mtDNA_haplotypes, as.character)

id <- list()
sequence <- list()
location <- list()

## go through and separate out the locations, sequences and ids in order
for (row in 1:nrow(mtDNA_haplotypes)) {
  n <- mtDNA_haplotypes[row, "V1"]
  if(grepl('>', n)==TRUE) {
    id <- c(id, n)
  } else if(grepl('CAT', n)==TRUE){
    sequence <- c(sequence, n)
  } else {
    location <- c(location, n)
  }
}

##combine ids and sequences into pairs in data frame
haplotypes <- do.call(rbind, Map(data.frame, ID = id, Sequence =sequence))

