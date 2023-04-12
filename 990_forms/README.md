This folder contains an archive of PDFs of Form 990(PC), Form 990EZ, Form 990PF, and all Schedules. 

Note that Form 990 is referenced in the concordance as Form **990-PC** (PC for public charity), to differentiate between the **990-PF** (PF = private foundations) and **990-EZ** (abbreviated version of the full Form 990-PC filed by small nonprofits). 

## Revisions to the Form

Major revisions to Form 990 [were made in 2008 and took effect in 2010](https://www.thetaxadviser.com/issues/2009/aug/revisedform990theevolutionofgovernanceandthenonprofitworld.html), but the form has been mostly consistent since then with most changes effecting instructions and not the form itself with a few minor exceptions ([for example](https://www.pwc.com/us/en/services/tax/library/2021-form-990-contains-a-couple-of-notable-changes.html)). 

Location codes describe the location of fields on the paper version of 990 form (part + section + line). When creating data dictionaries we refer to field location on the full Form 990. For all fields with scope PZ (the questions are asked on the 990(PC) and 990-EZ), the loction codes describe the position on the full 990. 

Location codes should be consistent between years 2012 and current forms since few changes were made. That said, efile schemas and fields have evolved each year and sometimes differ slightly from 990 fields (room for additional entries, occassionally an extra field). The efile schemas were revised heavily between 2011 and 2012 so xpaths and xml field names will vary significantly across versions before and after that juncture. 


## Archive of 990 Forms

You can access old versions of forms on the IRS site: 

https://www.irs.gov/charities-non-profits/form-990-series-downloads

```r
library( tidyverse )
library( knitr )

url <- "https://raw.githubusercontent.com/Nonprofit-Open-Data-Collective/irs-efile-master-concordance-file/master/990_forms/pdfs.csv"
pdfs <- read.csv( url )
head( pdfs ) %>% kable()
```

| year|type      |url                                                 |
|----:|:---------|:---------------------------------------------------|
| 1992|f990-w-fy |https://www.irs.gov/pub/irs-prior/f990wfy--1992.pdf |
| 2022|f990-w    |https://www.irs.gov/pub/irs-prior/f990w--2022.pdf   |
| 2021|f990-w    |https://www.irs.gov/pub/irs-prior/f990w--2021.pdf   |
| 2020|f990-w    |https://www.irs.gov/pub/irs-prior/f990w--2020.pdf   |
| 2019|f990-w    |https://www.irs.gov/pub/irs-prior/f990w--2019.pdf   |
| 2018|f990-w    |https://www.irs.gov/pub/irs-prior/f990w--2018.pdf   |


```r
### ALL 990 FORM TYPES
unique( pdfs$type ) %>% sort() %>% kable()
```


| FORM TYPE        |  
|:-----------------|  
|f990              |
|f990-a-sf         |
|f990-ar           |
|f990-bl           |
|f990-c            |
|f990-ez           |
|f990-p-schedule-a |
|f990-pf           |
|f990-schedule-a   |
|f990-schedule-b   |
|f990-schedule-c   |
|f990-schedule-d   |
|f990-schedule-e   |
|f990-schedule-f   |
|f990-schedule-f-1 |
|f990-schedule-g   |
|f990-schedule-h   |
|f990-schedule-i   |
|f990-schedule-i-1 |
|f990-schedule-j   |
|f990-schedule-j-1 |
|f990-schedule-j-2 |
|f990-schedule-k   |
|f990-schedule-l   |
|f990-schedule-m   |
|f990-schedule-n   |
|f990-schedule-n-1 |
|f990-schedule-o   |
|f990-schedule-r   |
|f990-schedule-r-1 |
|f990-sf           |
|f990-t            |
|f990-t-schedule-a |
|f990-t-schedule-m |
|f990-w            |
|f990-w-fy         |  


Batch download all old 990 forms. 

```r
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



# TO UPDATE ONLY ONE YEAR
download_forms( 2022 )

# CHECK FOR ALL YEARS
years <- 1951:2022
for( j in years )
{ download_forms(j) }
```



