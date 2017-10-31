library(tidyverse)
library(foreach)
library(doParallel)

cc <- read_csv("efiler_master_concordance.csv")
  
fields <- cc %>%
  mutate(.id = row_number()) %>%
  group_by(variable_name) %>%
  top_n(1, .id) %>%
  ungroup() %>%
  select(-.id)
  
variables <- fields$variable_name
report <- function(variable) {
  record <- fields %>% filter(variable_name == variable)
  
  path <- paste0("http://cn-validatathon.s3-website-us-east-1.amazonaws.com/csv/", variable, ".csv")
 
  raw <- NULL
  try (raw <- read_csv(url(path), col_types = cols(.default = "c")))
  if (is.null(raw)) {
    return(TRUE)
  }
  
  examples <- raw %>% 
    mutate(.id = row_number()) %>%
    group_by(xpath) %>%
    top_n(1, .id) %>%
    ungroup() %>%
    mutate(`variable` = variable) %>%
    select(-.id) %>%
    mutate(doc = stringr::str_split(xpath, "/")[[1]][4]) %>%
    mutate(example = paste0("https://projects.propublica.org/nonprofits/organizations/",
                            ein, "/",
                            object_id, "/",
                            doc)) %>%
    select(variable, form, part, location, xpath, value, example, url, org_name, ein, object_id, dln, version)
 
  out_path = sprintf("./output/%s.csv", variable)
  write_csv(examples, out_path)
  return(TRUE)
}

genReports <- function(variables) {
  cl <- makeCluster(60)
  registerDoParallel(cl)

  foreach(variable = variables, 
          .packages = "tidyverse",
          .export = c("cc", "variables", "fields", "report")) %dopar% {
    
    # SO 20770497 
    r <- NULL
    while( is.null(r)) {
      try(
        r <- report(variable)
      )
    } 
    return(r)
  }
}

closeAllConnections()

done <- list.files(path = "./output", pattern = "\\.csv$")
done <- stringr::str_replace(done, ".csv", "")

variables <- fields %>%
  filter(!(variable_name %in% done)) %>%
  .$variable_name

# Generate them individually so that, if the session crashes, we can recover
genReports(variables)

# Now, combine them
list.files(path = "./output", pattern = "\\.csv$", full.names = TRUE) %>%
  map_df(~read_csv(.x, col_types = cols(.default = "c"))) %>%
  write_csv("./examples_all.csv")


filenames <- list.files("./output")

all_files <- Reduce(rbind, lapply(filenames, read.csv))
