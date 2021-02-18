library(lubridate)
library(ggplot2)
library(dplyr)
library(readr)
library(tidytext)
library(stringr)

acq_td <- tidy(ctweets)

tweets <- tweets_china %>%
  mutate(timestamp = ymd_hms(created))

ggplot(tweets, aes(x = timestamp, y= favoriteCount)) +
  geom_line(position = "identity", show.legend = FALSE)

remove_reg <- "&amp;|&lt;|&gt;"
tidy_tweets <- tweets %>%
  filter(!str_detect(text, "^RT")) %>%
  mutate(text = str_remove_all(text, remove_reg)) %>%
  unnest_tokens(word, text, token = "tweets") %>%
  filter(!word %in% stop_words$word,
         !word %in% str_remove_all(stop_words$word, "'"),
         str_detect(word, "[a-z]"))

###########################################################
