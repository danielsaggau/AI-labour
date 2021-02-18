library(dplyr)
library(qdap)
library(topicmodels)
library(leaflet)
library(maps)
library(rjson)
library(jsonlite)
library(ggplot2)
library(tidyr)
library(gganimate)
library(lubridate)
library(ggthemes)
library(sp)
library(ggmap)
require("rgdal")


# create basemap of the globe
world_basemap <- ggplot() +
  borders("world", colour = "gray85", fill = "gray80") +
  theme_map()

world_basemap +
  geom_point(data = tweets_employment_, aes(x = longitude, y = latitude),
             colour = 'purple', alpha = .5) +
  scale_size_continuous(range = c(1, 8),
                        breaks = c(250, 500, 750, 1000))

site_locations <- leaflet(tweets_employment_) %>%
  addTiles() %>%
  addCircleMarkers(lng = ~longitude, lat = ~latitude, popup = ~tweets_automation$text,
                   radius = 3, stroke = FALSE)
site_locations

# summarize by day?
# perhaps round the lat long and then do it?
# since it's all in sept


tweet_locations_grp <- tweets_employment_ %>%
  mutate(day = day(created),
         long_round = round(longitude, 2),
         lat_round = round(latitude, 2)) %>%
  group_by(day, long_round, lat_round) %>%
  summarise(total_count = n())

# this also works -- plotting across the world here...
grouped_tweet_map <- world_basemap +
  geom_point(data = tweet_locations_grp,
   aes(long_round, lat_round, frame = day, size = total_count),
   color = "red", alpha = .8) +
  coord_fixed() +
  labs(title = "Twitter Activity during lockdown with tweets focusing on employment_")

grouped_tweet_map
