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
