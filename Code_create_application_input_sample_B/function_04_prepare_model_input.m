
function function_04_prepare_model_input(Path_2_extracted_GMV)

%%% create new directory to save the variables:
if ~exist('04_model_input', 'dir')
    mkdir('04_model_input')
end

savedir = fullfile(pwd, '04_model_input');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load(Path_2_extracted_GMV);

GMV = GLMFlags.dat{1,1};

Subject = GLMFlags.sub';

age = GLMFlags.Age';

sex_f1_m0 = GLMFlags.Female';

TIV = GLMFlags.TIV';


analysis_input_table = table();
load(fullfile('02_big_table_3mm_paths', 'big_table_Barcelona_transgender_data_3mm_paths.mat'));
analysis_input_table = big_table;
clear big_table


save(fullfile(savedir, ['model_input_age']), 'age')
save(fullfile(savedir, ['model_input_sex_f1_m0']), 'sex_f1_m0')
save(fullfile(savedir, ['model_input_TIV']), 'TIV')
save(fullfile(savedir, ['model_input_GMV']), 'GMV')
save(fullfile(savedir, ['model_input_overview_table']), 'analysis_input_table')
