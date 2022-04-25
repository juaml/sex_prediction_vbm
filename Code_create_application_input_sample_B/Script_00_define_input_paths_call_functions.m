

%%% Script to define all paths used as input and calling further
%%% scripts/functions:

tic

clear all; clc

Path_2_table = '/data/project/transgender_replication/data/Barcelona_transgender_data/descriptives.txt';    

Path_2_cat_data = '/data/project/transgender_replication/data/Barcelona_transgender_data/cat12.5/';

Path_2_big_table = '/data/project/transgender_replication/data/Code_Create_transgender_input_Barcelona_LW/01_big_table';

Path_2_table_3mm_paths = '/data/project/transgender_replication/data/Code_Create_transgender_input_Barcelona_LW/02_big_table_3mm_paths';

Path_2_glob_mask = '/data/project/transgender_replication/data/mask/';

Path_2_extracted_GMV = '/data/project/transgender_replication/data/Code_Create_transgender_input_Barcelona_LW/03_extract_GMV/Barcelona_transgender_data_big_table_GMV_v4raw.mat';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function_01_create_big_table(Path_2_table, Path_2_cat_data)

function_02_create_txt_Path_to_3mm_nii(Path_2_big_table)

function_03_extract_GMV(Path_2_table_3mm_paths, Path_2_glob_mask)

function_04_prepare_model_input(Path_2_extracted_GMV)


close all

toc