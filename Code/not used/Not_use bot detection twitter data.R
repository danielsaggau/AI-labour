
library(tweetbotornot)

tweets_c <- read_rds("Data /tweets_trade_china_l.csv")
users <- unique(china$screenName)
users

data <- botornot(users)

# hash the usernames
data$user_hash <- md5(data$user)

# arrange by prob ests
data %>%
  arrange(desc(prob_bot)) %>%
  select(-user)

users <- search_users("@buffer")


3
# join dataframes
buffer_users <- data %>%
  left_join(users, by = c("user" = "screen_name"))

# get Buffered tweets for each user
by_user <- tweets %>%
  mutate(sent_with_buffer = source == "Buffer") %>%
  group_by(screen_name, sent_with_buffer) %>%
  summarise(buffered_tweets = n_distinct(status_id)) %>%
  mutate(total_tweets = sum(buffered_tweets),
         percent_buffered = buffered_tweets / sum(buffered_tweets)) %>%
  filter(sent_with_buffer == TRUE) %>%
  select(-sent_with_buffer)

# join to buffer_users dataframe
buffer_users <- buffer_users %>%
  left_join(by_user, by = c('user' = 'screen_name'))

# replace NAs with 0
buffer_users$buffered_tweets[is.na(buffer_users$buffered_tweets)] <- 0
buffer_users$percent_buffered[is.na(buffer_users$percent_buffered)] <- 0


# list bot accounts
bots <- c('tiny_raindrops_', 'KAFFEE_REMINDER', 'MYPRESIDENTIS', 'COLORISEBOT', 'OSSPBOT',
          'GITWISHES', 'SAYSTHEKREMLIN', 'NLPROVERBS', 'THEDOOMCLOCK', 'DAILYGLACIER')

# get botornot estimates
bot_data <- botornot(bots)

# view prob ests
bot_data %>% arrange(desc(prob_bot))

#############################################

load("data/users_bots_id_30.rda")
library(tweetbotornot)
system.time({
  bots.score.r <- tweetbotornot(bots.id)$prob_bot;
  users.score.r <- tweetbotornot(users.id)$prob_bot
})
