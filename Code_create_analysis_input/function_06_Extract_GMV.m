
% function to start extraction of grey matter volumes:

function function_06_Extract_GMV(Path_2_combined_tables, Path_2_glob_mask)

%%% create new directory to save the variables:
if ~exist('06_extract_GMV', 'dir')
    mkdir('06_extract_GMV')
end

savedir = fullfile(pwd, '06_extract_GMV');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define input for further script to extract GMV of age-TIV-matched table:
tbpath = Path_2_combined_tables;
tb = 'big_table_age_TIV_matched_3mm_paths.mat';
outf = 'age_TIV_matched_big_table_GMV_v4';
glob_mask_path = Path_2_glob_mask;
glob_mask_str = 'MNI152_T1_3mm_brain.nii';

subfunction_06_01_Read_GM_sample_jl_v4_mat_input_TIV(savedir, tbpath,tb,outf,glob_mask_path, glob_mask_str)


% define input for further script to extract GMV of age-matched table:
tbpath = Path_2_combined_tables;
tb = 'big_table_age_matched_3mm_paths.mat';
outf = 'age_matched_big_table_GMV_v4';
glob_mask_path = Path_2_glob_mask;
glob_mask_str = 'MNI152_T1_3mm_brain.nii';

subfunction_06_01_Read_GM_sample_jl_v4_mat_input_TIV(savedir, tbpath,tb,outf,glob_mask_path, glob_mask_str)
