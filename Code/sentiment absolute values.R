

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


sentiment3

library(tm)
library("SentimentAnalysis")

# Analyze sentiment
sentiment <- analyzeSentiment(text)
sentiment$SentimentQDAP
