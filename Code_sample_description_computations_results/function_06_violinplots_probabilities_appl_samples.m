
% create boxplots for transgender samples:

function function_06_violinplots_probabilities_appl_samples(Path_2_merged_tables)

%%% create new directory to save the variables:
if ~exist('06_violinplots_assigned_probability_application_samples', 'dir')
    mkdir('06_violinplots_assigned_probability_application_samples')
end

savedir = fullfile(pwd, '06_violinplots_assigned_probability_application_samples');
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% aachen transgender application sample:

% trained on AM without confound removal:
dataname = 'aachen_calibrated_predictions_model_trained_on_confound-None_sample-age';
subfunction_06_01_create_violinplots_probabilities_appl_samples(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on AM with confound removal:
dataname = 'aachen_calibrated_predictions_model_trained_on_confound-TIV_sample-age';
subfunction_06_01_create_violinplots_probabilities_appl_samples(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on ATM without confound removal:
dataname = 'aachen_calibrated_predictions_model_trained_on_confound-None_sample-age_TIV';
subfunction_06_01_create_violinplots_probabilities_appl_samples(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on ATM with confound removal:
dataname = 'aachen_calibrated_predictions_model_trained_on_confound-TIV_sample-age_TIV';
subfunction_06_01_create_violinplots_probabilities_appl_samples(Path_2_merged_tables, savedir, dataname)
clear dataname

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% barcelona transgender application sample:

% trained on AM without confound removal:
dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-None_sample-age';
subfunction_06_01_create_violinplots_probabilities_appl_samples(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on AM with confound removal:
dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-TIV_sample-age';
subfunction_06_01_create_violinplots_probabilities_appl_samples(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on ATM without confound removal:
dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-None_sample-age_TIV';
subfunction_06_01_create_violinplots_probabilities_appl_samples(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on ATM with confound removal:
dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-TIV_sample-age_TIV';
subfunction_06_01_create_violinplots_probabilities_appl_samples(Path_2_merged_tables, savedir, dataname)
clear dataname

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
