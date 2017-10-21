"""
This looks for instances where the same variable_name appears in the same scope in the same version.
If two expaths to the same variable occur are (erroneosly) listed in the same version, this will appear to be a problem, but it's likely not a "real" problem because only one variant appears in a version.
This was written to find "minus year" issues, where for some reason the prior N year values were given the same variable_name as current_values (or in some cases, two years ago has the same name as three years ago, as of 10/28/2017).
"""

import csv

MASTER_CONCORDANCE = '../efiler_master_concordance.csv'

error_hash = {}

def verify_xpaths(xpath_dict_list):
    versions = {}
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
                        error_hash[vardictdata['variable_name']]
                        # don't print errors again 
                    except KeyError:
                        print("Potential dupe found %s  v: %s - %s - %s" % (vardictdata['variable_name'], version, vardictdata['location'], vardictdata['xpath']))
                        return 1
                        error_hash[vardictdata['variable_name']] = 1
                except KeyError:
                    versions[version] = vardictdata
    return 0


if __name__ == '__main__':
    concordancefile = csv.DictReader(open(MASTER_CONCORDANCE, 'r'))
    name_hash = {}
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
            error_count += verify_xpaths(name_hash[key])

    print ("Total errors %s" % (error_count))
