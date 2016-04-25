combineme2 <- function (ubtq) 
  {

utdmlist <- system(paste('find ~/R/NLP -type f  | grep "',ubtq,'bf.csv"',sep=""), intern = TRUE)
if(exists("udfperm")){
  rm(udfperm)
}

len <- length(utdmlist)
for (i in 1:len)
{
  udftemp <- read.csv(utdmlist[i])
  udftemp <- udftemp[c("term","Total")]
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

#Get the first 20,000
udfperm2 <- head(udfperm2,100000)

rm(udfperm)
rm(udftemp)
gc()
#sort by Total
udfperm2 <- udfperm2[order(-udfperm2$Total),]

#renumbering rows
row.names(udfperm2) <- 1:nrow(udfperm2)

#write to file
write.csv(udfperm2, paste('~/R/NLP/sdata/Total',ubtq,'f.csv',sep=""))

}