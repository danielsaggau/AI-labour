library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
library("knitr")
library("qdap")

index <- final_df_out$index
cindex <- VCorpus(VectorSource(index))
cindex <- tm_map(cindex, removeWords, stopwords("english"))

doc <- TermDocumentMatrix(
  cindex,
)
doc_m <- as.matrix(doc)
doc_f <- rowSums(doc_m)
wordcloud(names(doc_f), doc_f,max.words = 100, random.order=FALSE, rot.per=0.35,  colors=brewer.pal(8, "Paired"))

library(ggplot2)
ggplot(what, aes( x = edcat5, y = pct_software)) +
  geom_quantile()

ggplot(final_df_out, aes(agg_pairs, ai_score)) +
  geom_point(col = "black", size = 0.5)  +
  ggtitle("Aggregate word pairs and the ai score")


# Code snipptes for bigrams

library(tm)
library(ggplot2)
library(reshape2)
library(wordcloud)
install.packages("RWeka")
library(RWeka)

# Needed for a bug when calculating n-grams with weka
options(mc.cores=1)

# load data

# now make it a corpus again
corpus = Corpus(index)

# creating a bigram
corpus.ng = tm_map(corpus,removeWords,c(stopwords(),"s","ve"))
corpus.ng = tm_map(corpus.ng,removePunctuation)
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

#visualize the top 15 bigrams
library(ggplot2)
ggplot(head(freq.df,15), aes(reorder(word,freq), freq)) +
  geom_bar(stat = "identity") + coord_flip() +
  xlab("Bigrams") + ylab("Frequency") +
  ggtitle("Most frequent bigrams")

