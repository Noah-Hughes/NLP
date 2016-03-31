ranked_tm_map <- function (x) {
  x <- Corpus(VectorSource(x))
  x <- tm_map(x, content_transformer(tolower))
  x <- tm_map(x, removePunctuation)
  x <- tm_map(x, removeNumbers)
  x <- tm_map(x, stripWhitespace)
  x <- tm_map(x, PlainTextDocument)
}

UniGramMe <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 3, max = 3))}
TriGramMe <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 3, max = 3))}
QuadGramMe <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 3, max = 3))}

RankME <- function(x) {
  x <- rollup(x, 2, na.rmw=TRUE, FUN = sum)
  frequency <- sort(rowSums(as.matrix(x)), decreasing=TRUE)
  frequency_df <- data.frame(term = names(frequency), freqency = frequency)
  return(fequency_df)
}

twitter <- readLines("./final/en_US/en_US.twitter.txt", encoding = "UTF8")
twittersample <-  sample(twitter, 100000)
