
boost <- Boost_tokenizer(ctweets)

mysentiment_twitter <-get_nrc_sentiment((tweets_text))
Sentimentscores_twitter <-data.frame(colSums(mysentiment_twitter[,]))

names(Sentimentscores_twitter)<-"Score"
Sentimentscores_twitter <- cbind("sentiment"=rownames(Sentimentscores_twitter),Sentimentscores_twitter)
rownames(Sentimentscores_twitter) <- NULL

ggplot(data=Sentimentscores_twitter,aes( x= sentiment,y = Score))+geom_bar(aes(fill=sentiment),stat = "identity") +
  theme(legend.position="none") +
  xlab("Sentiments")+ylab("scores")+ggtitle("Sentiments Twitter")
