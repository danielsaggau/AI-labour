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
