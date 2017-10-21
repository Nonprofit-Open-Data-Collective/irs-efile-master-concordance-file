## Quality Assurance - Master Concordance File

Different spreadsheet programs output .csv files in slightly different flavors. Excel on Mac, for intance, uses \r\n to end lines instead of just \n. In order to make sure that the file diffs are readable, we're trying to standardize the output of these files before committing. 

As always, the best solution is to *not use spreadsheet programs* to modify the file, but since we're likely to have this problem eventually,  the standard we're using is python's [QUOTE_MINIMAL](https://docs.python.org/3/library/csv.html#csv.QUOTE_MINIMAL) as implemented by csvkit's [csvformat](http://csvkit.readthedocs.io/en/1.0.2/scripts/csvformat.html). (csvformat also enforces no white space at the start of a field). 

- The text should be utf8 (which includes all the regular ascii stuff) Latin1 specific characters (which spreadsheet programs love to add) is not (which means no curly quotes, etc). 
- fields delimited by a comma
- double quotes around every field
- unix line endings: lines delimited by \n only.
- Quote minimal means a quote is only used if needed, e.g. for a text field with a comma or double-quote in it. Double quotes are replaced with double double quotes on "interior" usage. 


In python this is like writing to the file as:

	import csv
	FIELDNAMES = [
    'variable_name', 'description', 'scope', 'location_code', 'form', 'part',
    'data_type', 'required', 'cardinality', 'rdb_table', 'xpath', 'version',
    'production_rule', 'last_version_modified'
	]
	outfile = open("modified_concordance.csv", 'wb')
	writer = csv.DictWriter(
        outfile,
        fieldnames=FIELDNAMES,
        delimiter=',',
        quotechar='"',
        lineterminator='\n',
        quoting=csv.QUOTE_MINIMAL
    )
    
    
## Unendorsed workflow

If a spreadsheet has been used to modify the concordance file, save it (or export it to csv) with a different filename so as not to overwrite the original (if you do overwrite the original, move the altered file to a new destination and get the original back with 'git checkout efiler_master_concordance.csv').

Assuming the file has been exported from a spreadsheet program as efiler_master_concordance_modified run [csvformat](http://csvkit.readthedocs.io/en/1.0.2/scripts/csvformat.html) available from the csvkit project with these arguments 

	$ csvformat -U 0 efiler_master_concordance_modified > efiler_master_concordance_modified_fixed.csv

Then check if the file diff is useful by running 
	
	$ diff efiler_master_concordance.csv efiler_master_concordance_modified_fixed.csv

If the output is every line in the file, something's gone wrong (unless you actually changed every line in the file). 

It's anticipated that using spreadsheets will cause problems. Please record the specific software version of the one that you are using, as well as your operating system, when reporting problems.

## Other issues

The same approach should work for csv output created programatically with slightly different output settings as well. 