# tweets_bing has been pre-defined
tweets_bing

tweets_bing %>%
  # Group by two columns: state and sentiment
  group_by(state, sentiment) %>%
  # Use summarize to calculate the mean frequency for these groups
  summarize(freq = mean(freq)) %>%
  spread(sentiment, freq) %>%
  ungroup() %>%
  # Calculate the ratio of positive to negative words
  mutate(ratio = (positive / negative),
         state = reorder(state, ratio)) %>%
  # Use aes() to put state on the x-axis and ratio on the y-axis
  ggplot(aes(state, ratio)) +
  # Make a plot with points using geom_point()
  geom_point() +
  coord_flip()

################################################################

word_counts <- tidy_tweets %>%
  # Implement sentiment analysis using the "bing" lexicon
  inner_join(get_sentiments("bing"), by word = term) %>%
  # Count by word and sentiment
  count(word, sentiment)

top_words <- word_counts %>%
  # Group by sentiment
  group_by(sentiment) %>%
  # Take the top 10 for each sentiment
  top_n(10) %>%
  ungroup() %>%
  # Make word a factor in order of n
  mutate(word = reorder(word, n))

# Use aes() to put words on the x-axis and n on the y-axis
ggplot(tidy, aes(topic,term, fill = beta)) +
  # Make a bar chart with geom_col()
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment, scales = "free") +
  coord_flip()

################################################################

tweets.dfl %>%
  # Group by two columns: state and sentiment
  group_by(state, sentiment) %>%
  # Use summarize to calculate the mean frequency for these groups
  summarize(freq = mean(freq)) %>%
  spread(sentiment, freq) %>%
  ungroup() %>%
  # Calculate the ratio of positive to negative words
  mutate(ratio = (positive / negative),
         state = reorder(state, ratio)) %>%
  # Use aes() to put state on the x-axis and ratio on the y-axis
  ggplot(aes(state, ratio)) +
  # Make a plot with points using geom_point()
  geom_point() +
  coord_flip()





