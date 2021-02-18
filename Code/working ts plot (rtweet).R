
p1 <- ts_plot(ts_migration, by = "hours") +
  ggplot2::theme_minimal() +
     labs(
        x = "Date and time",
    y = "Frequency of tweets",
    title = "Time series of #ICA17 tweets",
     subtitle = "Frequency of Twitter statuses calculated in one-hour intervals."
    )
p1
