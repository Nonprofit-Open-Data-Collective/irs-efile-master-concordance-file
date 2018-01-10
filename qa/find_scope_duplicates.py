"""
This looks for instances where the same variable_name appears in the same scope in the same version.
Scope here means the way that dictionary keys are generated: [variable_name] + [scope] + [location]
where those values come directly from the master_concordance_file, except location, which is the second element of location_code split on '-'
If two expaths to the same variable occur are (erroneosly) listed in the same version, this will appear to be a problem, but it's likely not a "real" problem because only one variant appears in a version.

This situation legitimately occurs in some circumstances, including:
 - There's an amount in a few named categories, and then the same amount in an 'other' category. Those these have different expaths and occur in the same spot, they should both get mapped to the same variable.
"""

import csv

MASTER_CONCORDANCE = 'efiler_master_concordance.csv'
#MASTER_CONCORDANCE = 'efiler_master_concordance_altered.csv'
OUTFILE = 'qa/prob_vars.csv'

NOT_ERRORS = ['F9_03_PZ_PGMSVCACTIVITY', 'F9_03_PC_PGMSVCEXPENSES', 'F9_03_PZ_PGMSVCGRANTS', 'F9_03_PC_PGMSVCREVENUE', 'F9_09_PC_OTHEREXPFR', 'F9_09_PC_OTHEREXPMAG', 'F9_09_PC_OTHEREXPPSE', 'F9_09_PC_OTHEREXPTE', 'F9_09_PC_BENEFITSPAIDTE']
IGNORABLE_FOR_NOW = ['F9_03_EZ_TOTREV','AF_13_PF_ELECTIONLECT','AF_13_PF_ELECTIDESCES']

def ignorable_key(key):
    if key in NOT_ERRORS or key in IGNORABLE_FOR_NOW:
        return True
    return False

if __name__ == '__main__':
    error_hash = {}

    def verify_xpaths(xpath_dict_list, writer):
        versions = {}
        count = 0
        for vardictdata in xpath_dict_list:
            this_version_list = vardictdata['version'].split(';')
            for version in this_version_list:
                version = version.replace(' ', '')
                if version and version != 'NA' and (version.startswith('2009') or version.startswith('2010') or version.startswith('2011') 
                    or version.startswith('2012') or version.startswith('2013') or version.startswith('2014') or version.startswith('2015')
                    or version.startswith('2016') ):
                    try:
                        versions[version]
                        try:
                            error_hash[vardictdata['variable_name']] = error_hash[vardictdata['variable_name']] + 1
                            # don't print errors again 
                        except KeyError:
                            if not ignorable_key(vardictdata['variable_name']):
                                print("Potential dupe found %s  v: %s - %s - %s" % (vardictdata['variable_name'], version, vardictdata['location'], vardictdata['xpath']))
                                error_hash[vardictdata['variable_name']] = 1
                                writer.writerow({'varname':vardictdata['variable_name']})
                                count += 1
                    except KeyError:
                        versions[version] = vardictdata
        return count

    concordancefile = csv.DictReader(open(MASTER_CONCORDANCE, 'r'))
    name_hash = {}

    fields = ['varname']
    writer = csv.DictWriter(
        open(OUTFILE,'w'),  # 'wb' < 3?
        fieldnames=fields,
        delimiter=',',
        quotechar='"',
        lineterminator='\n',
        quoting=csv.QUOTE_MINIMAL
    )
    writer.writeheader()
    for row in concordancefile:
        locationbits = row['location_code'].split('-')
        location = None
        if locationbits:
            location = locationbits[1]

        key = row['variable_name'] + '__' + row['scope'] + '__' + location
        row['location'] = location
        try:
            name_hash[key].append(row)
        except KeyError:
            name_hash[key] = [row]
    error_count = 0
    for i, key in enumerate(name_hash.keys()):
        num_xpaths = len(name_hash[key])
        #print key, num_xpaths

        if num_xpaths > 1:
            error_count += verify_xpaths(name_hash[key], writer)
        

    print ("Total possible dupes %s" % (error_count))
