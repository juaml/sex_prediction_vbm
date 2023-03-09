
function function_11_wilcoxon_test_GMV_classified_subjects(Path_2_merged_tables)

%%% create new directory to save the variables:
if ~exist('11_GMV_wilcoxon_test_GMV', 'dir')
    mkdir('11_GMV_wilcoxon_test_GMV')
end

savedir = fullfile(pwd, '11_GMV_wilcoxon_test_GMV');
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% applied to age-matched test sample:

    % trained on AM without confound:
    dataname = 'val-age_calibrated_predictions_model_trained_on_confound-None_sample-age';
    subfunction_11_01_wilcoxon_tests_GMV_test_sample(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on AM with confound:
    dataname = 'val-age_calibrated_predictions_model_trained_on_confound-TIV_sample-age';
    subfunction_11_01_wilcoxon_tests_GMV_test_sample(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on ATM without confound:
    dataname = 'val-age_calibrated_predictions_model_trained_on_confound-None_sample-age_TIV';
    subfunction_11_01_wilcoxon_tests_GMV_test_sample(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on ATM with confound:
    dataname = 'val-age_calibrated_predictions_model_trained_on_confound-TIV_sample-age_TIV';
    subfunction_11_01_wilcoxon_tests_GMV_test_sample(Path_2_merged_tables, savedir, dataname)
    clear dataname

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% applied to age-TIV-matched test sample:

    % trained on AM without confound:
    dataname = 'val-ageTIV_calibrated_predictions_model_trained_on_confound-None_sample-age';
    subfunction_11_01_wilcoxon_tests_GMV_test_sample(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on AM with confound:
    dataname = 'val-ageTIV_calibrated_predictions_model_trained_on_confound-TIV_sample-age';
    subfunction_11_01_wilcoxon_tests_GMV_test_sample(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on ATM without confound:
    dataname = 'val-ageTIV_calibrated_predictions_model_trained_on_confound-None_sample-age_TIV';
    subfunction_11_01_wilcoxon_tests_GMV_test_sample(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on ATM with confound:
    dataname = 'val-ageTIV_calibrated_predictions_model_trained_on_confound-TIV_sample-age_TIV';
    subfunction_11_01_wilcoxon_tests_GMV_test_sample(Path_2_merged_tables, savedir, dataname)
    clear dataname

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%% applied to aachen sample:

    % trained on AM without confound:
    dataname = 'aachen_calibrated_predictions_model_trained_on_confound-None_sample-age';
    subfunction_11_02_wilcoxon_tests_GMV_appl_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname
    
    % trained on AM with confound:
    dataname = 'aachen_calibrated_predictions_model_trained_on_confound-TIV_sample-age';
    subfunction_11_02_wilcoxon_tests_GMV_appl_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on ATM without confound:
    dataname = 'aachen_calibrated_predictions_model_trained_on_confound-None_sample-age_TIV';
    subfunction_11_02_wilcoxon_tests_GMV_appl_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on ATM with confound:
    dataname = 'aachen_calibrated_predictions_model_trained_on_confound-TIV_sample-age_TIV';
    subfunction_11_02_wilcoxon_tests_GMV_appl_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% applied to barcelona sample:

    % trained on AM without confound:
    dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-None_sample-age';
    subfunction_11_02_wilcoxon_tests_GMV_appl_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname
    
    % trained on AM with confound:
    dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-TIV_sample-age';
    subfunction_11_02_wilcoxon_tests_GMV_appl_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on ATM without confound:
    dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-None_sample-age_TIV';
    subfunction_11_02_wilcoxon_tests_GMV_appl_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

    % trained on ATM with confound:
    dataname = 'barcelona_calibrated_predictions_model_trained_on_confound-TIV_sample-age_TIV';
    subfunction_11_02_wilcoxon_tests_GMV_appl_samples(Path_2_merged_tables, savedir, dataname)
    clear dataname

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 