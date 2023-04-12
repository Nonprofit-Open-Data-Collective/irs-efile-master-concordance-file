library( tidyverse )
library( knitr )

url <- "https://raw.githubusercontent.com/Nonprofit-Open-Data-Collective/irs-efile-master-concordance-file/master/990_forms/pdfs.csv"
pdfs <- read.csv( url )
head( pdfs ) %>% kable()

# | year|type      |url                                                 |
# |----:|:---------|:---------------------------------------------------|
# | 1992|f990-w-fy |https://www.irs.gov/pub/irs-prior/f990wfy--1992.pdf |
# | 2022|f990-w    |https://www.irs.gov/pub/irs-prior/f990w--2022.pdf   |
# | 2021|f990-w    |https://www.irs.gov/pub/irs-prior/f990w--2021.pdf   |
# | 2020|f990-w    |https://www.irs.gov/pub/irs-prior/f990w--2020.pdf   |
# | 2019|f990-w    |https://www.irs.gov/pub/irs-prior/f990w--2019.pdf   |
# | 2018|f990-w    |https://www.irs.gov/pub/irs-prior/f990w--2018.pdf   |



# CREATE FOLDERS
years <- unique( pdfs$year )
for( i in years )
{ dir.create( i ) }


# BATCH DOWNLOAD FILES
for( i in 1:nrow(pdfs) )
{  
  type.i <- pdfs$type[i]
  year.i <- pdfs$year[i]
  url.i  <- pdfs$url[i]

  # example: '2015/f990-2015.pdf'
  file.name.i <- paste0( year.i, "/", type.i, "-", year.i, ".pdf" )

  try ( 
         download.file( url = url.i, 
                        destfile = file.name.i,
                        mode = "wb" ) )

}  # end for i loop



###
###  CHECK FOR ALL FORMS 
###  IN ALL YEARS
###


# check all form types for a given year

download_forms <- function( year )
{
  dir.create( year )
  url.root <- "https://www.irs.gov/pub/irs-prior/"
  
  # form.type <- unique( pdfs$type ) %>% sort()
  form.type <- 
    c("f990", "f990-a-sf", "f990-ar", "f990-bl", "f990-c", "f990-ez", 
    "f990-p-schedule-a", "f990-pf", "f990-schedule-a", "f990-schedule-b", 
    "f990-schedule-c", "f990-schedule-d", "f990-schedule-e", "f990-schedule-f", 
    "f990-schedule-f-1", "f990-schedule-g", "f990-schedule-h", "f990-schedule-i", 
    "f990-schedule-i-1", "f990-schedule-j", "f990-schedule-j-1", 
    "f990-schedule-j-2", "f990-schedule-k", "f990-schedule-l", "f990-schedule-m", 
    "f990-schedule-n", "f990-schedule-n-1", "f990-schedule-o", "f990-schedule-r", 
    "f990-schedule-r-1", "f990-sf", "f990-t", "f990-t-schedule-a", 
    "f990-t-schedule-m", "f990-w", "f990-w-fy")
  
  for( i in form.type )
  {
    url.i <- paste0( url.root, year, "--", i, ".pdf" )
    file.name.i <- paste0( year, "/", i, "-", year, ".pdf" )
    if( ! file.exists( file.name.i ) )
    { 
       try ( 
         download.file( url = url.i, 
                        destfile = file.name.i,
                        mode = "wb" ) )
    }   # end of if
    
  }     # end of loop
  
  return( NULL )
  
}       # end of function 



# CHECK FOR ALL YEARS
years <- 1951:2022
for( j in years )
{ download_forms(j) }


# TO UPDATE ONLY ONE YEAR
download_forms( 2022 )












##################### ALTERNATIVE 



form.type <- unique( pdfs$type ) %>% sort()
years <- 1951:2022


for( i in form.type )
{
  for( j in years )
  {
    url.ij <- paste0( url.root, i, "--", j, ".pdf" )
    
    # '2015/f990-2015.pdf'
    file.name.ij <- paste0( j, "/", i, "-", j, ".pdf" )

    if( ! file.exists( file.name.ij ) )
    { 
       try ( 
         download.file( url = url.ij, 
                        destfile = file.name.ij,
                        mode = "wb" ) )
    } # end of if
    
  }   # end of j loop
}     # end of i loop 

