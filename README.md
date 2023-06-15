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

The [efiler_master_concordance.csv](efiler_master_concordance.csv) included in this repository consists of the following variables:

**VARIABLE DEFINITIONS**

* **variable_name** - Name of research database variable 
* **xpath** - XML address for the data 
* **description** - Definition of the variable, derived from 990 forms  
* **variable_scope** - Which forms contain the variable (full 990 only or 990+990EZ) 
* **data_type_xsd** - Data field type specified on XSD schema (number, character, address, date, currency, etc.) 
* **data_type_simple** - Data type in R (more limited set of types)

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


---



# FORM 990 and SCHEDULE SECTIONS


*These groups are based upon the [2016 IRS 990 Forms and Schedules](https://github.com/Nonprofit-Open-Data-Collective/irs-efile-master-concordance-file/tree/master/990_forms).

### FORM 990-PC (FULL)

* Part I    - Summary  
* Part II   - Signature Block  
* Part III  - Statement of Program Service Accomplishments  
* Part IV   - Checklist of Required Schedules  
* Part V    - Statements Regarding Other IRS Filings and Tax Compliance  
* Part VI   - Governance, Management, and Disclosure  
    * Section A. Governing Body and Management  
    * Section B. Policies  
    * Section C. Disclosure  
* Part VII  - Compensation of Officers, Directors, Trustees, Key Employees, Highest Compensated Employees, and Independent Contractors  
    * Section A. Officers, Directors, Trustees, Key Employees, and Highest Compensated Employees  
    * Section B. Independent Contractors  
* Part VIII - Statement of Revenue  
* Part IX   - Statement of Functional Expenses  
* Part X    - Balance Sheet  
* Part XI   - Reconciliation of Net Assets  
* Part XII  - Financial Statements and Reporting  
 
  
### SCHEDULE A - PUBLIC CHARITY STATUS AND PUBLIC SUPPORT (PC AND EZ FILERS)

*Complete if the organization is a section 501(c)(3) organization or a section 4947(a)(1) nonexempt charitable trust.*

* Part I    - Reason for Public Charity Status
* Part II   - Support Schedule for Organizations Described in Sections 170(b)(1)(A)(iv) and 170(b)(1)(A)(vi)
** Section A. Public Support
** Section B. Total Support
** Section C. Computation of Public Support Percentage
* Part III  - Support Schedule for Organizations Described in Section 509(a)(2)
    * Section A. Public Support
    * Section B. Total Support
    * Section C. Computation of Public Support Percentage
    * Section D. Computation of Investment Income Percentage
* Part IV   - Supporting Organizations
    * Section A. All Supporting Organizations
    * Section B. Type I Supporting Organizations
    * Section C. Type II Supporting Organizations
    * Section D. All Type III Supporting Organizations
    * Section E. Type III Functionally Integrated Supporting Organizations
* Part V    - Type III Non-Functionally Integrated 509(a)(3) Supporting Organizations            
    * Section A - Adjusted Net Income
    * Section B - Minimum Asset Amount
    * Section C - Distributable Amount
    * Section D - Distributions
    * Section E - Distribution Allocations
* Part VI   - Supplemental Information (UNSTRUCTURED - CAN WE CODE THIS?)           



### SCHEDULE B - SCHEDULE OF CONTRIBUTORS (PC, EZ, AND PF FILERS)

* Header    - Type of Organization
* Part I    - Contributors
* Part II   - Noncash Property
* Part III  - Exclusively religious, charitable, contributions above $1,000



### SCHEDULE C - POLITICAL CAMPAIGN AND LOBBYING ACTIVITIES (PC AND EZ FILERS)

* Part I-A  - Complete if the organization is exempt under section 501(c) or is a section 527 organization.
* Part I-B  - Complete if the organization is exempt under section 501(c)(3)
* Part I-C  - Complete if the organization is exempt under section 501(c), except section 501(c)(3)
* Part II-A - Complete if the organization is exempt under section 501(c)(3) and filed Form 5768 (election under section 501(h))
* Part II-B - Complete if the organization is exempt under section 501(c)(3) and has NOT filed Form 5768 (election under section 501(h))
* Part IIIA - Complete if the organization is exempt under section 501(c)(4), section 501(c)(5), or section 501(c)(6)
* Part IIIB - Complete if the organization is exempt under section 501(c)(4), section 501(c)(5), or section 501(c)(6) and if either (a) BOTH Part III-A, lines 1 and 2, are answered “No,” OR (b) Part III-A, line 3, is answered “Yes.”
* Part IV   - Supplemental Information



### SCHEDULE D - SUPPLEMENTAL FINANCIAL STATEMENTS (PC FILERS ONLY)

*Complete if the organization answered “Yes” on Form 990, Part IV, line 6, 7, 8, 9, 10, 11a, 11b, 11c, 11d, 11e, 11f, 12a, or 12b.*

* Part I    - Organizations Maintaining Donor Advised Funds or Other Similar Funds or Accounts
* Part II   - Conservation Easements
* Part III  - Organizations Maintaining Collections of Art, Historical Treasures, or Other Similar Assets
* Part IV   - Escrow and Custodial Arrangements
* Part V    - Endowment Funds
* Part VI   - Land, Buildings, and Equipment
* Part VII  - Investments—Other Securities
* Part VIII - Investments—Program Related
* Part IX   - Other Assets
* Part X    - Other Liabilities
* Part XI   - Reconciliation of Revenue per Audited Financial Statements With Revenue per Return
* Part XII  - Reconciliation of Expenses per Audited Financial Statements With Expenses per Return
* Part XIII - Supplemental Information (UNSTRUCTURED)



### SCHEDULE E - SCHOOLS (PC AND EZ FILERS)

*Complete if the organization answered “Yes” on Form 990, Part IV, line 13, or Form 990-EZ, Part VI, line 48.*

* Part I    - General Info
* Part II   - Supplemental Information



### SCHEDULE F - STATEMENT OF ACTIVITIES OUTSIDE THE UNITED STATES (PC FILERS ONLY)

*Complete if the organization answered “Yes” on Form 990, Part IV, line 14b, 15, or 16.*

* Part I    - General Information on Activities Outside the United States
* Part II   - Grants and Other Assistance to Organizations or Entities Outside the United States
* Part III  - Grants and Other Assistance to Individuals Outside the United States
* Part IV   - Foreign Forms
* Part V    - Supplemental Information (UNSTRUCTURED)



### SCHEDULE G - SUPPLEMENTAL INFORMATION REGARDING FUNDRAISING OR GAMING ACTIVITIES (PC AND EZ FILERS)

*Complete if the organization answered “Yes” on Form 990, Part IV, line 17, 18, or 19, or if the organization entered more than $15,000 on Form 990-EZ, line 6a.*

* Part I    - Fundraising Activities
* Part II   - Fundraising Events
* Part III  - Gaming
* Part IV   - Supplemental Information (UNSTRUCTURED)



### SCHEDULE H - HOSPITALS (PC FILERS ONLY)

*Complete if the organization answered “Yes” on Form 990, Part IV, question 20.*

* Part I    - Financial Assistance and Certain Other Community Benefits at Cost
* Part II   - Community Building Activities
* Part III  - Bad Debt, Medicare, & Collection Practices
    * Section A. Bad Debt Expense
    * Section B. Medicare
    * Section C. Collection Practices
* Part IV   - Management Companies and Joint Ventures
* Part V    - Facility Information
    * Section A. Hospital Facilities
    * Section B. Facility Policies and Practices
        * Community Health Needs Assessment
        * Financial Assistance Policy (FAP)
        * Billing and Collections
        * Policy Relating to Emergency Medical Care
        * Charges to Individuals Eligible for Assistance Under the FAP (FAP-Eligible Individuals)
    * Section C. Supplemental Information for Part V, Section B
    * Section D. Other Health Care Facilities That Are Not Licensed, Registered, or Similarly Recognized as a Hospital Facility
* Part VI   - Supplemental Information





### SCHEDULE I - GRANTS AND OTHER ASSISTANCE TO ORGANIZATIONS, GOVERNMENTS, AND INDIVIDUALS IN THE UNITED STATES (PC FILERS ONLY)

*Complete if the organization answered “Yes” on Form 990, Part IV, line 21 or 22.*


* Part I    - General Information on Grants and Assistance
* Part II   - Grants and Other Assistance to Domestic Organizations and Domestic Governments
* Part III  - Grants and Other Assistance to Domestic Individuals.
* Part IV   - Supplemental Information


#### SCHEDULE I1 - Continuation Sheet for Schedule I (Form 990)

* Part I    - Continuation of Grants and Other Assistance to Governments and Organizations in the United States
* Part II   - Continuation of Grants and Other Assistance to Individuals in the United States


### SCHEDULE J - COMPENSATION INFORMATION (PC FILERS ONLY)

Complete if the organization answered “Yes” on Form 990, Part IV, line 23

* Part I    - Questions Regarding Compensation
* Part II   - Officers, Directors, Trustees, Key Employees, and Highest Compensated Employees
* Part III  - Supplemental Information


#### SCHEDULE J1 - CONTINUATION SHEET FOR SCHEDULE J

* Part I    - Continuation of Officers, Directors, Trustees, Key Employees, and Highest Compensated Employees

#### SCHEDULE J2 - CONTINUATION SHEET FOR FORM 990

*Attach to Form 990 to list additional information for Form 990, Part VII, Section A, line 1a.*

* Part I    - Continuation of Officers, Directors, Trustees, Key Employees, and Highest Compensated Employees



### SCHEDULE K - SUPPLEMENTAL INFORMATION ON TAX-EXEMPT BONDS (PC FILERS ONLY)

*Complete if the organization answered “Yes” on Form 990, Part IV, line 24a. Provide descriptions, explanations, and any additional information in Part VI.*

* Part I    - Bond Issues
* Part II   - Proceeds
* Part III  - Private Business Use
* Part IV   - Arbitrage
* Part V    - Procedures To Undertake Corrective Action
* Part VI   - Supplemental Information



### SCHEDULE L - TRANSACTIONS WITH INTERESTED PERSONS (PC AND EZ FILERS)

*Complete if the organization answered “Yes” on Form 990, Part IV, line 25a, 25b, 26, 27, 28a, 28b, or 28c, or Form 990-EZ, Part V, line 38a or 40b.*

* Part I    - Excess Benefit Transactions
* Part II   - Loans to and/or From Interested Persons
* Part III  - Grants or Assistance Benefiting Interested Persons
* Part IV   - Business Transactions Involving Interested Persons
* Part V    - Supplemental Information




### SCHEDULE M - NONCASH CONTRIBUTIONS (PC FILERS ONLY)

*Complete if the organizations answered “Yes” on Form 990, Part IV, lines 29 or 30.*

* Part I    - Types of Property
* Part II   - Supplemental Information




### SCHEDULE N - LIQUIDATION, TERMINATION, DISSOLUTION, OR SIGNIFICANT DISPOSITION OF ASSETS (PC AND EZ FILERS)

*Complete if the organization answered "Yes" on Form 990, Part IV, lines 31 or 32; or Form 990-EZ, line 36.*

* Part I    - Liquidation, Termination, or Dissolution
* Part II   - Sale, Exchange, Disposition, or Other Transfer of More Than 25% of the Organization’s Assets
* Part III  - Supplemental Information




### SCHEDULE O - SUPPLEMENTAL INFORMATION TO FORM 990 OR 990-EZ



### SCHEDULE R - RELATED ORGANIZATIONS AND UNRELATED PARTNERSHIPS (PC FILERS ONLY)

*Complete if the organization answered "Yes" on Form 990, Part IV, line 33, 34, 35b, 36, or 37.*

* Part I    - Identification of Disregarded Entities
* Part II   - Identification of Related Tax-Exempt Organizations
* Part III  - Identification of Related Organizations Taxable as a Partnership.
* Part IV   - Identification of Related Organizations Taxable as a Corporation or Trust
* Part V    - Transactions with Related Organizations
* Part VI   - Unrelated Organizations Taxable as a Partnership
* Part VII  - Supplemental Information
