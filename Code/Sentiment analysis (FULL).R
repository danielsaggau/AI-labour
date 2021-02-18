library("NLP")
library("twitteR")
library("syuzhet")
library("tm")
library("SnowballC")
library("stringi")
library("topicmodels")
library("ROAuth")
library("ggplot2")
library("wordcloud")
library(tidyverse)

cleaner <- function(tweet_text){
  tweets_text <- tolower(tweets_text)
  tweets_text <- gsub("rt", "", tweets_text)
  tweets_text <- gsub("@\\w+", "", tweets_text)
  tweets_text <- gsub("[[:punct:]]", "", tweets_text)
  tweets_text <- gsub("http\\w+", "", tweets_text)
  tweets_text <- gsub("amp", " ", tweets_text)
  tweets_text <- gsub("[ |\t]{2,}", "", tweets_text)
  tweets_text <- gsub("^ ", "", tweets_text)
  tweets_text <- gsub(" $", "", tweets_text)
  tweets_text <- gsub(" +", " ", tweets_text)
  tweets_text <- gsub("=", " ", tweets_text)
  tweets_text <- gsub('<.*>', '', enc2native(tweets_text))
  tweets_text <- unique(tweets_text)
  return(tweets_text)
}

polish <- function(ctweets){
  ctweets <- VCorpus(VectorSource(tweets_text))
  ctweets <- tm_map(ctweets, removeWords, stopwords("english"))
  ctweets <- tm_map(ctweets, removeNumbers)
  ctweets <- tm_map(ctweets, stemDocument)
}

######################################################################
# Sentiment analysis keywords: technology and work

tweets_text <- tech$text
tweets_text <- cleaner(tweet_text)

ctweets <- polish(tweets_text)
ctweets <- tm_map(ctweets, removeWords, c("technology", ""))

pal <- brewer.pal(8, "Dark2")
wordcloud(ctweets, min.freq = 10,colors= pal, random.color = TRUE,max.words = 500)

mysentiment_twitter <-get_nrc_sentiment((tweets_text))
Sentimentscores_twitter <-data.frame(colSums(mysentiment_twitter[,]))

names(Sentimentscores_twitter)<-"Score"
Sentimentscores_twitter <- cbind("sentiment"=rownames(Sentimentscores_twitter),Sentimentscores_twitter)
rownames(Sentimentscores_twitter) <- NULL

ggplot(data=Sentimentscores_twitter,aes( x= sentiment,y = Score))+geom_bar(aes(fill=sentiment),stat = "identity") +
  theme(legend.position="none") +
  xlab("Sentiments")+ylab("scores")+ggtitle("Sentiments Twitter")


######################################################################
# Sentiment analysis keywords: trade and china

tweets_text <- tweets_china$text
tweets_text <- cleaner(tweet_text)
token <-

ctweets <- polish(tweets_text)
ctweets <- tm_map(ctweets, removeWords, c("trade", "china"))


pal <- brewer.pal(8, "Dark2")
wordcloud(ctweets, min.freq = 10,colors= pal, random.color = TRUE,max.words = 500)

mysentiment_twitter <-get_nrc_sentiment((tweets_text))
Sentimentscores_twitter <-data.frame(colSums(mysentiment_twitter[,]))

names(Sentimentscores_twitter)<-"Score"
Sentimentscores_twitter <- cbind("sentiment"=rownames(Sentimentscores_twitter),Sentimentscores_twitter)
rownames(Sentimentscores_twitter) <- NULL

ggplot(data=Sentimentscores_twitter,aes( x= sentiment,y = Score))+geom_bar(aes(fill=sentiment),stat = "identity") +
  theme(legend.position="none") +
  xlab("Sentiments")+ylab("scores")+ggtitle("Sentiments toward China")


######################################################################

# Sentiment analysis keywords: Employment

tweets_text <- tweets_employment$text
tweets_text <- cleaner(tweet_text)

ctweets <- polish(tweets_text)
ctweets <- tm_map(ctweets, removeWords, (c("employment", "job"))

boost <- Boost_tokenizer(ctweets)

mysentiment_twitter <-get_nrc_sentiment((tweets_text))
Sentimentscores_twitter <-data.frame(colSums(mysentiment_twitter[,]))

names(Sentimentscores_twitter)<-"Score"
Sentimentscores_twitter <- cbind("sentiment"=rownames(Sentimentscores_twitter),Sentimentscores_twitter)
rownames(Sentimentscores_twitter) <- NULL

ggplot(data=Sentimentscores_twitter,aes( x= sentiment,y = Score))+geom_bar(aes(fill=sentiment),stat = "identity") +
  theme(legend.position="none") +
  xlab("Sentiments")+ylab("scores")+ggtitle("Sentiments Twitter")

######################################################################

# Sentiment analysis keywords: Migration

tweets_text <- tweets_migration$text
tweets_text <- cleaner(tweet_text)

ctweets <- polish(tweets_text)
ctweets <- tm_map(ctweets, removeWords, c("migration", "migrant"))

pal <- brewer.pal(8, "Dark2")

wordcloud(ctweets, min.freq = 10,colors=brewer.pal(8, "Dark2"),random.color = TRUE,max.words = 300)

mysentiment_twitter <-get_nrc_sentiment((tweets_text))
Sentimentscores_twitter <-data.frame(colSums(mysentiment_twitter[,]))

names(Sentimentscores_twitter)<-"Score"
Sentimentscores_twitter <- cbind("sentiment"=rownames(Sentimentscores_twitter),Sentimentscores_twitter)
rownames(Sentimentscores_twitter) <- NULL

ggplot(data=Sentimentscores_twitter,aes( x= sentiment,y = Score))+geom_bar(aes(fill=sentiment),stat = "identity") +
  theme(legend.position="none") +
  xlab("Sentiments")+ylab("scores")+ggtitle("Sentiments Towards Migration")

######################################################################

# Sentiment analysis keywords: Automation

tweets_text <- tweets_automation$text
tweets_text <- cleaner(tweets_text)
ctweets <- polish(tweets_text)
ctweets <- tm_map(ctweets, removeWords, c("autom", "robot", "job"))
mysentiment_twitter <-get_nrc_sentiment((tweets_text))
Sentimentscores_twitter <-data.frame(colSums(mysentiment_twitter[,]))

names(Sentimentscores_twitter)<-"Score"
Sentimentscores_twitter <- cbind("sentiment"=rownames(Sentimentscores_twitter),Sentimentscores_twitter)
rownames(Sentimentscores_twitter) <- NULL

ggplot(data=Sentimentscores_twitter,aes( x= sentiment,y = Score))+geom_bar(aes(fill=sentiment),stat = "identity") +
  theme(legend.position="none") +
  xlab("Sentiments")+ylab("scores")+ggtitle("Sentiments towards automation ")

######################################################################
