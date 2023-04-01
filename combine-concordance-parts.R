

setwd("csv")

files <- c("f990-part-00.csv", "f990-part-01.csv", 
"f990-part-02.csv", "f990-part-03.csv", "f990-part-04.csv", "f990-part-05.csv", 
"f990-part-06.csv", "f990-part-07.csv", "f990-part-08.csv", "f990-part-09.csv", 
"f990-part-10.csv", "f990-part-11.csv", "f990-part-12.csv", "schedule-a.csv", 
"schedule-c.csv", "schedule-d.csv", "schedule-e.csv", "schedule-f.csv", 
"schedule-g.csv", "schedule-h.csv", "schedule-i.csv", "schedule-j.csv", 
"schedule-k.csv", "schedule-l.csv", "schedule-m.csv", "schedule-n.csv", 
"schedule-o.csv", "schedule-r.csv")

dd <- NULL

for( i in files )
{
  d.temp <- read.csv( i )
  dd <- bind_rows( dd, d.temp )
}


# NEED TO CHECK THESE !
dd[ duplicated(dd$xpath) , ]



save( dd, file="concordance.rda" )
write.csv( dd, "concordance.csv", row.names=F )




