ranked_tm_map <- function (x) {
  x <- Corpus(VectorSource(x))
  x <- tm_map(x, content_transformer(tolower))
  x <- tm_map(x, removePunctuation)
  x <- tm_map(x, removeNumbers)
  x <- tm_map(x, stripWhitespace)
}

UniGramMe <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 1, max = 1))}
BiGramMe <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 2, max = 2))}
TriGramMe <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 3, max = 3))}
QuadGramMe <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 4, max = 4))}

RankME <- function(x) {
  x <- rollup(x, 2, na.rmw=TRUE, FUN = sum)
  frequency <- sort(rowSums(as.matrix(x)), decreasing=TRUE)
  frequency_df <- data.frame(term = names(frequency), freqency = frequency)
  return(fequency_df)
}


library(NLP)
library(tm)
library(RWeka)
library(foreach)
options(mc.cores=1)

#setup parallel backend to use 8 processors
cl<-makeCluster(7)
registerDoParallel(cl)

twitter <- readLines("./final/en_US/en_US.twitter.txt", encoding = "UTF8")


foreach(i in 1:10)  
{
  print(paste("start of loop",timestamp()))
  twittersample <-  sample(twitter, 100000)

    samplecleaned <- ranked_tm_map(twittersample)
  print(paste("tm complete", timestamp()))

  utdm <- TermDocumentMatrix(samplecleaned, control = list(tokenize = TriGramTokenizer))
  print(paste("utdm", timestamp()))
  tdm2 <- slam::rollup(tdm, 2, na.rmw=TRUE, FUN = sum)
  frequency <- sort(rowSums(as.matrix(tdm2)), decreasing=TRUE)
  print(paste("sort complete",timestamp()))
  frequency_df <- data.frame(term = names(frequency), freqency = frequency)
  #frequency_df[grepl("case of [a-z]" ,frequency_df$term)] 
  gz1 = gzfile(paste("file",i,".gz",sep=""),"w")
  write.csv(frequency_df,gz1)
  close(gz1)
}


