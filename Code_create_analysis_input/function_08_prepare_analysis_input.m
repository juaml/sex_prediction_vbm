
function function_08_prepare_analysis_input(Path_2_extracted_GMV, Path_2_splitted_tables)

%%% create new directory to save the variables:
if ~exist('08_analysis_input', 'dir')
    mkdir('08_analysis_input')
end

savedir = fullfile(pwd, '08_analysis_input');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% age-TIV-matched table:

% load age-TIV-matched GMV-information:
load(fullfile(Path_2_extracted_GMV, 'age_TIV_matched_big_table_GMV_v4raw.mat'));

        % trainings-sample:
        load(fullfile(Path_2_splitted_tables, 'age_TIV_matched_train_sample.mat'));
        splitted_table = age_TIV_matched_train_sample_80_per;
        clear age_TIV_matched_train_sample_80_per
        dataname = 'age_TIV_matched_train_sample_80per';
        subfunction_08_01_prepare_analysis_input(savedir, dataname, GLMFlags, splitted_table)
        
        % test-sample:
        load(fullfile(Path_2_splitted_tables, 'age_TIV_matched_test_sample.mat'));
        splitted_table = age_TIV_matched_test_sample_20_per;
        clear age_TIV_matched_test_sample_20_per
        dataname = 'age_TIV_matched_test_sample_20_per';
        subfunction_08_01_prepare_analysis_input(savedir, dataname, GLMFlags, splitted_table)

clear GLMFlags
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% age-matched table:

% load age-matched GMV-information:
load(fullfile(Path_2_extracted_GMV, 'age_matched_big_table_GMV_v4raw.mat'));

        % trainings-sample:
        load(fullfile(Path_2_splitted_tables, 'age_matched_train_sample.mat'));
        splitted_table = age_matched_train_sample_80_per;
        clear age_matched_train_sample_80_per
        dataname = 'age_matched_train_sample_80per';
        subfunction_08_01_prepare_analysis_input(savedir, dataname, GLMFlags, splitted_table)
        
        % test-sample:
        load(fullfile(Path_2_splitted_tables, 'age_matched_test_sample.mat'));
        splitted_table = age_matched_test_sample_20_per;
        clear age_matched_test_sample_20_per
        dataname = 'age_matched_test_sample_20_per';
        subfunction_08_01_prepare_analysis_input(savedir, dataname, GLMFlags, splitted_table)
