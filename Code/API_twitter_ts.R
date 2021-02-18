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

####################################################################################################

tweets_unemployment  = searchTwitter('unemployment', n = 5000, since = '2020-05-20', until = '2020-05-20')
tweets_employment_2 = searchTwitter('unemployment', n = 5000, since = '2020-05-20', until = '2020-05-21')
tweets_unemployment_3 = searchTwitter('unemployment', n = 5000, since = '2020-05-21', until = '2020-05-22')
tweets_unemployment_4 = searchTwitter('unemployment ', n = 5000, since = '2020-05-22', until = '2020-05-23')
tweets_unemployment_5 = searchTwitter('unemployment', n = 5000, since = '2020-05-23', until = '2020-05-24')
tweets_unemployment_6 = searchTwitter('unemployment', n = 5000, since = '2020-05-24', until = '2020-05-25')
tweets_unemployment_7 = searchTwitter('unemployment ', n = 5000, since = '2020-05-25', until = '2020-05-26')
tweets_unemployment_8 = searchTwitter('unemployment ', n = 5000, since = '2020-05-26', until = '2020-05-27')
tweets_unemployment_9 = searchTwitter('unemployment ', n = 5000, since = '2020-05-27', until = '2020-05-28')
tweets_unemployment_10 = searchTwitter('unemployment', n = 5000, since = '2020-05-28', until = '2020-05-29')

unemployment  <- do.call(c, list(tweets_unemployment , tweets_unemployment_2,
                               tweets_unemployment_3,tweets_unemployment_4, tweets_unemployment_5, tweets_unemployment_6, tweets_unemployment_7, tweets_unemployment_8))
tweets_unemployment  <- twListToDF(unemployment )
write.csv(tweets_unemployment , file ="tweets_unemployment .csv", row.names = FALSE)
rm(tweets_unemployment_2, tweets_unemployment_3,tweets_unemployment_4, tweets_unemployment_5, tweets_unemployment_6, tweets_unemployment_7, tweets_unemployment_8)

›
####################################################################################################

tweets_china = searchTwitter('china', n = 5000, since = '2020-05-19', until = '2020-05-20')
tweets_china2 = searchTwitter('china', n = 5000, since = '2020-05-20', until = '2020-05-21')
tweets_china3 = searchTwitter('china', n = 5000, since = '2020-05-21', until = '2020-05-22')
tweets_china4 = searchTwitter('china', n = 5000, since = '2020-05-22', until = '2020-05-23')
tweets_china5 = searchTwitter('china', n = 5000, since = '2020-05-23', until = '2020-05-24')
tweets_china6 = searchTwitter('china', n = 5000, since = '2020-05-24', until = '2020-05-25')
tweets_china7 = searchTwitter('china', n = 5000, since = '2020-05-25', until = '2020-05-26')
tweets_china8 = searchTwitter('china', n = 5000, since = '2020-05-26', until = '2020-05-27')
tweets_china9 = searchTwitter('china', n = 5000, since = '2020-05-27', until = '2020-05-28')
tweets_china10 = searchTwitter('china', n = 5000, since = '2020-05-28', until = '2020-05-29')

####################################################################################################

tweets_migration  = searchTwitter('migration ', n = 5000, since = '2020-05-19', until = '2020-05-20')
tweets_migration_2 = searchTwitter('migration ', n = 5000, since = '2020-05-20', until = '2020-05-21')
tweets_migration_3 = searchTwitter('migration ', n = 5000, since = '2020-05-21', until = '2020-05-22')
tweets_migration_4 = searchTwitter('migration ', n = 5000, since = '2020-05-22', until = '2020-05-23')
tweets_migration_5 = searchTwitter('migration ', n = 5000, since = '2020-05-23', until = '2020-05-24')
tweets_migration_6 = searchTwitter('migration ', n = 5000, since = '2020-05-24', until = '2020-05-25')
tweets_migration_7 = searchTwitter('migration ', n = 5000, since = '2020-05-25', until = '2020-05-26')
tweets_migration_8 = searchTwitter('migration ', n = 5000, since = '2020-05-26', until = '2020-05-27')
tweets_migration_9 = searchTwitter('migration ', n = 5000, since = '2020-05-27', until = '2020-05-28')
tweets_migration_10 = searchTwitter('migration ', n = 5000, since = '2020-05-28', until = '2020-05-29')


migration  <- do.call(c, list(tweets_migration_10, tweets_migration_9))
tweets_migration  <- twListToDF(migration )
write.csv(tweets_migration , file ="tweets_migration .csv", row.names = FALSE)
rm(tweets_migration_2, tweets_migration_3,tweets_migration_4, tweets_migration_5, tweets_migration_6, tweets_migration_7, tweets_migration_8)
ts_migration <-rbind(migration, tweets_migration)


china <- do.call(c, list(tweets_china, tweets_china2, tweets_china3,tweets_china4, tweets_china5, tweets_china6, tweets_china7, tweets_china8))
tweets_china <- twListToDF(china)
write.csv(tweets_china, file ="tweets_china.csv", row.names = FALSE)
rm(tweets_china2, tweets_china3,tweets_china4, tweets_china5, tweets_china6, tweets_china7, tweets_china8)

####################################################################################################
library(ggplot2)
library(rtweet)

employment <- twListToDF(tweets_employment)
employment <- as.data.frame(tweets_employment)

tweets_employment %>%
  dplyr::group_by(isRetweet) %>%
  ts_plot(by ="mins")

p1 <- ts_plot(ts_migration, by = "hours") +
  ggplot2::theme_minimal() +
  labs(
    x = "Date and time",
    y = "Frequency of tweets",
    title = "Time series of #ICA17 tweets",
    subtitle = "Frequency of Twitter statuses calculated in one-hour intervals."
  )
p1
####################################################################################################
