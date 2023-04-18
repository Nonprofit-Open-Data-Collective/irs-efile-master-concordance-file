# CREATE FOLDERS
year <- 1951:2022
year <- as.character( year )
for( i in year )
{ dir.create( i ) }

# CREATE DATA FRAME WITH LIST OF FORM TYPES AND CORRESPONDING URL ENDINGS
# These form types and url endings come from a review of the form types included in the IRS Prior Directory and their corresponding URLS.
# The IRS Prior Directory is available at: https://www.irs.gov/downloads/irs-prior

df <- data.frame( form.type = 
                    c("f990", "f990-a-sf", "f990-ar", "f990-bl", "f990-c", "f990-ez", 
                      "f990-p-schedule-a", "f990-pf", "f990-schedule-a", "f990-schedule-b", 
                      "f990-schedule-c", "f990-schedule-d", "f990-schedule-e", "f990-schedule-f", 
                      "f990-schedule-f-1", "f990-schedule-g", "f990-schedule-h", "f990-schedule-i", 
                      "f990-schedule-i-1", "f990-schedule-j", "f990-schedule-j-1", 
                      "f990-schedule-j-2", "f990-schedule-k", "f990-schedule-l", "f990-schedule-m", 
                      "f990-schedule-n", "f990-schedule-n-1", "f990-schedule-o", "f990-schedule-r", 
                      "f990-schedule-r-1", "f990-sf", "f990-t", "f990-t-schedule-a", 
                      "f990-t-schedule-m", "f990-w", "f990-w-fy"),
                  url.end = 
                    c("f990", "f990asf", "f990ar", "f990bl", "f990c", "f990ez", 
                      "f990psa", "f990pf", "f990sa", "f990ezb", 
                      "f990sc", "f990sd", "f990se", "f990sf", 
                      "f990sf1", "f990sg", "f990sh", "f990si", 
                      "f990si1", "f990sj", "f990sj1", 
                      "f990sj2", "f990sk", "f990sl", "f990sm", 
                      "f990sn", "f990sn1", "f990so", "f990sr", 
                      "f990sr1", "f990shf", "f990t", "f990tsa", 
                      "f990tsm", "f990w", "f990wfy")
)
                    
# CREATE FUNCTION FOR DOWNLOADING FORMS
download_forms <- function( year )
  {
    url.root <- "https://www.irs.gov/pub/irs-prior/"
    for( i in 1:nrow(df) )
      {
        file.name.i <- paste0( year, "/", df$form.type[i], "-", year, ".pdf" )
        url.i <- paste0( url.root, df$url.end[i], "--", year, ".pdf" )
        if( ! file.exists( file.name.i ) )
        { 
          try ( 
            download.file( url = url.i, 
                           destfile = file.name.i,
                           mode = "wb" ) )
        }   # end of if
    
  }   # end of loop
   
  return( NULL )
  
}   # end of function 

# TO UPDATE ALL YEARS
# Change 2022 to the most recent year.
years <- 1951:2022
for( j in years )
  { download_forms(j) }

# TO UPDATE ONLY ONE YEAR
# Change 2022 to the year you want to update.
download_forms( 2022 )
