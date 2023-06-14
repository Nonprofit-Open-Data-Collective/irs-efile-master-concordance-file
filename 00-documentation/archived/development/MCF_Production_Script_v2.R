

setwd( "C:/Users/jdlecy/Dropbox/00 - Nonprofit Open Data/04 - Master Concordance File" )




###############    MIGUEL'S VERSION    ####################

d1 <- read.csv( "Concordance_August_9_2017_Miguel_Barbosa.csv" )




###############    DATATHON VERSION    ####################

d2 <- read.csv( "concordance_final_from_datathon_july.csv" )



# DELETE DATATHON ROWS MISSING XPATHS (12 total)

nrow( d2 ) # 1557

d2 <- d2[ ! is.na( d2$XPATH ) , ]

nrow( d2 ) # 1545

d2 <- d2[ d2$XPATH != "/Return/ReturnData/IRS990/" , ] # not sure what these are






# MAKE SURE VARIABLE NAMES ARE ALL CAPS

d1$VARIABLE_NAME <- toupper( d1$VARIABLE_NAME )
d2$VARIABLE_NAME <- toupper( d2$VARIABLE_NAME )




# ADD SLASH BEFORE XPATHS FROM MIGUEL

d1$XPATH <- paste( "/", d1$XPATH, sep="" ) 






# IDENTIFYING DUPLICATED XPATHS IN DATATHON FILE

these <- duplicated( d2$XPATH, fromLast=FALSE ) | duplicated( d2$XPATH, fromLast=TRUE )

dupes <- d2[ these , ]

head( dupes[ order(dupes$XPATH) , ] )

# write.csv( dupes, "FindDupes.csv", row.names=F )
# 
# these <- duplicated( d2$XPATH, fromLast=FALSE ) | duplicated( d2$XPATH, fromLast=TRUE )
# 
# dupes.dropped <- d2[ ! these , ]





# FIX DUPLICATES
#
# Remove xpaths that occur multiple times
# because of different version info and replace
# with reconciled cases where version info is
# combined for identical xpaths.
# This was done manually, and stored in ReconciledDuplicates.csv.


dupes.fixed <- read.csv( "ReconciledDuplicates.csv" )

head( dupes.fixed )

these <- dupes.fixed$XPATH

d2.sub <- d2[ ! d2$XPATH %in% these , ]

d2 <- rbind( d2.sub, dupes.fixed )

nrow( d2 ) # 1449

length( unique( d2$XPATH ) )  # 1449














# ADD ANALYSTS TO MIGUEL'S FILE

d3 <- d2[ c("XPATH","Analyst") ]

d1 <- merge( d1, d3, by.x="XPATH", by.y="XPATH", all.x=T )

d1$Analyst <- as.character( d1$Analyst )

d1$Analyst[ is.na(d1$Analyst) ] <- "Miguel"

table( d1$Analyst, useNA="ifany" )







# SPLIT PZ FIELDS FROM MIGUEL
# 
# These are SB (signature block) cases that occur in PC, EZ, and PF.
# The PC and EZ versions were concatenated together in Miguel's file.

head( d1[ grepl( ";", d1$XPATH ), ] )

sum( grepl( ";", d1$XPATH ) )



d1.sub <- d1[ grepl( ";", d1$XPATH ), ] # all concatenated cases
d1.sub$XPATH <- gsub( "; ", "; /", d1.sub$XPATH )

d1.sub2 <- d1[ ! grepl( ";", d1$XPATH ), ] # drop all concatenated cases

# split xpaths and location codes into separate lines

d1.sub3 <- NULL

for( i in 1:nrow(d1.sub) )
{

   df <- d1.sub[ i, ]

   LOCATION <- strsplit( as.character(df$LOCATION), "; " )[[1]]

   XPATH <- strsplit( as.character(df$XPATH), "; " )[[1]]

   df2 <- df[ c("VARIABLE_NAME","DESCRIPTION","VERSION","REQUIRED", "NOTES","FLAG","Analyst") ]

   df3 <- data.frame( LOCATION, XPATH, df2 )

   d1.sub3 <- rbind( d1.sub3, df3 )

}

d1.sub3$LOCATION <- as.character( d1.sub3$LOCATION )

sum( grepl( "-EZ-", d1.sub3$LOCATION ) )

d1.sub3$LOCATION[ grepl( "-EZ-", d1.sub3$LOCATION ) ] <- "F990-EZ-"

d1.sub3 <- d1.sub3[  names( d1.sub2 ) ]

d1 <- rbind( d1.sub2, d1.sub3 ) # combine original files plus all split cases

head( d1.sub3[,1:3], 25 )






# ADD MISSING XPATHS TO MIGUEL'S VERSION


nrow( d1 )
length( unique( d1$XPATH ) )

nrow( d2 )
length( unique( d2$XPATH ) )

length( intersect( d1$XPATH, d2$XPATH ) )

