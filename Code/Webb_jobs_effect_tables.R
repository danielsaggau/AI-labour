## Frequency tables and ranking of exposed industries
library(tidyr)
library(dplyr)
library(haven)
library(broom)
library(xtable)
library(tables)
library(stargazer)
library(knitr)

final_df_out <- read_dta("Data /final_df_out.dta")

kablerobot <- final_df_out %>% select(c(index, agg_pairs, robot_score)) %>% filter(agg_pairs >20) %>% arrange(desc(robot_score))
final_df_out %>% select(c(index, agg_pairs, software_score)) %>% arrange(desc(software_score))
final_df_out %>% select(c(index, agg_pairs, ai_score)) %>% arrange(desc(ai_score))

kable(kablerobot[1:10,], caption = "robots and their effect on employment")

most <- final_df_out %>%
  select(c(index, agg_pairs, robot_score)) %>%
  filter(agg_pairs >20)%>%
  arrange(desc(robot_score)) %>%
  rename(count = agg_pairs,
         score = robot_score)

kable(most[1:10,], caption = "Most exposed professions employment")

least <- most %>%
  select(c(index, count, score)) %>%
  arrange(score)

kable(least[1:10,], caption = "Least exposed professions employment")
