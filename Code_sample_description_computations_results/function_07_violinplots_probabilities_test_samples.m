
function function_07_violinplots_probabilities_test_samples(Path_2_merged_tables)

%%% create new directory to save the variables:
if ~exist('07_violinplots_assigned_probability_test_samples', 'dir')
    mkdir('07_violinplots_assigned_probability_test_samples')
end

savedir = fullfile(pwd, '07_violinplots_assigned_probability_test_samples');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% age-matched test sample:

% trained on AM without confound:
dataname = 'val-age_calibrated_predictions_model_trained_on_confound-None_sample-age';
subfunction_07_01_create_violinplots_probabilities_test_samples(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on AM with confound:
dataname = 'val-age_calibrated_predictions_model_trained_on_confound-TIV_sample-age';
subfunction_07_01_create_violinplots_probabilities_test_samples(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on ATM without confound:
dataname = 'val-age_calibrated_predictions_model_trained_on_confound-None_sample-age_TIV';
subfunction_07_01_create_violinplots_probabilities_test_samples(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on ATM with confound:
dataname = 'val-age_calibrated_predictions_model_trained_on_confound-TIV_sample-age_TIV';
subfunction_07_01_create_violinplots_probabilities_test_samples(Path_2_merged_tables, savedir, dataname)
clear dataname

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% age-TIV-matched test sample:

% trained on AM without confound removal:
dataname = 'val-ageTIV_calibrated_predictions_model_trained_on_confound-None_sample-age';
subfunction_07_01_create_violinplots_probabilities_test_samples(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on AM with confound removal:
dataname = 'val-ageTIV_calibrated_predictions_model_trained_on_confound-TIV_sample-age';
subfunction_07_01_create_violinplots_probabilities_test_samples(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on ATM without confound removal:
dataname = 'val-ageTIV_calibrated_predictions_model_trained_on_confound-None_sample-age_TIV';
subfunction_07_01_create_violinplots_probabilities_test_samples(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on ATM with confound removal:
dataname = 'val-ageTIV_calibrated_predictions_model_trained_on_confound-TIV_sample-age_TIV';
subfunction_07_01_create_violinplots_probabilities_test_samples(Path_2_merged_tables, savedir, dataname)
clear dataname

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
