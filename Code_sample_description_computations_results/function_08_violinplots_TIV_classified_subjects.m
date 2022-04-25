
% function to plot the TIV from correctly and not correctly classified
% subjects:

function function_08_violinplots_TIV_classified_subjects(Path_2_merged_tables)

%%% create new directory to save the variables:
if ~exist('08_violinplots_TIV_of_subjects_classified_as_male_or_female', 'dir')
    mkdir('08_violinplots_TIV_of_subjects_classified_as_male_or_female')
end

savedir = fullfile(pwd, '08_violinplots_TIV_of_subjects_classified_as_male_or_female');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% applied to age-matched test sample:

    % trained on AM without confound:
    dataname = 'val-age_calibrated_predictions_model_trained_on_confound-None_sample-age';
    subfunction_08_01_TIV_violinplots_test_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on AM with confound:
    dataname = 'val-age_calibrated_predictions_model_trained_on_confound-TIV_sample-age';
    subfunction_08_01_TIV_violinplots_test_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on ATM without confound:
    dataname = 'val-age_calibrated_predictions_model_trained_on_confound-None_sample-age_TIV';
    subfunction_08_01_TIV_violinplots_test_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on ATM with confound:
    dataname = 'val-age_calibrated_predictions_model_trained_on_confound-TIV_sample-age_TIV';
    subfunction_08_01_TIV_violinplots_test_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% applied to age-TIV-matched test sample:

    % trained on AM without confound:
    dataname = 'val-ageTIV_calibrated_predictions_model_trained_on_confound-None_sample-age';
    subfunction_08_01_TIV_violinplots_test_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on AM with confound:
    dataname = 'val-ageTIV_calibrated_predictions_model_trained_on_confound-TIV_sample-age';
    subfunction_08_01_TIV_violinplots_test_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on ATM without confound:
    dataname = 'val-ageTIV_calibrated_predictions_model_trained_on_confound-None_sample-age_TIV';
    subfunction_08_01_TIV_violinplots_test_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on ATM with confound:
    dataname = 'val-ageTIV_calibrated_predictions_model_trained_on_confound-TIV_sample-age_TIV';
    subfunction_08_01_TIV_violinplots_test_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% make new savedir for separate plots of cisgender and transgender
% individuals in the application samples:
clear savedir

if ~exist(fullfile(pwd, '08_violinplots_TIV_of_subjects_classified_as_male_or_female', 'application_samples_separate_plots_for_cis_trans_individuals'), 'dir')
    mkdir(fullfile(pwd, '08_violinplots_TIV_of_subjects_classified_as_male_or_female', 'application_samples_separate_plots_for_cis_trans_individuals'))
end
savedir = fullfile(pwd, '08_violinplots_TIV_of_subjects_classified_as_male_or_female', 'application_samples_separate_plots_for_cis_trans_individuals');

%%% applied to aachen sample:

    % trained on AM without confound:
    dataname = 'aachen_calibrated_predictions_model_trained_on_confound-None_sample-age';
    subfunction_08_02_TIV_violinplots_application_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname
    
    % trained on AM with confound:
    dataname = 'aachen_calibrated_predictions_model_trained_on_confound-TIV_sample-age';
    subfunction_08_02_TIV_violinplots_application_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on ATM without confound:
    dataname = 'aachen_calibrated_predictions_model_trained_on_confound-None_sample-age_TIV';
    subfunction_08_02_TIV_violinplots_application_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on ATM with confound:
    dataname = 'aachen_calibrated_predictions_model_trained_on_confound-TIV_sample-age_TIV';
    subfunction_08_02_TIV_violinplots_application_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% applied to barcelona sample:

    % trained on AM without confound:
    dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-None_sample-age';
    subfunction_08_02_TIV_violinplots_application_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname
    
    % trained on AM with confound:
    dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-TIV_sample-age';
    subfunction_08_02_TIV_violinplots_application_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on ATM without confound:
    dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-None_sample-age_TIV';
    subfunction_08_02_TIV_violinplots_application_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on ATM with confound:
    dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-TIV_sample-age_TIV';
    subfunction_08_02_TIV_violinplots_application_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%