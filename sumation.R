utdmlist <- system("ls ~/R/NLP/data/utdm*.gz", intern = TRUE)

len <- length(utdmlist)
for (i in 1:len)
{
  udftemp <- read.csv(utdmlist[i])
  udftemp <- udftemp[c("term","freqency")]
  print("123")
  if(exists("udfperm"))
  { 
    udfperm <- merge(udftemp, udfperm, by = "term", all = TRUE)
  }
  else
  {
    udfperm <- udftemp  
  }
}

#remove nas
udfperm[is.na(udfperm)] <- 0

# there will be multiple frequency field based on the number of files
udfperm <- cbind(udfperm, Total = rowSums(udfperm[,2:{len+1}]))
udfperm2 <- udfperm[c("term","Total")]

#renumbering rows
#row.names(datasetname) <- 1:nrow(datasetname)