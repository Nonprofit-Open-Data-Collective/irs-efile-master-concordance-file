library(tidyverse)
library(foreach)
library(doParallel)

cc <- read_csv("efiler_master_concordance.csv")
v_count_global <- read_csv("validatathon/version_count.csv")
  
fields <- cc %>%
  group_by(variable_name) %>%
  sample_n(1) %>%
  ungroup()
  
variables <- fields$variable_name

report <- function(variable) {
  record <- fields %>% filter(variable_name == variable)
  
  path <- paste0("http://cn-validatathon.s3-website-us-east-1.amazonaws.com/csv/", variable, ".csv")
 
  raw <- NULL
  try (raw <- read_csv(url(path)))
  if (is.null(raw)) {
    return(TRUE)
  }
  
  output <- paste0("/reports/", variable, ".html")
  if (is.numeric(raw$value)) {
    rmarkdown::render(input = "./validatathon/numeric_template.Rmd", output_file = output)
  } else {
    rmarkdown::render(input = "./validatathon/text_template.Rmd", output_file = output)
  }
  return(TRUE)
}

# Now just keep doing this until it's all done

genReports <- function(variables) {
  cl <- makeCluster(63)
  registerDoParallel(cl)

  foreach(variable = variables, 
          .packages = "tidyverse",
          .export = c("cc", "v_count_global", "fields", "report")) %dopar% {
    
    # SO 20770497 
    r <- NULL
    while( is.null(r)) {
      try(
        r <- report(variable)
      )
    } 
  }
}

closeAllConnections()

done <- list.files(path = "/reports", pattern = "\\.html$")
done <- stringr::str_replace(done, ".html", "")

variables <- fields %>%
  filter(!(variable_name %in% done)) %>%
  .$variable_name

genReports(variables)

done <- list.files(path = "/reports", pattern = "\\.html$")
done <- stringr::str_replace(done, ".html", "")

getReportPath <- function(variable) {
  path <- paste0("http://cn-validatathon.s3-website-us-east-1.amazonaws.com/reports/", variable, ".html")
  return(path)
}

getCsvPath <- function(variable) {
  path <- paste0("http://cn-validatathon.s3-website-us-east-1.amazonaws.com/csv/", variable, ".csv")
  return(path)
}

final_report <- fields %>%
  mutate(processed = variable_name %in% done) %>%
  mutate(report_path = ifelse(processed, getReportPath(variable_name), NA)) %>%
  mutate(csv_path = ifelse(processed, getCsvPath(variable_name), NA))