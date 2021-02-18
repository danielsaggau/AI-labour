# api_key
devtools::install_github("mkearney/rtweet")

## install httpuv if not already
if (!requireNamespace("httpuv", quietly = TRUE)) {
  install.packages("httpuv")
}

library(rtweet)

## store api keys (these are fake example values; replace with your own keys)

api_key <-"twuA4tEWyC3B7qoLMh2XA0nor"
api_secret_key <- "gD2Leynh9PbqGT624dRS3d3KRKYzqcQM8e1VcMi5Lz3AEXZiNx"
access_token <- "1263560948641603584-D8JZiafcXKmb3xChLZlQOln8xk1tIz"
access_token_secret <- "Dwcz68GreTDMZsRUcf1hjlkspZXHMRHJjFCHeGrAumtNf"

## authenticate via web browser
token <- create_token(
  app = "daniellockdowndata",
  consumer_key = api_key,
  consumer_secret =  api_secret_key,
  access_token = access_token,
  access_secret = access_token_secret)

get_token()
setup_twitter_oauth(api_key, api_secret_key, access_token, access_token_secret)


##############################################################################
# text mining
library("twitteR")
library("ROAuth")

# see api to enable searchTwitter

##############################################################################
## attempt larger set
# Technology related tweets
tweets_technology_l = searchTwitter('technology+work', n = 10000)
tweets_technology_AI = searchTwitter('machine+learning', n = 10000)

# tweets about employment
tweets_automation = searchTwitter('automation', n = 30000, since = '2020-05-18', until = '2020-05-26')
tweets_employment = searchTwitter('employment', n = 30000, since = '2020-05-18', until = '2020-05-26')

# tweets about political topics
tweets_trade = searchTwitter('trade', n = 30000, since = '2020-05-18', until = '2020-05-25')
tweets_migration = searchTwitter('migration', n =30000, since='2020-05-18', until='2020-05-25')
tweets_china = searchTwitter('china', n = 5000, since = '2020-05-19', until = '2020-05-20')


##############################################################################
# data frame for large data set

tweets.df_china <- twListToDF(tweets_china)
tweets.df_trade <- twListToDF(tweets_trade)
tweets.df_employment <- twListToDF(tweets_employment)
tweets.df_technology_AI <- twListToDF(tweets_technology_AI)
tweets.df_automation <- twListToDF(tweets_automation)
tweets.df_migration <- twListToDF(tweets_migration)

##############################################################################
# save as a csv (large file )
write.csv(tweets.dfl, file ="tweets_technology_2.csv", row.names = FALSE)
write.csv(tweets.df_trade, file ="tweets_trade.csv", row.names = FALSE)
write.csv(tweets.df_employment, file = "tweets.df_employment.csv", row.names = FALSE)
write.csv(tweets.df_china, file = "tweets.df_technology_AI.csv", row.names = FALSE)
write.csv(tweets.df_automation, file ="tweets_automation.csv", row.names = FALSE)
write.csv(tweets.df_migration, file ="tweets_migration.csv", row.names = FALSE)
