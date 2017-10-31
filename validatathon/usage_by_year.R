library(tidyverse)
var_ver <- read_csv("./validatathon/var_by_ver.csv")
head(var_ver)

var_year <- var_ver %>%
  spread(version, count) %>%
  mutate_at(vars(-variable), funs(ifelse(is.na(.), FALSE, TRUE)))

write_csv(var_year, "./output/var_usage_by_year.csv")

# Merge with final report
fr <- read_csv("./output/final_report.csv")
head(var_year)

vd_worksheet <- fr %>%
  inner_join(var_year, by = c("variable_name" = "variable")) %>%
  select(-c(xpath, production_rule, rdb_table, cardinality, required, processed, version, last_version_modified))

write_csv(vd_worksheet, "./output/worksheet.csv")
