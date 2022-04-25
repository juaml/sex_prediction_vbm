-> Scripts and functions to compute detailed results after ML-analysis
-> each functions creates an own folder with the results computed in this function with the respective number of the function

* Script_00_define_input_call_functions defines the respective relevant data paths and starts all functions after one another

* function_01: compute allocation of each sample for sample/site of each subject

* function_02: computation of demographic variables

* function_03: results from ML-analysis are merged with overview tables to enable more detailed computations afterwards

* function_04: computation of classification report (accuracy, sensitivity etc.)

* function_05: separate accuracy computation for cisgender and transgender individuals in application samples

*function_06: Violinplots to plot the TIV-distribution of cisgender and transgender men and women in application samples that were either classified as male or female to trace back a possible TIV-bias in classifications

* function_07: Violinplots to plot the TIV-distribution of men and women in both test samples that were either classified as male or female to trace back a possible TIV-bias in classifications

* function_08: computation of wilcoxon rank tests to statistically prove a potential TIV-bias in classifications

