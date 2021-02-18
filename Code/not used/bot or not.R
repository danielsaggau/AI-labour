library(tweetbotornot)
library(tidyverse)

## select users
tmls <- get_timelines(users, n = 10)

## get botornot estimates
data <- tweetbotornot(users, fast = TRUE)
data <- botornot(tmls)

data[order(data$prob_bot), ]
table <- as.table(data)
