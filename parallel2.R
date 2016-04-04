ranked_tm_map <- function (x) {
  x <- Corpus(VectorSource(x))
  x <- tm_map(x, content_transformer(tolower))
  x <- tm_map(x, removePunctuation)
  x <- tm_map(x, removeNumbers)
  x <- tm_map(x, stripWhitespace)
}

UniGramMe <- function(x) {utdm <- RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 1, max = 1))
  SortandFileME(utdm,i,"utdm")}
BiGramMe <- function(x) {btdm <- RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 2, max = 2))
  SortandFileME(btdm,i,"btdm")}
TriGramMe <- function(x) {ttdm <- RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 3, max = 3))
  SortandFileME(ttdm,i,"ttdm")}
QuadGramMe <- function(x) {qtdm <- RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 4, max = 4))
  SortandFileME(qtdm,i,"qtdm")}

RankME <- function(x) {
  x <- rollup(x, 2, na.rmw=TRUE, FUN = sum)
  frequency <- sort(rowSums(as.matrix(x)), decreasing=TRUE)
  frequency_df <- data.frame(term = names(frequency), freqency = frequency)
  return(fequency_df)
}

SortandFileME <- function(x,i,n) {
  
  tdm2 <- slam::rollup(x, 2, na.rmw=TRUE, FUN = sum)
  frequency <- sort(rowSums(as.matrix(tdm2)), decreasing=TRUE)
  print(paste("sort complete",timestamp()))
  frequency_df <- data.frame(term = names(frequency), freqency = frequency)
  #frequency_df[grepl("case of [a-z]" ,frequency_df$term)] 
  gz1 = gzfile(paste(n,i,".gz",sep=""),"w")
  write.csv(frequency_df,gz1)
  close(gz1)
  
}

library(NLP)
library(tm)
library(RWeka)
library(parallel)
options(mc.cores=1)
cl<-makeCluster(4)
registerDoParallel(cl)

twitter <- readLines("./final/en_US/en_US.twitter.txt", encoding = "UTF8")


for(i in 1:10)  
{
  print(paste("loop",i,timestamp()))
  twittersample <-  sample(twitter, 1000)
  
  samplecleaned <- ranked_tm_map(twittersample)
  print(paste("tm complete", timestamp()))

  mcparallel()
  utdm <- TermDocumentMatrix(samplecleaned, control = list(tokenize = UniGramMe))
  print(paste("utdm", timestamp()))
  
  
  btdm <- TermDocumentMatrix(samplecleaned, control = list(tokenize = BiGramMe))
  print(paste("bdm", timestamp()))
  
  
  ttdm <- TermDocumentMatrix(samplecleaned, control = list(tokenize = TriGramMe))
  print(paste("ttdm", timestamp()))
  
  
  qtdm <- TermDocumentMatrix(samplecleaned, control = list(tokenize = QuadGramMe))
  print(paste("qtdm", timestamp()))
  
  
}


