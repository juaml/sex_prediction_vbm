
% function to compute a more detailed confusion matrix for the transgender
% samples:

function function_05_compute_predicted_labels_appl_samples(Path_2_merged_tables)

%%% create new directory to save the variables:
if ~exist('05_predicted_labels_application_samples', 'dir')
    mkdir('05_predicted_labels_application_samples')
end

savedir = fullfile(pwd, '05_predicted_labels_application_samples');
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% aachen transgender application sample:

% trained on AM without confound removal:
dataname = 'aachen_calibrated_predictions_model_trained_on_confound-None_sample-age';
subfunction_05_01_compute_predicted_labels_appl_samples(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on AM with confound removal:
dataname = 'aachen_calibrated_predictions_model_trained_on_confound-TIV_sample-age';
subfunction_05_01_compute_predicted_labels_appl_samples(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on ATM without confound removal:
dataname = 'aachen_calibrated_predictions_model_trained_on_confound-None_sample-age_TIV';
subfunction_05_01_compute_predicted_labels_appl_samples(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on ATM with confound removal:
dataname = 'aachen_calibrated_predictions_model_trained_on_confound-TIV_sample-age_TIV';
subfunction_05_01_compute_predicted_labels_appl_samples(Path_2_merged_tables, savedir, dataname)
clear dataname

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% barcelona transgender application sample:

% trained on AM without confound removal:
dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-None_sample-age';
subfunction_05_01_compute_predicted_labels_appl_samples(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on AM with confound removal:
dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-TIV_sample-age';
subfunction_05_01_compute_predicted_labels_appl_samples(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on ATM without confound removal:
dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-None_sample-age_TIV';
subfunction_05_01_compute_predicted_labels_appl_samples(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on ATM with confound removal:
dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-TIV_sample-age_TIV';
subfunction_05_01_compute_predicted_labels_appl_samples(Path_2_merged_tables, savedir, dataname)
clear dataname

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%