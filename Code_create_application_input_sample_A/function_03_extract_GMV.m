
% function to extract GMV-values:

function function_03_extract_GMV(Path_2_table_3mm_paths, Path_2_glob_mask)

%%% create new directory to save the variables:
if ~exist(fullfile('03_extract_GMV'), 'dir')
    mkdir('03_extract_GMV')
end

savedir = fullfile(pwd, '03_extract_GMV');
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define input for further script to extract GMV of
% Aachen_transgender_table:
tbpath = Path_2_table_3mm_paths;
tb = 'big_table_Aachen_transgender_data_3mm_paths.mat'
outf = 'Aachen_transgender_data_big_table_GMV_v4';
glob_mask_path = Path_2_glob_mask;
glob_mask_str = 'MNI152_T1_3mm_brain.nii';

subfunction_03_01_Read_GM_sample_jl_v4_mat_input_TIV(savedir, tbpath,tb,outf,glob_mask_path, glob_mask_str)
