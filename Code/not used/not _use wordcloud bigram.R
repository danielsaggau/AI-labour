
now make it a corpus again

ctweets <- VCorpus(VectorSource(tweets.dfl))
ctweets <- tm_map(ctweets, removeWords, stopwords("english"))
tdm_tweets <- TermDocumentMatrix(ctweets)
matrix_tweets <- as.matrix(tdm_tweets)
rows_tweets <- rowSums(matrix_tweets)
wordcloud(names(rows_tweets), rows_tweets,max.words = 100, random.order=FALSE, rot.per=0.35,  colors=brewer.pal(8, "Paired"))


# creating a bigram
ctweets.ng = tm_map(ctweets,removeWords,c(stopwords(),"s","ve"))
corpus.ng = tm_map(ctweets.ng,removePunctuation)
corpus.ng = tm_map(corpus.ng,removeNumbers)


BigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
tdm.bigram = TermDocumentMatrix(corpus.ng,
                                control = list(tokenize = BigramTokenizer))

freq = sort(rowSums(as.matrix(tdm.bigram)),decreasing = TRUE)
freq.df = data.frame(word=names(freq), freq=freq)
head(freq.df, 20)


pal=brewer.pal(8,"Blues")
pal=pal[-(1:3)]


wordcloud(freq.df$word,freq.df$freq,max.words=300,random.order = F, colors=pal)

