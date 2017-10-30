###############################################################################
# Validatathon demo computer                                                  #
#                                                                             #
# This is the interface that participants will see when they log into their   #
# virtual computer. This program, RStudio, is a standard tool for data        #
# science.                                                                    #
#                                                                             #
# Code is run by selecting it and then pressing ctrl+enter.                   #
#                                                                             #
# Read through the following to get a sense of what the process looks like.   #
###############################################################################


###############################################################################
# The following code loads in required software libraries for the analysis.   #
###############################################################################

library(rJava)
library(RJDBC)
library(tidyverse)



###############################################################################
# The following code connects the computer to the virtual database where the  #
# 990 extracts live.                                                          #
###############################################################################

URL <- 'https://s3.amazonaws.com/athena-downloads/drivers/AthenaJDBC41-1.0.1.jar'
fil <- basename(URL)
if (!file.exists(fil)) download.file(URL, fil)
drv <- JDBC(driverClass="com.amazonaws.athena.jdbc.AthenaDriver", fil, identifier.quote="'")
con <- jdbcConnection <- dbConnect(drv, 'jdbc:awsathena://athena.us-east-1.amazonaws.com:443/',
                                   s3_staging_dir="s3://cn-athena-staging",
                                   user=Sys.getenv("ATHENA_USER"),
                                   password=Sys.getenv("ATHENA_PASSWORD"))

###############################################################################
# After running the above, the following should list all of the data sets     #
# that David has set up. Prior to the Validatathon, there will be one or more #
# "test" datasets. By the first day of the event, the "production" data set   #
# should be there as well.                                                    #
###############################################################################
dbListTables(con)

###############################################################################
# We query the data using standard SQL, as we would for any ordinary data-    #
# base. SQL can be a challenge to learn, but Jesse, Miguel, Shane, Jacob, and #
# David can work to create pre-packaged queries to extract data for analysis. #
###############################################################################

# How many data points are in the 10/13/2017 test data set?
dbGetQuery(con, "SELECT count(*) FROM test_20171013")

# What are the first three rows of data?
dbGetQuery(con, "SELECT * FROM test_20171013 LIMIT 3")

# Looks like we're missing information from these rows. That means David has a
# bug he needs to fix. Do *any* rows have non-empty values for the "form"
# field? (The answer is, unfortunately, no.)
dbGetQuery(con, "SELECT count(*) FROM test_20171013 WHERE form is not null")

# What about vartype? (Yes--about 2.5M of the original 3M data points.)
dbGetQuery(con, "SELECT count(*) FROM test_20171013 where vartype is not null")

# What about part? (All blank--probably same issue as "form.")
dbGetQuery(con, "SELECT count(*) FROM test_20171013 where part is not null")

# It looks like "location" and "analyst" actually have the text "NA" for values,
# rather than "null." This suggests that there is a different bug, over and 
# above the one that's messing up "form" and "part." It appears I have my work
# cut out for me! How many rows are affected? (Most, but not all.)
dbGetQuery(con, "SELECT count(*) FROM test_20171013 where location = 'NA'")

# What about analyst? (Exactly the same number.)
dbGetQuery(con, "SELECT count(*) FROM test_20171013 where analyst = 'NA'")