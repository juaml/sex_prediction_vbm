
* Script_00_define_input_call_functions defines the respective relevant data paths and starts all functions after one another

* function_01: created big_table as overview of demographic data and measures of brain data (GMV, TIV etc.)

* function_02: Create txt-file for getting cat-data in a 3mm resolution and defining the Paths to the niftis in table to the newly created niftis
How to create niftis with 3mm resolution in Terminal:
Chmod +x get_cat_data_3mm.sh (adjust path if necessary)
./get_cat_data_3mm.sh big_table_Aachen_transgender_data

* function_03: extraction of GMV-data

* function_04: creation of vectors, matrices and overview table for model input
