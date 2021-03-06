---
title: "README"
output: word_document
---

### Application

This application returns the guess of the next word!

Application will predict the current word and next word after a space.

There is a box where you input and a box that will return the guess.

### Algorithm

The prediction algorithm needed to be fast and lean but still return good results. In order to to this the algorithm did these things in under a second

- Constantly sampled and checked the length of the word or phrase
- Checked the longer n-grams first when applicable
- If no match was found in longer n-grams it checked the next n-gram
  - e.g 4-gram -> 3-gram -> 2-gram -> 1-gram
- By leveraging this algorithm and uncompressed data results are returned instantly
- Link to application https://noahhughes.shinyapps.io/ShinyApp/

### Dataset

- 10 samples of 100,000 lines of were taken from each dataset(Twitter,News,Blogs)
- These samples were procesed creating 1-gram, 2-gram, 3-gram and 4-gram
- The top 100,000 n-grams from each where brought forward to be used in the application
- Using this approach reduced the dataset from several GB of data to under 10 MB of uncompressed data
- Processing of this data took several hours
- This enabled the application to search and perform queries quickly

### Data Cleanup

Overall the source data needed to be cleaned in order to process correctly.

- "TM" Package Used
- Made word lower case
- Removed Whitespace
- Removed Punctuation
- Removed Numbers





