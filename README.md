# IRS Efile Master Concordance File

The Master Concordance File, available in CSV version in this repository, defines standards and provides documentation necessary to build structured databases from the IRS E-File XML files posted on AWS.

The IRS released the [990 E-FILER DATA](https://aws.amazon.com/public-datasets/irs-990/) as XML documents in 2016 with little documentation. The Master Concordance File (MCF) provides standards and conventions to assist the work of programmers that wish to utlize the data.

The MCF is meant to serve as a rosetta stone of sorts, allowing programmers to convert XML documents into a structured database by mapping 10,000 unique xpaths onto a consistent and well-documented data dictionary.

We designed consistent standards for [variable naming conventions](00-documentation/VARNAMES.md) and [documentation](https://github.com/Nonprofit-Open-Data-Collective/irs-efile-master-concordance-file/blob/master/00-documentation/Instructions%20for%20Updating%20Concordance%20v3.2.pdf) to improve ease of use. 

The concordance organizes data into approximately 125 distinct tables that correspond with sections on the forms (approximately 80 one-to-one tables and 46 one-to-many tables).  

[DATA DICTIONARY](https://nonprofit-open-data-collective.github.io/irs990efile/data-dictionary/data-dictionary.html)

Also included here is an additional crosswalk for Part-01 of forms 990-EZ and the full 990. This section is somewhat distinct because many of the financial variables on Part-01 of the 990-EZ are not explicitly present on the full 990-PC, but they can be reconstructed (mostly) by creating composite variables by combining several fields.  

[FORM-990-EZ-PART-01-CROSSWALK.xlsx](https://github.com/Nonprofit-Open-Data-Collective/irs-efile-master-concordance-file/blob/master/FORM-990-EZ-PART-01-CROSSWALK-v1.xlsx)

Follow the [MASTER CONCORDANCE FILE DOCUMENTATION](https://nonprofit-open-data-collective.github.io/irs-efile-master-concordance-file/) link for an overview of informaton contained within the Master Concordance File.

--- 

## DATA DICTIONARY FOR MASTER CONCORDANCE FILE

Note that the official form names are the "full" 990 (required for all public charities), the 990-EZ (for small public charities), and the 990-PF (for private foundations). In the documentation we refer to the full 990 as the 990-PC for "public charity" (as opposed to the 990-PF for private foundations). That provides for additional consistency in formatting and prevents confusion about whether we mean the full or EZ version when referencing "form 990".  

The efiler [concordance.csv](concordance.csv) included in this repository consists of the following variables:

**VARIABLE DEFINITIONS**

* **variable_name** - Name of research database variable 
* **xpath** - XML address for the data 
* **description** - Definition of the variable, derived from 990 forms  
* **variable_scope** - Which forms contain the variable (full 990 only or 990+990EZ) 
* **data_type_xsd** - Data field type specified on XSD schema (number, character, address, date, currency, etc.) 
* **data_type_simple** - Data type in R (more limited set of types - numeric, character, logical)

**LOCATION OF THE FIELD ON THE 990 FORM** 

* **form** - Form 990 or schedule where the field is located
* **form_type** - Origin of the field - form 990 or 990EZ
* **form_part** - Section of the form or schedule (Part I, II, etc.) 
* **form_line_number** - Line number corresponding with the field 
* **location_code** - stylized and hierarchical 'address' of the field on the form created by concatenating the form, form_type, form_part, and form_line_number: F990-PC-PART-01-LINE-02
* **location_code_xsd** - The location information specified by the XSD schema file
* **location_code_family** - If a 990PC and 990EZ version exist, the family is corresponding the PC version so that family codes can be used to select all xpath versions together 

Note that location codes were designed so sorting by location codes in the spreadsheet will place variables in the same order as they appear on the full version of the 990-PC or schedules. 

Fields often appear in tables with letters indexing columns and line numbers indexing rows. In these cases location codes will sort from left to right, then top to bottom. 

```
F990-PC-PART-07-SECTION-B-LINE-01-COL-A
F990-PC-PART-07-SECTION-B-LINE-01-COL-C
F990-PC-PART-07-SECTION-B-LINE-01-COL-B
```

**TABLE INFO**

* **rdb_table** - Table names 
* **rdb_relationship** - Cardinality of the table (1-to-1 or 1-to-many)  



**XML SCHEMA INFO** (from XSD files)

* **versions** - All XSD schema versions that contain the xpath
* **latest_version** - The last version of the XSD that contained the xpath 
* **current_version** - Is this schema (xpath) the current version used? 
* **required** - Are filers required to answer the question (this field is currently incomplete) 


A more in-depth description of each variable is available [HERE](https://nonprofit-open-data-collective.github.io/irs-efile-master-concordance-file/).


# Open Data License

Open Data Commons Attribution License (ODC-By) v1.0

You are free:

- To share: To copy, distribute and use the database.
- To create: To produce works from the database.
- To adapt: To modify, transform and build upon the database.

As long as you:

Attribute: You must attribute any public use of the database, or works produced from the database, in the manner specified in the license. For any use or redistribution of the database, or works produced from it, you must make clear to others the license of the database and keep intact any notices on the original database.


## Form 990 Parts and Schedules

[F990 Parts and Schedules](https://github.com/Nonprofit-Open-Data-Collective/irs-efile-master-concordance-file/blob/master/f990-parts-and-schedules.md)

For a quick overview of how content is organized across the Form 990 and Schedules. For the most part each PART of the 990 or Schedule corresponds to a TABLE in the Concordance file. 




