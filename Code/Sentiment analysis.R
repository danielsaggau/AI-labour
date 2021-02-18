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

sentiment <-  tidy_tweets %>%
  inner_join(get_sentiments("bing")) %>% # pull out only sentimen words
  count(sentiment) %>% # count the # of positive & negative words
  spread(sentiment, n, fill = 0) %>% # made data wide rather than narrow
  mutate(sentiment = positive - negative)

sentiment2 <-  tidy_tweets %>%
  inner_join(get_sentiments("nrc")) %>% # pull out only sentimen words
  count(sentiment) %>% # count the # of positive & negative words
  spread(sentiment, n, fill = 0) %>% # made data wide rather than narrow
  mutate(sentiment = positive - negative)

sentiment3 <- tidy_tweets %>%
  inner_join(get_sentiments("loughran")) %>% # pull out only sentimen words
  count(sentiment) %>% # count the # of positive & negative words
  spread(sentiment, n, fill = 0) %>% # made data wide rather than narrow
  mutate(sentiment = positive - negative) # # of positive words - # of negative owrds

afinn_sentiments <- tidy_tweets %>%
  inner_join(get_sentiments("afinn")) %>%
  group_by(index = linenumber %/% 80) %>%
  summarize(sentiment = sum(value)) %>%
  count(sentiment)

######################################################################
sentiment3

library(tm)
library("SentimentAnalysis")

# Analyze sentiment
sentiment <- analyzeSentiment(text)
sentiment$SentimentQDAP

######################################################################

tweet_words <- tweets_china %>% select(id, text) %>% unnest_tokens(word,text)

tweet_words %>% count(word,sort=T) %>% slice(1:20) %>%
  ggplot(aes(x = reorder(word,
                         n, function(n) -n), y = n)) + geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 60,
                                                                                                                      hjust = 1)) + xlab("")
my_stop_words <- stop_words %>% select(-lexicon) %>%
  bind_rows(data.frame(word = c("https", "t.co", "rt", "amp","4yig9gzh5t","fyy2ceydhi","78","fakenews")))

tweet_words_interesting <- tweet_words %>% anti_join(my_stop_words)

tweet_words_interesting %>%
  group_by(word) %>%
  tally(sort=TRUE) %>%
  slice(1:25) %>%
  ggplot(aes(x = reorder(word,n, function(n) -n), y = n)) +
  geom_bar(stat = "identity")

bing_lex <- get_sentiments("nrc")

fn_sentiment <- tweet_words_interesting %>% left_join(bing_lex)
fn_sentiment %>% filter(!is.na(sentiment)) %>% group_by(sentiment) %>% summarise(n=n())

#######################################################################
library(tidyr)
library(ggplot2)
library(zoo)
library(tidytext)
library(stringr)
library(tidytext)
library(qdap)
library(tm)
library(dplyr)

topic_twitter <- tweets_migration
corpus <- Corpus(VectorSource(topic_twitter$text))
tweet_dtm <- DocumentTermMatrix(corpus)
tidy_tweets <- tidy(tweet_dtm)
tidy_tweets <- tidy_tweets %>%
  mutate(linenumber = row_number()) %>%
  rename(word ="term")

# this is the right one below
#######################################################################
bing_sentiments <- tidy_tweets %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  spread(sentiment, n, fill =0) %>%
  mutate(sentiment = positive - negative) %>%
  mutate(method ="NRC")

#######################################################################
afinn_sentiments <- tidy_tweets %>%
  inner_join(get_sentiments("afinn")) %>%
  group_by(index = linenumber %/% 80) %>%
  summarize(sentiment = sum(value)) %>%
  count(sentiment) %>%
  mutate(method ="AFINN")
#######################################################################
bing_and_nrc <- bind_rows(tidy_tweets %>%
                            inner_join(get_sentiments("bing")) %>%
                            mutate(method ="Bing et al."),
                          tidy_tweets%>%
                            inner_join(get_sentiments("nrc") %>%
                                         filter(sentiment %in% c("positive", "negative"))) %>%
                            mutate(method ="NRC")) %>%
  count(method, index = linenumber %/% 80, sentiment) %>%
  spread(sentiment, n, fill =0) %>%
  mutate(sentiment = positive - negative)
#######################################################################

bind_rows(afinn_sentiments, bing_and_nrc) %>%
  ggplot(aes(index, sentiment, fill = method)) +
  geom_col(show.legend = FALSE) +
  facet_wrap (~method, ncol=1, scales ="free_y") +
  scale_fill_brewer(palette = "Set1")

#######################################################################

bing_sentiments <- tidy_tweets %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  spread(sentiment, n, fill =0) %>%
  mutate(sentiment = positive - negative)

#######################################################################

bing_sentiments %>%
  group_by(sentiment) %>%
  top_n(20) %>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment, scales = "free_y") +
  labs(title = "Sentiments during the lockdown.",
       y = "Contribution to sentiment",
       x = NULL) +
  coord_flip()

#######################################################################

bing_word_counts <- tidy_tweets %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  ungroup()

#######################################################################

bing_word_counts %>%
  group_by(sentiment) %>%
  top_n(20) %>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes( word,n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment, scales = "free_y") +
  labs(y = "Contribution to sentiment",
       x = NULL) +
  coord_flip()

#######################################################################

bing_word_counts %>%
  top_n(15) %>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  coord_flip()


#######################################################################

ap_td <- tidy(tweet_dtm)
ap_td

#######################################################################

ap_sentiments <- ap_td %>%
  inner_join(get_sentiments("bing"), by = c(term = "word"))

ap_sentiments

