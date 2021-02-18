syuzhet <- get_sentiment(tweets_china$text, method="syuzhet")
bing <- get_sentiment(tweets_china$text, method="bing")
afinn <- get_sentiment(tweets_china$text, method="afinn")
nrc <- get_sentiment(tweets_china$text, method="nrc")
nrc <- get_sentiment(tweets_china$text, method="nrc")
sentiments <- data.frame(syuzhet, bing, afinn, nrc)


