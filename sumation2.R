combineme <- function (bnt, ubtq) 
  {

utdmlist <- system(paste('ls ~/R/NLP/data/',bnt,'/',ubtq,'tdm*.gz',sep=""), intern = TRUE)
if(exists("udfperm")){
  rm(udfperm)
}

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

#Only keep the top 5%
udfperm2 <- subset(udfperm2, Total > quantile(Total, prob = 1 - 5/100))

rm(udfperm)
rm(udftemp)
gc()
#sort by Total
udfperm2 <- udfperm2[order(-udfperm2$Total),]

#renumbering rows
row.names(udfperm2) <- 1:nrow(udfperm2)

#write to file
write.csv(udfperm2, paste('~/R/NLP/sdata/',bnt,'/',ubtq,'bf.csv',sep=""))

}