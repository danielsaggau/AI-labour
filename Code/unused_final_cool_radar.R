library(twitteR)
library(rtweet)
library(ROAuth)
library(RCurl)
library(tidytext)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(reshape2)
library(wordcloud)
library(tm)
library(qdap)
library(wordcloud)
library(tm)
library(radarchart)
library(ggrepel) #`geom_label_repel`
library(gridExtra) #`grid.arrange()` for multi-graphs
library(knitr) #Create nicely formatted output tables
library(kableExtra) #Create nicely formatted output tables
library(formattable) #For the color_tile function
library(circlize) #Visualizations - chord diagram
library(memery) #Memes - images with plots
library(magick) #Memes - images with plots (image_read)
library(yarrr)  #Pirate plot
library(radarchart) #Visualizations
library(igraph) #ngram network diagrams
library(ggraph) #ngram network diagrams

nrc_radar_chart <- Sentimentscores_twitter %>%   filter(!grepl("positive|negative", sentiment))
word_tally <- Sentimentscores_twitter %>%
  group_by(sentiment)
library(RColorBrewer)

chartJSRadar(scores= word_tally,
             showLegend = FALSE, main= "Word Frequency Employment", color = "my_colors")

rm(ctweets, mysentiment_twitter, nrc_radar_chart, Sentimentscores_twitter, tweets_automation, word_tally)

chart_auto1 <-chartJSRadar(scores= word_tally,
                           showLegend = FALSE, main= "Word Frequency Automation", color = "my_colors")

chart_migration <- chartJSRadar(scores= word_tally,
                                showLegend = FALSE, main= "Word Frequency Migration", color = "my_colors")




tk <- token_clean %>%
  count(word) %>%
  inner_join(get_sentiments("nrc"), by = "word") %>%
  group_by(sentiment) %>%
  top_n(10, n) %>%
  ungroup() %>%
  mutate(word = reorder(word, n))

ggplot(tk, aes(x=sentiment, y=n, fill =sentiment),stat = "identity") +
         geom_bar(aes(fill=sentiment),stat = "identity") +
  theme(legend.position="none") +
  xlab("Sentiments")+ylab("scores")+ggtitle("Sentiments toward China")

############################################################################
# Misc.

# From previous step
library(tidyverse)
library(syuzhet)
scores <- tidy_tweets %>%
  inner_join(get_nrc_sentiment()) %>%
  filter(!grepl("positive|negative", sentiment)) %>%
  count(book, sentiment) %>%
  spread(book, n)

# JavaScript radar chart
# chartJSRadar(scores)



