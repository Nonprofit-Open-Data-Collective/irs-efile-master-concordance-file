"""
Reads the concordance file and writes it back out in the project's "standard" csv format
https://github.com/Nonprofit-Open-Data-Collective/irs-efile-master-concordance-file/tree/master/qa
Also removes "NA". Historically these had been included, though should be gone by now. 

Writes to efiler_master_concordance_reformatted.csv -- check the output is good before overwriting
"""


import csv

INFILE = '../efiler_master_concordance.csv'
OUTFILE = '../efiler_master_concordance_reformatted.csv'  

FIELDNAMES = [
    'variable_name', 'description', 'scope', 'location_code', 'form', 'part',
    'data_type', 'required', 'cardinality', 'rdb_table', 'xpath', 'version',
    'production_rule', 'last_version_modified'
]

def get_ndc_writer(outfilename):
    outfile = open(outfilename, 'wb')
    writer = csv.DictWriter(
        outfile,
        fieldnames=FIELDNAMES,
        delimiter=',',
        quotechar='"',
        lineterminator='\n',
        quoting=csv.QUOTE_MINIMAL
    )
    writer.writeheader()
    return writer


def clean_value(value):
    if value=='NA':  # Throw out NA's
        return ''
    return value

def fix_row(rowdict):
    for key in rowdict.keys():
        rowdict[key] = clean_value(rowdict[key])
    return rowdict

if __name__ == '__main__':

    writer = get_ndc_writer(OUTFILE)

    infile = open(INFILE, 'r')
    reader = csv.DictReader(infile)
    for row in reader:
        result = fix_row(row)
        writer.writerow(result)

