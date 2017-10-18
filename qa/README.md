## Quality Assurance - Master Concordance File

Different spreadsheet programs output .csv files in slightly different flavors. Excel on Mac, for intance, uses \r\n to end lines instead of just \n. In order to make sure that the file diffs are readable, we standardize the output of these files before committing. 

As always, the best solution is to *not use spreadsheet programs* to modify the file, but since we're likely to have this problem eventually, here's the standard we're using is this:

- The text should be utf8 (which includes all the regular ascii stuff) Latin1 specific characters (which spreadsheet programs love to add) is not (which means no curly quotes, etc). 
- fields delimited by a comma
- double quotes around every field
- unix line endings: lines delimited by \n only.
- No white space at the start of a field (if there is white space it'll get removed)

To enforce these rules, be sure to run [csvformat](http://csvkit.readthedocs.io/en/1.0.2/scripts/csvformat.html) available from the csvkit project with these arguments:

	$ csvformat -U 1 efiler_master_concordance.csv > efiler_master_concordance_modified.csv

Then check if the file diff is useful by running 
	
		$ diff efiler_master_concordance.csv efiler_master_concordance_modified.csv

If the output is every line in the file, something's gone wrong (unless you actually changed every line in the file). 

