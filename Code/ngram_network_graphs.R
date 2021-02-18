library(dplyr)
library(tidyr)
library(tidytext)
library(ggplot2)
library(igraph)
library(ggraph)
library(tidyr)
library(igraph)
library(ggraph)
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

#########################################################################################################


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

tweets_text <- tweets_employment$text
tweets_text <- cleaner(tweet_text)

ctweets <- polish(tweets_text)
ctweets <- tm_map(ctweets, removeWords, (c("employment", "job"))

acq_td <- tidy(ctweets)

acq_tokens <- acq_td %>% unnest_tokens(word, text) %>% anti_join(stop_words, by ="word")
acq_tokens <- acq_td %>% unnest_tokens(word, text) %>% anti_join(stop_words, by ="word")

acq_tokens %>% count(word, sort = TRUE)

# tf-idf
acq_tokens %>%
  count(id, word) %>%
  bind_tf_idf(word, id, n) %>%
  arrange(desc(tf_idf))

acq_tokens %>%
  anti_join(stop_words, by = "word") %>%
  count(word, id, sort = TRUE) %>%
  inner_join(get_sentiments("afinn"), by = "word") %>%
  group_by(word) %>%
  summarize(contribution = sum(n * value)) %>%
  top_n(15, abs(contribution)) %>%
  mutate(word = reorder(word, contribution)) %>%
  ggplot(aes(word, contribution)) +
  geom_col() +
  coord_flip() +
  labs(y = "Frequency of word * AFINN value")


acq_tokens %>%
  count(word) %>%
  inner_join(get_sentiments("loughran"), by = "word") %>%
  group_by(sentiment) %>%
  top_n(5, n) %>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~ sentiment, scales = "free") +
  ylab("Frequency of this word in the recent posts")

################################################################

acq_tokens <- acq_td %>%
  unnest_tokens(trigram, text, token ="ngrams", n =3)

acq_tokens %>%
  count(trigram, sort = TRUE)

trigrams_separated <- acq_tokens %>%
  separate(trigram, c("word1", "word2"), sep = " ")

trigrams_filtered <- trigrams_separated %>%
  filter(!word1 %in% stop_words$word) %>%
  filter(!word2 %in% stop_words$word)

#########################################################################################################

# new trigram counts:
trigram_counts <- trigrams_filtered %>%
  count(word1, word2, sort = TRUE)

trigram_counts

trigrams_united <- trigrams_filtered %>%
  unite(trigram, word1, word2, sep = " ")

trigrams_united

trigrams_filtered %>%
  filter(word2 == "hate") %>%
  count(word1, sort = TRUE)

trigrams_separated %>%
  filter(word1 == "not") %>%
  count(word1, word2, sort = TRUE)

AFINN <- get_sentiments("afinn")

negation_words <- c("not", "no", "never", "without")

negated_words <- trigrams_separated %>%
  filter(word1 %in% negation_words) %>%
  inner_join(AFINN, by = c(word2 = "word")) %>%
  count(word1, word2, value, sort = TRUE)

#########################################################################################################

# original counts
trigram_counts

# filter for only relatively common combinations
trigram_graph <- trigram_counts %>%
  filter(n > 20) %>%
  graph_from_data_frame()

trigram_graph
#########################################################################################################

set.seed(2017)

ggraph(trigram_graph, layout = "fr") +
  geom_edge_link() +
  geom_node_point() +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1)

a <- grid::arrow(type = "closed", length = unit(.15, "inches"))

ggraph(trigram_graph, layout = "fr") +
  geom_edge_link(aes(edge_alpha = n), show.legend = FALSE,
                 arrow = a, end_cap = circle(.07, 'inches')) +
  geom_node_point(color = "lightblue", size = 5) +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1) +
  theme_void()
#########################################################################################################

count_trigrams <- function(dataset) {
  dataset %>%
    unnest_tokens(trigram, text, token = "ngrams", n = 2) %>%
    separate(trigram, c("word1", "word2"), sep = " ") %>%
    filter(!word1 %in% stop_words$word,
           !word2 %in% stop_words$word) %>%
    count(word1, word2, sort = TRUE)
}
#########################################################################################################

visualize_trigrams <- function(trigrams) {
  set.seed(2016)
  a <- grid::arrow(type = "closed", length = unit(.15, "inches"))

  trigrams %>%
    graph_from_data_frame() %>%
    ggraph(layout = "fr") +
    geom_edge_link(aes(edge_alpha = n), show.legend = FALSE, arrow = a) +
    geom_node_point(color = "lightblue", size = 5) +
    geom_node_text(aes(label = name), vjust = 1, hjust = 1) +
    theme_void()
}
#########################################################################################################