length( unique( c(d1$XPATH, d2$XPATH ) ) )

length( setdiff( d2$XPATH, d1$XPATH ) )



# When xpath occurs in both, drop Miguel's
# version and use datathon version

xpaths.d2 <- d2$XPATH

d1 <- d1[ ! d1$XPATH %in% xpaths.d2 , ]

d1 <- rbind( d1, d2 )

length( setdiff( d2$XPATH, d1$XPATH ) )

nrow( d1 )  # 9809

length( unique( d1$XPATH ) ) # 9799





# DEFINE HEADER AND SIGNATURE BLOCK VARIABLES

nrow( d1 )
length( unique( d1$XPATH ) )


sum( grepl( "/Return/ReturnHeader", d1$XPATH ) )

dupes <- d1[ grepl( "/Return/ReturnHeader", d1$XPATH ), ] #108

dupes <- d1[ d1$VARIABLE_NAME %in% dupes$VARIABLE_NAME , ] #140



# Replace signature block scope with HD code and part 00:

dupes$VARIABLE_NAME <- gsub( "-PF-", "-HD-", dupes$VARIABLE_NAME )
dupes$VARIABLE_NAME <- gsub( "-PZ-", "-HD-", dupes$VARIABLE_NAME )
dupes$VARIABLE_NAME <- gsub( "-PC-", "-HD-", dupes$VARIABLE_NAME )

dupes$VARIABLE_NAME <- gsub( "-02-", "-00-", dupes$VARIABLE_NAME )

table( substr( dupes$VARIABLE_NAME, 1, 5 ) )
table( substr( dupes$VARIABLE_NAME, 7, 8 ) )


# Replace location codes:

dupes$LOCATION <- "HEADER-OR-SIGNATURE-BLOCK"

head( dupes[ order( dupes$XPATH ) , ] )

dupes <- unique( dupes )
nrow( dupes ) # 108


these.dupes <- unique( dupes$XPATH )

d1.sub <- d1[ ! d1$XPATH %in% these.dupes , ] # drop originals

d1 <- rbind( d1.sub, dupes ) # add back new header variables



nrow( d1 ) # 9799
length( unique( d1$XPATH ) ) # 9799



# RECONCILE VARIABLES THAT MOVE FROM HEADER TO DATA SECTIONS OVER TIME

count <- 1

var.names <- NULL

fix.these <- NULL

for( i in unique(d2$VARIABLE_NAME) )
{

   d.sub <- d2[ d2$VARIABLE_NAME == i , ]
     
   d.sub2 <- d1[ d1$XPATH %in% d.sub$XPATH , ]

   same <- sum( d.sub2$VARIABLE_NAME != i )
   
   space <- ""

   if( same > 0 ){ 
       space <- "  ------>   XXX   <------   "
       fix.these <- c( fix.these, i )
    }

   var.names <- c( var.names, paste( space, "LINE-", count, sep=""), i, d.sub2$VARIABLE_NAME, "-------------", "" )

   count <- count + 1
}

as.data.frame( var.names )

# none of these still in d1

intersect( fix.these, d1$VARIABLE_NAME ) 

# d2[ d2$VARIABLE_NAME == "F9-PZ-02-PREPAREUSCITY" , ] 
#
# are.these.correct <- d2[ d2$VARIABLE_NAME %in% fix.these , ]
#
# write.csv( are.these.correct, "ChangeLocationHeaderToData.csv" )









nrow( d1 ) # 9799
length( unique( d1$XPATH ) ) # 9799








# SPLIT LOCATION CODE INTO SEPARATE VARIABLES

library( reshape )

d1$VARIABLE_NAME <- gsub( "--", "-00-", d1$VARIABLE_NAME )

prefix <- colsplit(  d1$VARIABLE_NAME , split="-", names=c("FORM","SCOPE","PART","ROOT_NAME") )

# prefix$PART[ is.na(prefix$PART) ] <- 0

sum( is.na( prefix$PART ) )

d1 <- cbind( prefix, d1 )

d1$PART <- paste( "PART-", substr( (d1$PART + 100), 2, 3 ), sep="" )



nrow( d1 ) # 9799
length( unique( d1$XPATH ) ) # 9799












# ADD NEW VARIABLES

CARDINALITY <- ""

TABLE <- ""

PRODUCTION_RULE <- ""

LAST_VERSION_MODIFIED <- "Oct-16-2017"

d1 <- cbind( TABLE, PRODUCTION_RULE, CARDINALITY, LAST_VERSION_MODIFIED, d1 )





# ADD DATA TYPES FROM SCHEMA META-DATA

d.data.types <- read.csv( "master_xpath_file_from_datathon.csv" )

d.data.types <- d.data.types[ c("Xpath","Type") ]

names( d.data.types ) <- c("XPATH","DATA_TYPE")

d.data.types <- unique( d.data.types )

