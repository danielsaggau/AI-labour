# comparison plot

library(dplyr) #Data manipulation (also included in the tidyverse package)
library(tidytext) #Text mining
library(tidyr) #Spread, separate, unite, text mining (also included in the tidyverse package)
install.packages("widyr")
library(widyr) #Use for pairwise correlation

#Visualizations!
library(ggplot2) #Visualizations (also included in the tidyverse package)
library(ggrepel) #`geom_label_repel`
library(gridExtra) #`grid.arrange()` for multi-graphs
library(knitr) #Create nicely formatted output tables
library(kableExtra) #Create nicely formatted output tables
install.packages("formattable")
library(formattable) #For the color_tile function
install.packages("circlize")
library(circlize) #Visualizations - chord diagram

install.packages("memery")
library(memery) #Memes - images with plots
install.packages("magick")
library(magick) #Memes - images with plots (image_read)
library(yarrr)  #Pirate plot
install.packages("yarrr")
install.packages("radarchart")
library(radarchart) #Visualizations
library(igraph) #ngram network diagrams
install.packages("ggraph")
library(ggraph) #ngram network diagrams
library(fmsb)




# by month plot


ap_sentiments <- tidy_tweets %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, month, sort = TRUE) %>%
  ungroup()


ap <- ap_sentiments %>%
  mutate(word = reorder(word, n)) %>%
  group_by(month, sentiment) %>%
  top_n(n = 5, wt = n) %>%
  # create a date / sentiment column for sorting
  mutate(sent_date = paste0(month, " - ", sentiment)) %>%
  arrange(month, sentiment, n)

# group by month and sentiment and then plot top 5 words each month
ap %>%
  ggplot(aes(word, n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sent_date, scales = "free_y", ncol = 2) +
  labs(title = "Sentiment during the 2013 flood event by month.",
       y = "Number of Times Word Appeared in Tweets",
       x = NULL) +
  coord_flip()



#tidy_tweets_2 <- tidy_tweets %>%
# mutate(date_time = as.POSIXct(datetimestamp, format = "%a %b %d %H:%M:%S +0000 %Y")) %>%
#mutate(tweet_text = gsub("http://*|https://*)", "", word),
#      month = as.yearmon(date_time))

###########################################################


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
