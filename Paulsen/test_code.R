## removed code
keep <- c()
lose <- c()

for (row in 1:nrow(mtDNA_haplotypes)) {
  n <- mtDNA_haplotypes[row, "V1"]
  if(grepl('>', n)==T || grepl('CAT', n)==T) {
    keep <- c(keep, row)
  }else{
    lose <- c(lose, row)
  }
}

mtDNA_haplotypes <- mtDNA_haplotypes[-lose,]

write.table(FASTA, "mtDNA.fasta")

#id <- list()
#sequence <- list()
#location <- list()

## go through and separate out the locations, sequences and ids in order
#for (row in 1:nrow(mtDNA_haplotypes)) {
#  n <- mtDNA_haplotypes[row, "V1"]
#  if(grepl('>', n)==TRUE) {
#    id <- c(id, n)
#  } else if(grepl('CAT', n)==TRUE){
#    sequence <- c(sequence, n)
#  } else {
#    location <- c(location, n)
#  }
#}

##combine ids and sequences into pairs in data frame
haplotypes <- do.call(rbind, Map(data.frame, ID = id, Sequence = sequence))