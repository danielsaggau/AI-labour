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

