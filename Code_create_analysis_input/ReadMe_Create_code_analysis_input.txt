-> Scripts and functions to create age-matched and age-TIV-matched tables splitted into 80% training- and 20% test-data for the structural sex classification analysis
-> each functions creates an own folder with the results computed in this function with the respective number of the function
-> for the first run, start only until function 05, extract GMV-values as written in the other ReadMe and then continue with function 06

* Script_00_define_input_call_functions defines the respective relevant data paths and starts all functions after one another

* function_01: iterating through the defined datasets and subfunction_01_01 creating a table with information about Sample/Site, Subject-ID, Session, age, sex, Patient-Status (and past Patient-status), Path to nifti, value of grey matter in the brain (GMV) and value of total intracranial volume (TIV);
Only subjects that are older than 18, younger than 65 and no patients are saved in the results-table
(Subjects from the HCP-dataset are automatically classified with a Patient-status = 0, since the subjects from the 1200 release are all healthy)

* function_02: combination of all tables from the folder 01 to compute descriptive variables of TIV of all relevant subjects

* function_03: from all Sample/Sites subjects are excluded having an TIV-value higher or lower than 3 std from the general mean

* function_04: Matching within Sample/Site so that each female has a male counterpart with max. 1 year age difference in age-matching (AM) and in age-TIV-matching (ATM) max. 1 year difference and max. 3% difference in TIV.
ATM: no sign. Difference in age and TIV between males and females per Sample/Site
AM: no sign. Difference in age between males and females but in TIV 
Afterwards the age-distribution between age-matched and age-TIV-matched tables are adjusted per Sample/Site so that there is no sign. Difference in age exists between these samples (Adjustment either works by splitting the sample into different steps in age, quartiles, percentiles or splitting the age with the median).

* function_05: combining all matched tables per Sample/Site to one big table for AM and ATM, ensure ratios with tests, create a txt-file with the data paths to the niftis for GMV-extraction and afterwards rename the tables to the new directory of the niftis with 3mm-resolution

*function_06: extraction of grey matter volumes for the whole brain for AM and ATM

* function_07: splitting ATM into quartiles for age and TIV and iterate through all of these quartiles selecting one subject until the N of 20% is reached: The same procedure for AM with quartiles only for age. Ttests are performed afterwards to ensure similar rations between trainings- and test-samples.

* function_08: preparing analysis-input by providing per trainings- and test-sample per AM and ATM vectors of age, sex, TIV and a matrix of GMV with a table containing all further information.

