library(tidyverse)
var_ver <- read_csv("./validatathon/var_by_ver.csv")
head(var_ver)

var_year <- var_ver %>%
  spread(version, count) %>%
  mutate_at(vars(-variable), funs(ifelse(is.na(.), 0, .)))

write.csv(var_year, "var_usage_by_year.csv")
