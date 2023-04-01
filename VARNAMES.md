## Variable Naming Conventions

For clarity and ease of use variable names all follow consistent conventions: 

**F9_01_REV_CONTR_GRANTS_PY**

* First two characters: Form (F9) or Schedule (SA, SB, etc.)
* Second two characters: Part of the form or schedule (01, 02, etc.) 
* Remaining string: variable names 

**Natural Variable Groups**

When naming variables we lead with the noun and follow with the adjective or qualifier. This helps to naturally group variables. For example, if you sort the variable names then all of the revenue categories will appear together if they are named *revenue_contracts* & *revenue_grants* versus *contract_revenue* & *grants_revenue*. 

Prefixes are omitted in these examples for simplicity:

Bad: 
* grants
* net_fundraisers
* rent

Good:
* rev_grants
* rev_fundraisers_net
* rev_rent

OK: 
* street
* city
* zip

Better:
* addr_street
* addr_city
* addr_zip

**Binary Variables**

All checkboxes on the form or the questions that have a YES/NO or TRUE/FALSE nature end with an X to make them easily identifiable. 

F9_07_COMP_DTK_POS_KEY_EMPL_X


## Abbreviations

Lots of statistical software packages limit variable name length to 32 characters. 

For consistency, we have used the following abbreviations when formulating variable names. 