#######################################################################

ap_sentiments %>%
  count(sentiment, term, wt = count) %>%
  ungroup() %>%
  filter(n >= 140) %>%
  mutate(n = ifelse(sentiment == "negative", -n, n)) %>%
  mutate(term = reorder(term, n)) %>%
  ggplot(aes(term, n, fill = sentiment)) +
  geom_bar(stat = "identity") +
  ylab("Contribution to sentiment") +
  coord_flip()


#######################################################################
library(rtweet)
library(tidyr)
library(dplyr)
library(stringr)
library(tidytext)
library(textdata)
##############################################################
auto_rds <- twListToDF(rds)
ts_plot(tweets_migration, "secs")

#hint: token = bearer_token()
#hint: command lookup_coords("London, UK")

##############################################################
# times series plot of data
tweets_migration%>%
  dplyr::group_by(screenName) %>%
  ts_plot("hours")

##############################################################
wds <- tokenizers::tokenize_tweets(china$text)

## collapse back into stirngs
txt <- purrr::map_chr(wds, paste, collapse = " ")

##############################################################
## get sentiment using afinn dictionary
china$sent <- syuzhet::get_sentiment(china$text, method = "afinn")

get_sentiments("afinn")

##############################################################
## make sentiment column with sum of sentiments
china_m <- ap_sentiments %>%
  mutate(linenumber = row_number()) %>%
  group_by(index = linenumber %/% 80) %>%
  mutate(sentiment = positive - negative) %>%
  mutate(method ="AFINN")

ggplot(china_m, aes(y=index,x = sentiment, fill = "Blue" )) +
  geom_col(show.legend = FALSE)

tidy_tweets <- tidy_tweets %>%
  mutate(linenumber = row_number())

tidy_tweets %>%
  rename(word = term)

##############################################################

syuzhet <- get_sentiment(tweets_china$text, method="syuzhet")
bing <- get_sentiment(tweets_china$text, method="bing")
afinn <- get_sentiment(tweets_china$text, method="afinn")
nrc <- get_sentiment(tweets_china$text, method="nrc")
nrc <- get_sentiment(tweets_china$text, method="nrc")
sentiments <- data.frame(syuzhet, bing, afinn, nrc)

##############################################################

library(tidyr)
library(ggplot2)
library(zoo)
library(tidytext)
library(stringr)
library(tidytext)
library(qdap)
library(tm)
library(dplyr)

topic_twitter <- tweets_migration
corpus <- Corpus(VectorSource(topic_twitter$text))
tweet_dtm <- DocumentTermMatrix(corpus)
tidy_tweets <- tidy(tweet_dtm)
tidy_tweets <- tidy_tweets %>%
  mutate(linenumber = row_number()) %>%
  rename(word ="term")

# this is the right one below
#######################################################################
bing_sentiments <- tidy_tweets %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  spread(sentiment, n, fill =0) %>%
  mutate(sentiment = positive - negative) %>%
  mutate(method ="NRC")

#######################################################################
afinn_sentiments <- tidy_tweets %>%
  inner_join(get_sentiments("afinn")) %>%
  group_by(index = linenumber %/% 80) %>%
  summarize(sentiment = sum(value)) %>%
  count(sentiment) %>%
  mutate(method ="AFINN")
#######################################################################
bing_and_nrc <- bind_rows(tidy_tweets %>%
                            inner_join(get_sentiments("bing")) %>%
                            mutate(method ="Bing et al."),
                          tidy_tweets%>%
                            inner_join(get_sentiments("nrc") %>%
                                         filter(sentiment %in% c("positive", "negative"))) %>%
                            mutate(method ="NRC")) %>%
  count(method, index = linenumber %/% 80, sentiment) %>%
  spread(sentiment, n, fill =0) %>%
  mutate(sentiment = positive - negative)
#######################################################################

bind_rows(afinn_sentiments, bing_and_nrc) %>%
  ggplot(aes(index, sentiment, fill = method)) +
  geom_col(show.legend = FALSE) +
  facet_wrap (~method, ncol=1, scales ="free_y") +
  scale_fill_brewer(palette = "Set1")

#######################################################################

bing_sentiments <- tidy_tweets %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  spread(sentiment, n, fill =0) %>%
  mutate(sentiment = positive - negative)

#######################################################################

bing_sentiments %>%
  group_by(sentiment) %>%
  top_n(20) %>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment, scales = "free_y") +
  labs(title = "Sentiments during the lockdown.",
       y = "Contribution to sentiment",
       x = NULL) +
  coord_flip()

#######################################################################

bing_word_counts <- tidy_tweets %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  ungroup()

#######################################################################

bing_word_counts %>%
  group_by(sentiment) %>%
  top_n(20) %>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes( word,n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment, scales = "free_y") +
  labs(y = "Contribution to sentiment",
       x = NULL) +
  coord_flip()

#######################################################################

bing_word_counts %>%
  top_n(15) %>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  coord_flip()


#######################################################################

ap_td <- tidy(tweet_dtm)
ap_td

#######################################################################

ap_sentiments <- ap_td %>%
  inner_join(get_sentiments("bing"), by = c(term = "word"))

ap_sentiments

#######################################################################

ap_sentiments %>%
  count(sentiment, term, wt = count) %>%
  ungroup() %>%
  filter(n >= 140) %>%
  mutate(n = ifelse(sentiment == "negative", -n, n)) %>%
  mutate(term = reorder(term, n)) %>%
  ggplot(aes(term, n, fill = sentiment)) +
  geom_bar(stat = "identity") +
  ylab("Contribution to sentiment") +
  coord_flip()
