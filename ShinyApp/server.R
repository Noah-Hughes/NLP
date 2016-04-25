library(shiny)
library(tm)

ubf <- read.csv("Totaluf.csv")
bbf <- read.csv("Totalbf.csv")
tbf <- read.csv("Totaltf.csv")
qbf <- read.csv("Totalqf.csv")

cleanup <- function(x)
{
    x <- Corpus(VectorSource(x))
    x <- tm_map(x, content_transformer(tolower))
    x <- tm_map(x, removePunctuation)
    x <- tm_map(x, removeNumbers)
    x <- tm_map(x, stripWhitespace)
    x <- as.character(x[[1]])
    
    if (nchar(x) > 0) {
      return(x); 
    } else {
      return("");
    }
}


nextword <- function(x)
{
  spacer <- FALSE
  if(length(grep(" $", x,value=TRUE))){
    spacer <- TRUE
    
  }
  x <- cleanup(x)
  
  matcher <- FALSE
  
  
  blah <- unlist(strsplit(x, " "))
  
  len1234 <- length(blah)

  if(spacer){
    len1234 = len1234 + 1
    
  }

  if(len1234 == 4){
  
    x <- tail(blah,n=4)
    
    if(spacer){
      temp <- qbf[grep (paste("^",x[length(x)-2]," ",x[length(x)-1]," ",x[length(x)]," ",sep=""),qbf$term),]
    }
    else {
      temp <- qbf[grep (paste("^",x[length(x)-3]," ",x[length(x)-2]," ",x[length(x)-1]," ",x[length(x)],sep=""),qbf$term),]
    }
    if(NROW(temp) > 0){
      test <- as.character(temp[1,2])
      matcher = TRUE
    }
    
    
  }
  
  if(len1234 == 3 | !matcher){
    x <- tail(blah,n=3)
    
    if(spacer){
      temp <- tbf[grep (paste("^",x[length(x)-1]," ",x[length(x)]," ",sep=""),tbf$term),]
    }
    else {
      temp <- tbf[grep (paste("^",x[length(x)-2]," ",x[length(x)-1]," ",x[length(x)],sep=""),tbf$term),]
    }
    if(NROW(temp) > 0){
      test <- as.character(temp[1,2])
      matcher = TRUE
    }
  }
  
  if(len1234 == 2 | !matcher){
    x <- tail(blah,n=2)
    if(spacer){
      temp <- bbf[grep (paste("^",x[length(x)]," ",sep=""),bbf$term),]
    }
    else{
      temp <- bbf[grep (paste("^",x[length(x)-1]," ",x[length(x)],sep=""),bbf$term),]  
    }
    
    if(NROW(temp) > 0){
      test <- as.character(temp[1,2])
      matcher = TRUE
    }
  }
  
  if(len1234 == 1 | !matcher){
    x <- tail(blah,n=1)
    temp <- ubf[grep (paste("^",x[length(x)],sep=""),ubf$term),]
    if(NROW(temp) > 0){
      test <- as.character(temp[1,2])
      matcher = TRUE
    }
  
    
 }
  
  stringer <- unlist(strsplit(test, " "))
  x <- tail(stringer,n=1)

}


shinyServer(
  function(input, output,session){

    observe({
      
      
#txt <- paste("Value above is:", input$mytext)

txt <- nextword(input$mytext)

updateTextInput(session, "myresults", value=txt)
    })
})