
function function_02_compute_demographic_variables_ttests_big_tables(Path_2_big_tables, Path_2_analysis_input, Path_2_model_input_trans_Aachen, Path_2_model_input_trans_Barcelona)

%%% create new directory to save the variables:
if ~exist('02_demographics_ttests_big_tables_train_test_trans_data', 'dir')
    mkdir('02_demographics_ttests_big_tables_train_test_trans_data')
end

savedir = fullfile(pwd, '02_demographics_ttests_big_tables_train_test_trans_data');
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% computation of demographic variables and ttests for big_tables (cisgender samples):

%%% age-matched (AM):
load(fullfile(Path_2_big_tables, 'big_table_age_matched_3mm_paths.mat'));
dataname = 'AM';
plotname = 'AM sample';
subfunction_02_01_compute_demographic_variables_cisgender(big_table, dataname, plotname, savedir)
clear big_table dataname

%%% age-matched (ATM):
load(fullfile(Path_2_big_tables, 'big_table_age_TIV_matched_3mm_paths.mat'));
dataname = 'ATM';
plotname = 'ATM sample';
subfunction_02_01_compute_demographic_variables_cisgender(big_table, dataname, plotname, savedir)
clear big_table dataname

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% computation of demographic variables and ttests for transgender samples:

% aachen transgender table:
load(fullfile(Path_2_model_input_trans_Aachen, 'model_input_overview_table.mat'))
big_table = analysis_input_table;
dataname = 'aachen_transgender';
plotname = 'Sample A';
subfunction_02_02_compute_demographic_variables_transgender(analysis_input_table, dataname, plotname, savedir)
clear big_table dataname analysis_input_table

% barcelona transgender table:
load(fullfile(Path_2_model_input_trans_Barcelona, 'model_input_overview_table.mat'))
big_table = analysis_input_table;
dataname = 'barcelona_transgender';
plotname = 'Sample B';
subfunction_02_02_compute_demographic_variables_transgender(analysis_input_table, dataname, plotname, savedir)
clear big_table dataname analysis_input_table

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% compute demographic variables separately for the training- and validation
% samples:

% AM train:
load(fullfile(Path_2_analysis_input, 'age_matched_train_sample_80per_overview_table.mat'))
big_table = analysis_input_table;
dataname = 'AM_train';
plotname = 'age matched sample trainings sample';
subfunction_02_01_compute_demographic_variables_cisgender(big_table, dataname, plotname, savedir)
clear big_table dataname analysis_input_table

% AM test:
load(fullfile(Path_2_analysis_input, 'age_matched_test_sample_20_per_overview_table.mat'))
big_table = analysis_input_table;
dataname = 'AM_test';
plotname = 'age matched sample test sample';
subfunction_02_01_compute_demographic_variables_cisgender(big_table, dataname, plotname, savedir)
clear big_table dataname analysis_input_table


% ATM train:
load(fullfile(Path_2_analysis_input, 'age_TIV_matched_train_sample_80per_overview_table.mat'))
big_table = analysis_input_table;
dataname = 'ATM_train';
plotname = 'age TIV matched sample trainings sample';
subfunction_02_01_compute_demographic_variables_cisgender(big_table, dataname, plotname, savedir)
clear big_table dataname analysis_input_table

% ATM test:
load(fullfile(Path_2_analysis_input, 'age_TIV_matched_test_sample_20_per_overview_table.mat'))
big_table = analysis_input_table;
dataname = 'ATM_test';
plotname = 'age TIV matched sample test sample';
subfunction_02_01_compute_demographic_variables_cisgender(big_table, dataname, plotname, savedir)
clear big_table dataname analysis_input_table



