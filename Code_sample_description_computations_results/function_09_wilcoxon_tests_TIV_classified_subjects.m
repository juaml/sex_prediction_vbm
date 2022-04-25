% function to compute ttests between correctly and not correctly classified
% subjects:

function function_09_wilcoxon_tests_TIV_classified_subjects(Path_2_merged_tables)

%%% create new directory to save the variables:
if ~exist('09_wilcoxon_tests_TIV_of_subjects_classified_as_male_or_female', 'dir')
    mkdir('09_wilcoxon_tests_TIV_of_subjects_classified_as_male_or_female')
end

savedir = fullfile(pwd, '09_wilcoxon_tests_TIV_of_subjects_classified_as_male_or_female');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% applied to age-matched test sample:

    % trained on AM without confound:
    dataname = 'val-age_calibrated_predictions_model_trained_on_confound-None_sample-age';
    subfunction_09_01_wilcoxon_tests_TIV_test_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on AM with confound:
    dataname = 'val-age_calibrated_predictions_model_trained_on_confound-TIV_sample-age';
    subfunction_09_01_wilcoxon_tests_TIV_test_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on ATM without confound:
    dataname = 'val-age_calibrated_predictions_model_trained_on_confound-None_sample-age_TIV';
    subfunction_09_01_wilcoxon_tests_TIV_test_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on ATM with confound:
    dataname = 'val-age_calibrated_predictions_model_trained_on_confound-TIV_sample-age_TIV';
    subfunction_09_01_wilcoxon_tests_TIV_test_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% applied to age-TIV-matched test sample:

    % trained on AM without confound:
    dataname = 'val-ageTIV_calibrated_predictions_model_trained_on_confound-None_sample-age';
    subfunction_09_01_wilcoxon_tests_TIV_test_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on AM with confound:
    dataname = 'val-ageTIV_calibrated_predictions_model_trained_on_confound-TIV_sample-age';
    subfunction_09_01_wilcoxon_tests_TIV_test_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on ATM without confound:
    dataname = 'val-ageTIV_calibrated_predictions_model_trained_on_confound-None_sample-age_TIV';
    subfunction_09_01_wilcoxon_tests_TIV_test_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on ATM with confound:
    dataname = 'val-ageTIV_calibrated_predictions_model_trained_on_confound-TIV_sample-age_TIV';
    subfunction_09_01_wilcoxon_tests_TIV_test_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% applied to barcelona sample:

    % trained on AM without confound:
    dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-None_sample-age';
    subfunction_09_02_wilcoxon_tests_TIV_appl_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname
    
    % trained on AM with confound:
    dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-TIV_sample-age';
    subfunction_09_02_wilcoxon_tests_TIV_appl_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on ATM without confound:
    dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-None_sample-age_TIV';
    subfunction_09_02_wilcoxon_tests_TIV_appl_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on ATM with confound:
    dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-TIV_sample-age_TIV';
    subfunction_09_02_wilcoxon_tests_TIV_appl_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
%%% applied to aachen sample:

    % trained on AM without confound:
    dataname = 'aachen_calibrated_predictions_model_trained_on_confound-None_sample-age';
    subfunction_09_02_wilcoxon_tests_TIV_appl_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname
    
    % trained on AM with confound:
    dataname = 'aachen_calibrated_predictions_model_trained_on_confound-TIV_sample-age';
    subfunction_09_02_wilcoxon_tests_TIV_appl_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on ATM without confound:
    dataname = 'aachen_calibrated_predictions_model_trained_on_confound-None_sample-age_TIV';
    subfunction_09_02_wilcoxon_tests_TIV_appl_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on ATM with confound:
    dataname = 'aachen_calibrated_predictions_model_trained_on_confound-TIV_sample-age_TIV';
    subfunction_09_02_wilcoxon_tests_TIV_appl_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
