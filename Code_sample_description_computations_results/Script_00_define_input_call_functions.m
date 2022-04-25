
%%% Script to define all input-variables and call functions:

tic

clear all; clc

Path_2_single_big_tables = '/data/project/transgender_replication/data/Code_Create_analysis_input_LW/01_big_tables';

Path_2_big_tables = '/data/project/transgender_replication/data/Code_Create_analysis_input_LW/05_combined_matched_tables_ttests_txt_3mm_GMV_extraction';

Path_2_analysis_input = '/data/project/transgender_replication/data/Code_Create_analysis_input_LW/08_analysis_input';        

Path_2_model_input_trans_Aachen = '/data/project/transgender_replication/data/Code_Create_transgender_input_Aachen_LW/04_model_input';

Path_2_model_input_trans_Barcelona = '/data/project/transgender_replication/data/Code_Create_transgender_input_Barcelona_LW/04_model_input';


Path_2_result_txt_files = '/data/project/transgender_replication/code/transgender_machine_learning/derivatives/predictions';

Path_2_overview_tables_test_samples = '/data/project/transgender_replication/data/Code_Create_analysis_input_LW/08_analysis_input';

Path_2_overview_table_trans_Aachen = '/data/project/transgender_replication/data/Code_Create_transgender_input_Aachen_LW/04_model_input/model_input_overview_table.mat';

Path_2_overview_table_trans_Barcelona = '/data/project/transgender_replication/data/Code_Create_transgender_input_Barcelona_LW/04_model_input/model_input_overview_table.mat';

Path_2_merged_tables = '/data/project/transgender_replication/Code_sample_description_results_computations_LW_calibrated_predictions/03_merged_results_overview_tables';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function_01_compute_sample_allocations(Path_2_single_big_tables, Path_2_big_tables,Path_2_analysis_input)

function_02_compute_demographic_variables_ttests_big_tables(Path_2_big_tables, Path_2_analysis_input, Path_2_model_input_trans_Aachen, Path_2_model_input_trans_Barcelona)

function_03_merge_results_overview_tables(Path_2_result_txt_files, Path_2_overview_tables_test_samples, Path_2_overview_table_trans_Aachen, Path_2_overview_table_trans_Barcelona)

function_04_classification_report(Path_2_merged_tables)

function_05_compute_predicted_labels_appl_samples(Path_2_merged_tables)

function_06_violinplots_probabilities_appl_samples(Path_2_merged_tables)

function_07_violinplots_probabilities_test_samples(Path_2_merged_tables)

function_08_violinplots_TIV_classified_subjects(Path_2_merged_tables)

function_09_wilcoxon_tests_TIV_classified_subjects(Path_2_merged_tables)

close all

toc