d.data.types <- d.data.types[ ! duplicated( d.data.types$XPATH ) , ]


d1 <- merge( d1, d.data.types, by.x="XPATH", by.y="XPATH", all.x=T )

nrow( d1 ) # 9799
length( unique( d1$XPATH ) ) # 9799




# FIX INDIVIDUAL LOCATION CODES

d1$LOCATION <- gsub( "IRS990EZ", "F990-EZ", d1$LOCATION )
d1$LOCATION <- gsub( "IRS990ScheduleN", "SCHED-N", d1$LOCATION )
d1$LOCATION <- gsub( "IRS990ScheduleM", "SCHED-M", d1$LOCATION )
d1$LOCATION <- gsub( "IRS990ScheduleK", "SCHED-K", d1$LOCATION )
d1$LOCATION <- gsub( "IRS990PF", "F990-PF", d1$LOCATION )

nrow( d1 ) # 9799
length( unique( d1$XPATH ) ) # 9799





# RENAME VARIABLES

d1 <- d1[ c("VARIABLE_NAME","DESCRIPTION","SCOPE","LOCATION","FORM","PART","DATA_TYPE","REQUIRED","CARDINALITY","TABLE","XPATH","VERSION","PRODUCTION_RULE","LAST_VERSION_MODIFIED") ]

names(d1) <- c("VARIABLE_NAME","DESCRIPTION","SCOPE","LOCATION_CODE","FORM","PART","DATA_TYPE","REQUIRED","CARDINALITY","RDB_TABLE","XPATH","VERSION","PRODUCTION_RULE","LAST_VERSION_MODIFIED")

d1$VARIABLE_NAME <- gsub( "-", "_", d1$VARIABLE_NAME )







# RECODE VARIABLE NAMES FOR AUX PF FORMS

TEMP <- gsub( "SCHED-PF", "", d1$LOCATION_CODE )
TEMP <- paste( "F990-PF", TEMP, "-AUX-SCHED-", d1$FORM, sep="" )
these.sched.pf <- grepl( "SCHED-PF", d1$LOCATION_CODE )
d1$LOCATION_CODE[ these.sched.pf ] <- TEMP[ these.sched.pf ]

nrow( d1 ) # 9799
length( unique( d1$XPATH ) ) # 9799







# REPLACE 3-CHAR FORM CODES WITH AUXILLARY PF "AF" CODE

d1$FORM <- as.character( d1$FORM )
d1$FORM[ nchar(d1$FORM) == 3 ] <- "AF"







# FIX SCOPE OF SCHEDULES

table( d1$FORM, d1$SCOPE )

# PC Filers Only: Schedules D, F, H, I, J, K, M, R

# Schedule E - Schools Only
# Schedule H - Hospitals Only


these.pz <- c( "SA","SB","SC","SE","SG","SL","SN","SO" ) # PZ Scheduled
d1$SCOPE[ d1$FORM %in% these.pz ] <- "PZ"

TEMP <- gsub( "_PC_", "_PZ_", d1$VARIABLE_NAME )
d1$VARIABLE_NAME[ d1$FORM %in% these.pz ] <- TEMP[ d1$FORM %in% these.pz ]

table( d1$FORM, d1$SCOPE )

nrow( d1 ) # 9799
length( unique( d1$XPATH ) ) # 9799






# CHANGE ORDER OF PREFIX CODES IN VARIABLE NAME TO FORM-PART-SCOPE

VN <- gsub( "^[A-Z]{3}_", "AF_", d1$VARIABLE_NAME )

head( VN, 100 )

temp.form <- substr( VN, 1, 2 )
temp.scope <- substr( VN, 4, 5 )
temp.part <- substr( VN, 7, 8 )

table( temp.form )
table( temp.scope )
table( temp.part )

temp.vn <- substr( VN, 10, nchar(VN) )

VN2 <- paste( temp.form, temp.part, temp.scope, temp.vn, sep="_" )

d1$VARIABLE_NAME <- VN2

nrow( d1 ) # 9799
length( unique( d1$XPATH ) ) # 9799





# RELABEL FORM NAMES IN "FORM" FIELD

d1$FORM[ d1$FORM == "F9" ] <- "F990"
d1$FORM[ d1$FORM == "AF" ] <- "PF-AUX-SCHED"
d1$FORM <- gsub( "^S", "SCHED-", d1$FORM )

table( d1$FORM )

nrow( d1 ) # 9799
length( unique( d1$XPATH ) ) # 9799




# CONVERT CONCORDANCE FIELD NAMES TO LOWER CASE TO AVOID PROBS IN LINUX

names( d1 ) <- tolower( names( d1 ) )




# WRITE TO FILE

write.csv( d1, "efiler_master_concordance.csv", row.names=FALSE )


d1.sample <- d1[ sample( nrow(d1), 50 ) , ]  # for preview of file on GitHub

write.csv( d1, "concordance_preview.csv", row.names=FALSE )






