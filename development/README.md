## Input Files and Development Scripts

This folder contains the input steps and scripts used to generate the concordance. 

The first files are from the July 2017 Datathon in DC:

* **master_xpath_file_from_datathon.csv** - D.B. used schemas to generate the initial list of xpaths and associated meta-data, which he documented at: https://github.com/CharityNavigator/990_metadata  
* **concordance_final_from_datathon_july.csv** - Participants at the datathon reconciled approximately 1,500 xpaths 
* **ReconciledDuplicates.csv** - Unique clean cases used to replace duplicated xpath rows from the participant work  

Miguel took the torch and finished documenting the remaining cases in August, 2017.

* **Concordance_August_9_2017_Miguel_Barbosa.csv** - File with Miguel's work

These files were combined in October, 2017 with the script **MCF_Production_Script_v2.R**.

Dubious cases were identified by Jacob and documented in the file **jacobs_problem_children.txt**.

Pre-release fixes have been documented in the file ... 