Updates are available in this [google spreadsheet](https://docs.google.com/spreadsheets/d/1TDIR3cUm2vXMpKjU5rz4QZ1aucMy9udfjFpKCT8NSUU/edit#gid=0).


|Abbreviation  |Term                                     |
|:-------------|:----------------------------------------|
|ACC           |Accounting                               |
|ACT           |Activity                                 |
|AD            |Advertising                              |
|ADDR          |Address                                  |
|ADJ           |Adjusted, Adjustment                     |
|ADM           |Admission                                |
|ADMIN         |Administrative                           |
|ADV           |Advised                                  |
|AFFIL         |Affiliate                                |
|AFS           |Audited Financial Statements             |
|ALLOC         |Allocation                               |
|AMT           |Amount                                   |
|APPROV        |Approval                                 |
|ARB           |Arbitrage                                |
|ASSESS        |Assessment                               |
|ASSOC         |Association                              |
|AUTH          |Authorize                                |
|AVBL          |Available                                |
|AVE           |Average                                  |
|BEG           |Beginning                                |
|BEN           |Benefit                                  |
|BIZ           |Business                                 |
|BLDG          |Building                                 |
|BOY           |Beginning of Year                        |
|BV            |Book Value                               |
|CAMP          |Campaign                                 |
|CAP           |Capital                                  |
|CE            |Controlled Entity                        |
|CHARIT        |Charitable                               |
|CHPTR         |Chapter                                  |
|CNTR          |Country                                  |
|COI           |Conflict of Interest                     |
|COLLEC        |Collection                               |
|COM           |Community                                |
|COMP          |Compensation                             |
|COND          |Condition                                |
|CONSERV       |Conservation                             |
|CONSOL        |Consolidated                             |
|CONTIN        |Continuation                             |
|CONTR         |Contribution                             |
|CORP          |Corporation                              |
|COUNS         |Counsel                                  |
|CTRL          |Control, Controlling                     |
|CURR          |Current                                  |
|CY            |Current Year                             |
|DAF           |Donor Advised Funds                      |
|DBA           |Doing Business As                        |
|DCNT          |Discounted                               |
|DEPREC        |Depreciation                             |
|DESC          |Description                              |
|DETERMIN      |Determination                            |
|DIR           |Director                                 |
|DISBMT        |Disbursement                             |
|DISC          |Discuss                                  |
|DISCR         |Discriminatory, Discriminate             |
|DISREG        |Disregarded                              |
|DIST          |Distributable, Distribution              |
|DMCL          |Domicile                                 |
|DMSTC         |Domestic                                 |
|DOA           |Disposition Of Assets                    |
|DOC           |Document                                 |
|DSQ           |Disqualified                             |
|DTK           |Directors, Trustees, Key Employees       |
|EMPL          |Employed, Employee                       |
|EMT           |Easements                                |
|END           |Ending                                   |
|ENDOW         |Endowment                                |
|ENTMT         |Entertainment                            |
|EOY           |End of year                              |
|EQUIP         |Equipment                                |
|EVNT          |Event                                    |
|EXCL          |Exclusion                                |
|EXP           |Expenses                                 |
|EXPEND        |Expenditures                             |
|FA            |Financial Assistance                     |
|FAM           |Family                                   |
|FAP           |Financial Assistance Policy              |
|FIN           |Financial, Financing                     |
|FINSTAT       |Financial Statement                      |
|FMV           |Fair Market Value                        |
|FRGN          |Foreign                                  |
|FUNC, NONFUNC |Functionally, Non-Functionally           |
|FUNDR         |Fundraising                              |
|GAINLOSS      |Gain or (Loss)                           |
|GOVT          |Goverment                                |
|GRASS         |Grassroots                               |
|GRK           |Gaming Records Keeper                    |
|GRO           |Gross                                    |
|GVRN          |Governance, Governing                    |
|HCE           |Highest                                  |
|HIST          |History, Historical                      |
|INCL          |Include                                  |
|IND           |Independent                              |
|INDIV         |Individuals                              |
|INFO          |Information                              |
|INT           |Interested, Interest                     |
|INV           |Inventory                                |
|INVEST        |Investment                               |
|IP            |Intellectual Property                    |
|JV            |Joint Venture                            |
|KONTR         |Contract, Contractor                     |
|L1, L2        |Line 1, Line 2                           |
|LEGIS         |Legislator, Legislation                  |
|LIAB          |Liabilities                              |
|LIC           |Licensed                                 |
|LOB           |Lobbying                                 |
|LT            |Less Than                                |
|LTD           |Liquidation, Termination, or Dissolution |
|M, M1         |Minus, Minus 1                           |
|MAINT         |Maintain                                 |
|MEMB          |Member                                   |
|MGMT          |Management                               |
|MGR           |Managers                                 |
|MISC          |Miscellaneous                            |
|MOV           |Method of valuation                      |
|MT            |More Than                                |
|MTG           |Mortgage                                 |
|NA            |Not Applicable                           |
|NAFB          |Net Assets Or Fund Balances              |
|NONCSH        |Noncash                                  |
|NONDEDUCT     |Nondeductible                            |
|NUGAINS       |Net unrealized gains                     |
|NUM           |Number                                   |
|NY            |Next Year                                |
|OFF           |Officer                                  |
|ORG           |Organization                             |
|OTH           |Other                                    |
|P1, P2        |Part I, Part II                          |
|PCSTAT        |Public Charity Status                    |
|PCT           |Percentage                               |
|PERS          |Person                                   |
|POF           |Private Operating Foundation             |
|POLI          |Political                                |
|PREDMNT       |Predominant                              |
|PREP          |Preparer                                 |
|PRIN          |Principal                                |
|PROC          |Procedure                                |
|PROF          |Professional                             |
|PROG          |Program                                  |
|PROMO         |Promotion                                |
|PROP          |Property                                 |
|PROV          |Provider                                 |
|PTAB          |Pull Tab                                 |
|PTR           |Partnership                              |
|PTST          |Prohibited Tax Shelter Transaction       |
|PUB           |Public                                   |
|PY            |Prior Year                               |
|QUAL          |Qualifying                               |
|RCPT          |Receipts                                 |
|RE            |Real estate                              |
|REC           |Receives                                 |
|RECIP         |Recipient                                |
|RECO          |Reconciliation                           |
|RECVB         |Receivables                              |
|REP           |Report                                   |
|REQ           |Required, Requirement                    |
|REV           |Revenue                                  |
|RLTD          |Related                                  |
|RSRCH         |Research                                 |
|SAL           |Salaries                                 |
|SBST          |Substantial                              |
|SEC           |Securities                               |
|SEP           |Separate                                 |
|SIGNTR        |Signature                                |
|SOL           |Solicitation                             |
|STAT          |Status                                   |
|STCKHLDR      |Stockholder                              |
|STMT          |Statement                                |
|STR           |Structure                                |
|SUBJ          |Siubject                                 |
|SUBORD        |Subordinate                              |
|SVC           |Service                                  |
|T1, T2        |Type I, Type II                          |
|TOT           |Total                                    |
|TRANSAC       |Transaction                              |
|UBIZ          |Unrelated business                       |
|UNRLTD        |Unrelated                                |
|US            |United States                            |
|VOL           |Volunteer                                |
|ZIP           |Postal Code (FOREIGN)                    |
|ZIP           |ZIP Code (US)                            |
