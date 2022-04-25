

%%% Script to define all paths used as input and calling further
%%% scripts/functions:

tic

clear all; clc

Path_2_cat12 = '/data/project/cat_12.5/';

Path_2_lookups = '/data/project/transgender_replication/data/all_lookups_raw_data/';

Path_2_raw_big_tables = '/data/project/transgender_replication/data/Code_Create_analysis_input_LW/01_big_tables/';

Path_2_clean_big_tables = '/data/project/transgender_replication/data/Code_Create_analysis_input_LW/03_big_tables_TIV_outlier_excluded';

Path_2_matched_tables = '/data/project/transgender_replication/data/Code_Create_analysis_input_LW/04_within_sample_site_matched_tables';

Path_2_combined_tables = '/data/project/transgender_replication/data/Code_Create_analysis_input_LW/05_combined_matched_tables_ttests_txt_3mm_GMV_extraction';

Path_2_glob_mask = '/data/project/transgender_replication/data/mask/';

Path_2_extracted_GMV = '/data/project/transgender_replication/data/Code_Create_analysis_input_LW/06_extract_GMV';

Path_2_splitted_tables = '/data/project/transgender_replication/data/Code_Create_analysis_input_LW/07_train_test_set_split';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define inclusion critaria for age: 
min_age = 18; % subjects younger than this value are excluded
max_age = 66; % subjects equal or older this value are excluded

function_01_create_big_tables_define_input_per_dataset(Path_2_cat12, Path_2_lookups, min_age, max_age)

function_02_plot_TIV_all_subjects(Path_2_raw_big_tables)

function_03_big_tables_exclude_TIV_outlier(Path_2_raw_big_tables)

% define matching criteria:
max_age_diff = 1;     %%% max difference in age for each male-female-match
max_TIV_diff = 0.03;  %%% max difference in TIV for each male-female-match

function_04_prepare_matching(Path_2_clean_big_tables, max_age_diff, max_TIV_diff)

function_05_combine_matched_tables_ttests_3mm_paths_txt(Path_2_matched_tables)

function_06_Extract_GMV(Path_2_combined_tables, Path_2_glob_mask)

function_07_split_train_test_datasets(Path_2_combined_tables)

function_08_prepare_analysis_input(Path_2_extracted_GMV, Path_2_splitted_tables)

close all

toc