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
