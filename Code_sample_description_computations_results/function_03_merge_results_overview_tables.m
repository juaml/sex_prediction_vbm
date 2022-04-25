
% function to merge prediction results and overview tables:

function function_03_merge_results_overview_tables(Path_2_result_txt_files, Path_2_overview_tables_test_samples, Path_2_overview_table_trans_Aachen, Path_2_overview_table_trans_Barcelona)

%%% create new directory to save the variables:
if ~exist('03_merged_results_overview_tables', 'dir')
    mkdir('03_merged_results_overview_tables')
end

savedir = fullfile(pwd, '03_merged_results_overview_tables');
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% merge test-result-files with overview tables:

%%% age-matched test sample:

load(fullfile(Path_2_overview_tables_test_samples, 'age_matched_test_sample_20_per_overview_table.mat'));

% trained on AM without confound:
dataname = 'val-age_calibrated_predictions_model_trained_on_confound-None_sample-age';
subfunction_03_01_merge_result_files_overview_tables(Path_2_result_txt_files, analysis_input_table, dataname, savedir)
clear dataname

% trained on AM with confound:
dataname = 'val-age_calibrated_predictions_model_trained_on_confound-TIV_sample-age';
subfunction_03_01_merge_result_files_overview_tables(Path_2_result_txt_files, analysis_input_table, dataname, savedir)
clear dataname

% trained on ATM without confound:
dataname = 'val-age_calibrated_predictions_model_trained_on_confound-None_sample-age_TIV';
subfunction_03_01_merge_result_files_overview_tables(Path_2_result_txt_files, analysis_input_table, dataname, savedir)
clear dataname

% trained on ATM with confound:
dataname = 'val-age_calibrated_predictions_model_trained_on_confound-TIV_sample-age_TIV';
subfunction_03_01_merge_result_files_overview_tables(Path_2_result_txt_files, analysis_input_table, dataname, savedir)
clear dataname

clear analysis_input_table
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% age-TIV-matched test sample:

load(fullfile(Path_2_overview_tables_test_samples, 'age_TIV_matched_test_sample_20_per_overview_table.mat'));

% trained on AM without confound removal:
dataname = 'val-ageTIV_calibrated_predictions_model_trained_on_confound-None_sample-age';
subfunction_03_01_merge_result_files_overview_tables(Path_2_result_txt_files, analysis_input_table, dataname, savedir)
clear dataname

% trained on AM with confound removal:
dataname = 'val-ageTIV_calibrated_predictions_model_trained_on_confound-TIV_sample-age';
subfunction_03_01_merge_result_files_overview_tables(Path_2_result_txt_files, analysis_input_table, dataname, savedir)
clear dataname

% trained on ATM without confound removal:
dataname = 'val-ageTIV_calibrated_predictions_model_trained_on_confound-None_sample-age_TIV';
subfunction_03_01_merge_result_files_overview_tables(Path_2_result_txt_files, analysis_input_table, dataname, savedir)
clear dataname

% trained on ATM with confound removal:
dataname = 'val-ageTIV_calibrated_predictions_model_trained_on_confound-TIV_sample-age_TIV';
subfunction_03_01_merge_result_files_overview_tables(Path_2_result_txt_files, analysis_input_table, dataname, savedir)
clear dataname

clear analysis_input_table
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% aachen transgender application sample:

load(Path_2_overview_table_trans_Aachen)

% trained on AM without confound removal:
dataname = 'aachen_calibrated_predictions_model_trained_on_confound-None_sample-age';
subfunction_03_01_merge_result_files_overview_tables(Path_2_result_txt_files, analysis_input_table, dataname, savedir)
clear dataname

% trained on AM with confound removal:
dataname = 'aachen_calibrated_predictions_model_trained_on_confound-TIV_sample-age';
subfunction_03_01_merge_result_files_overview_tables(Path_2_result_txt_files, analysis_input_table, dataname, savedir)
clear dataname

% trained on ATM without confound removal:
dataname = 'aachen_calibrated_predictions_model_trained_on_confound-None_sample-age_TIV';
subfunction_03_01_merge_result_files_overview_tables(Path_2_result_txt_files, analysis_input_table, dataname, savedir)
clear dataname

% trained on ATM with confound removal:
dataname = 'aachen_calibrated_predictions_model_trained_on_confound-TIV_sample-age_TIV';
subfunction_03_01_merge_result_files_overview_tables(Path_2_result_txt_files, analysis_input_table, dataname, savedir)
clear dataname

clear analysis_input_table
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% barcelona transgender application sample:

load(Path_2_overview_table_trans_Barcelona)

% trained on AM without confound removal:
dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-None_sample-age';
subfunction_03_01_merge_result_files_overview_tables(Path_2_result_txt_files, analysis_input_table, dataname, savedir)
clear dataname

% trained on AM with confound removal:
dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-TIV_sample-age';
subfunction_03_01_merge_result_files_overview_tables(Path_2_result_txt_files, analysis_input_table, dataname, savedir)
clear dataname

% trained on ATM without confound removal:
dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-None_sample-age_TIV';
subfunction_03_01_merge_result_files_overview_tables(Path_2_result_txt_files, analysis_input_table, dataname, savedir)
clear dataname

% trained on ATM with confound removal:
dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-TIV_sample-age_TIV';
subfunction_03_01_merge_result_files_overview_tables(Path_2_result_txt_files, analysis_input_table, dataname, savedir)
clear dataname

clear analysis_input_table
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

