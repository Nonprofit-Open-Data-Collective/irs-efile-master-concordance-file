## Quality Assurance 

The scripts in this directory represent attempts to programatically detect problems with the concordance file with "checksum"-like operations. 

### Scripts 
in this dir, i.e. in qa/:

find\_scope\_duplicates.py

Usage: from one directory up run:

	$ python -m qa.find_scope_duplicates
	
It will automatically output variables it sees as potential problems in qa/prob_vars.csv. Note that it is configured to ignore
[NOT\_ERRORS](https://github.com/jsfenfen/irs-efile-master-concordance-file/blob/master/qa/find_scope_duplicates.py#L13) and [IGNORABLE\_FOR\_NOW](https://github.com/jsfenfen/irs-efile-master-concordance-file/blob/master/qa/find_scope_duplicates.py#L14) --I've been manually adding things to this list when I find stuff that's not really a problem or ignorable for now (because it's not on a lettered schedule). 

__Approach__: This looks for instances where the same variable\_name appears in the same scope in the same version.
Scope here means the way that dictionary keys are generated: [variable\_name] + [scope] + [location]
where those values come directly from the master\_concordance\_file, except location, which is the second element of location_code split on '-'
If two expaths to the same variable occur are (erroneously) listed in the same version, this will appear to be a problem, but it's likely not a "real" problem because only one variant appears in a version.

This situation legitimately occurs in some circumstances, the most common of which is: There's an amount in a few named categories, and then the same amount in an 'other' category. Those these have different expaths and occur in the same spot, they should both get mapped to the same variable.


### Common fixes for common problems

An often-seen problem is that the same variable name will get used for two seemingly similar variables: one an __indicator__ variable, of boolean or checkbox type that an organization needs to check if appropriate, and then a related amount, that they fill in (presumably if checked). In these circumstances, I've generally been adding an 'I' to the boolean / checkbox / indicator variable.


### Master Concordance File Maintenance

In order to make file diffs useful, it's necessary to be somewhat picky about editing the csv.

Different spreadsheet programs output .csv files in slightly different flavors. Excel on Mac, for intance, uses \r\n to end lines instead of just \n. We're trying to standardize the output of these files before committing. 

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