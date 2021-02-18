# data manipulation
library(dplyr)
library(ggplot2)

unemployment <- ilostat_unemployment_monthly_us_[-c(1,3,9:12)]
unemployment <- mutate(unemployment, sex = substr(sex_label, 5, nchar(sex_label)))
unemployment <- mutate(unemployment, area = substr(classif2_label, 11, nchar(classif2_label)))
unemployment <- mutate(unemployment, age = substr(classif1_label, 24, nchar(classif1_label)))
unemployment <- unemployment[-c(2:4)]


plot <- ggplot(unemployment, aes(obs_value, sex)) +
  geom_point()
plot
plot + facet_grid(unemployment$area)
