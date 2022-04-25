
% compute classification reports:

function function_04_classification_report(Path_2_merged_tables)

%%% create new directory to save the variables:
if ~exist('04_classification_report', 'dir')
    mkdir('04_classification_report')
end

savedir = fullfile(pwd, '04_classification_report');
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% age-matched test sample:

% trained on AM without confound:
dataname = 'val-age_calibrated_predictions_model_trained_on_confound-None_sample-age';
subfunction_04_01_compute_classification_report(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on AM with confound:
dataname = 'val-age_calibrated_predictions_model_trained_on_confound-TIV_sample-age';
subfunction_04_01_compute_classification_report(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on ATM without confound:
dataname = 'val-age_calibrated_predictions_model_trained_on_confound-None_sample-age_TIV';
subfunction_04_01_compute_classification_report(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on ATM with confound:
dataname = 'val-age_calibrated_predictions_model_trained_on_confound-TIV_sample-age_TIV';
subfunction_04_01_compute_classification_report(Path_2_merged_tables, savedir, dataname)
clear dataname

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% age-TIV-matched test sample:

% trained on AM without confound removal:
dataname = 'val-ageTIV_calibrated_predictions_model_trained_on_confound-None_sample-age';
subfunction_04_01_compute_classification_report(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on AM with confound removal:
dataname = 'val-ageTIV_calibrated_predictions_model_trained_on_confound-TIV_sample-age';
subfunction_04_01_compute_classification_report(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on ATM without confound removal:
dataname = 'val-ageTIV_calibrated_predictions_model_trained_on_confound-None_sample-age_TIV';
subfunction_04_01_compute_classification_report(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on ATM with confound removal:
dataname = 'val-ageTIV_calibrated_predictions_model_trained_on_confound-TIV_sample-age_TIV';
subfunction_04_01_compute_classification_report(Path_2_merged_tables, savedir, dataname)
clear dataname

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% aachen transgender application sample:

% trained on AM without confound removal:
dataname = 'aachen_calibrated_predictions_model_trained_on_confound-None_sample-age';
subfunction_04_01_compute_classification_report(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on AM with confound removal:
dataname = 'aachen_calibrated_predictions_model_trained_on_confound-TIV_sample-age';
subfunction_04_01_compute_classification_report(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on ATM without confound removal:
dataname = 'aachen_calibrated_predictions_model_trained_on_confound-None_sample-age_TIV';
subfunction_04_01_compute_classification_report(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on ATM with confound removal:
dataname = 'aachen_calibrated_predictions_model_trained_on_confound-TIV_sample-age_TIV';
subfunction_04_01_compute_classification_report(Path_2_merged_tables, savedir, dataname)
clear dataname

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% barcelona transgender application sample:

% trained on AM without confound removal:
dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-None_sample-age';
subfunction_04_01_compute_classification_report(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on AM with confound removal:
dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-TIV_sample-age';
subfunction_04_01_compute_classification_report(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on ATM without confound removal:
dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-None_sample-age_TIV';
subfunction_04_01_compute_classification_report(Path_2_merged_tables, savedir, dataname)
clear dataname

% trained on ATM with confound removal:
dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-TIV_sample-age_TIV';
subfunction_04_01_compute_classification_report(Path_2_merged_tables, savedir, dataname)
clear dataname

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
