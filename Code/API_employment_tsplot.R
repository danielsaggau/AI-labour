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
