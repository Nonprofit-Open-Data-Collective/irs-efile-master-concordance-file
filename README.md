# IRS Efile Master Concordance File

The Master Concordance File, available in CSV version in this repository, defines standards and provides documentation necessary to build structured databases from the IRS E-File XML files posted on AWS.

The IRS [released the 990 e-file data as XML documents](https://aws.amazon.com/public-datasets/irs-990/) in 2016 with little documentation. The MCF provides standards and conventions to assist the work of programmers that wish to utlize the data.

The MCF is meant to serve as a rosetta stone of sorts, allowing programmers to convert XML documents into a structured database by mapping 10,000 unique xpaths onto a data dictionary.

Follow the [MCF DOCUMENTATION](https://nonprofit-open-data-collective.github.io/irs-efile-master-concordance-file/) link for an overview of informaton contained within the Master Concordance File.


## DATA DICTIONARY 

The [efiler_master_concordance.csv](efiler_master_concordance.csv) included in this repository consists of the following variables:

* **VARIABLE_NAME** - Name of research database variable
* **DESCRIPTION** - Definition of the variable, derived from 990 forms
* **SCOPE** - Filers to which the variable pertains (small charities, large charities, all charities, foundations)
* **LOCATION_CODE** - The location of a field (form, part, and line) on the 2016 paper version of forms and schedules
* **FORM** - Form on which the field occurs - 990, 990EZ, 990PF, Schedule A - Schedule R
* **PART** - Location of the field on the form
* **RDB_TABLE** - Tables for organizing the data into a relational database
* **PRODUCTION_RULE** - Rules which should be applied to the raw data after extraction to ensure it is meaningful
* **XPATH** - XML address for the data
* **VERSION** - The XSD schema version that the xpath belongs to
* **REQUIRED** - Indicates whether nonprofit filers are required to complete this field
* **NOTES** - Additional notes about variables from programmers and users

A more in-depth description of each variable is available [HERE](https://nonprofit-open-data-collective.github.io/irs-efile-master-concordance-file/).


