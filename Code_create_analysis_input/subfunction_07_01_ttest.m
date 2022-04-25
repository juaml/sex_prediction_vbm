
% function to compute all ttests comparing the trainings- and
% test-datasets:

function subfunction_07_01_ttest(savedir, age_TIV_matched_train_sample_80_per, age_TIV_matched_test_sample_20_per, age_matched_train_sample_80_per, age_matched_test_sample_20_per)


%%% ATM = age-TIV-matched
%%% AM = age-matched

%%% ttests for age-TIV-matched datasets:
        index_females_train_sample_ATM = cell2mat(age_TIV_matched_train_sample_80_per.sex) == 'F';
        index_males_train_sample_ATM = cell2mat(age_TIV_matched_train_sample_80_per.sex) == 'M';

        index_females_test_sample_ATM = cell2mat(age_TIV_matched_test_sample_20_per.sex) == 'F';
        index_males_test_sample_ATM = cell2mat(age_TIV_matched_test_sample_20_per.sex) == 'M';

        % ttest TIV trainingssample:
        [h,p,ci,stats] = ttest2( cell2mat(age_TIV_matched_train_sample_80_per.TIV(index_females_train_sample_ATM)), cell2mat(age_TIV_matched_train_sample_80_per.TIV(index_males_train_sample_ATM)) );
        if h == 0
            fprintf('No significant difference in TIV between males and females in age-TIV-matched trainings-sample! \n')
        elseif h == 1
             fprintf('Significant difference in TIV between males and females in age-TIV-matched trainings-sample! Need to recheck! \n')
             return
        end
        save(fullfile(savedir, 'ttest_TIV_ATM_train_M_F'), 'h', 'p', 'ci', 'stats')
        clear h p ci stats

        % ttest TIV testsample:
        [h,p,ci,stats] = ttest2( cell2mat(age_TIV_matched_test_sample_20_per.TIV(index_females_test_sample_ATM)), cell2mat(age_TIV_matched_test_sample_20_per.TIV(index_males_test_sample_ATM)) );
        if h == 0
            fprintf('No significant difference in TIV between males and females in age-TIV-matched test-sample! \n')
        elseif h == 1
             fprintf('Significant difference in TIV between males and females in age-TIV-matched test-sample! Need to recheck! \n')
             return
        end
        save(fullfile(savedir, 'ttest_TIV_ATM_test_M_F'), 'h', 'p', 'ci', 'stats')
        clear h p ci stats

        % ttest age trainingssample:
        [h,p,ci,stats] = ttest2( cell2mat(age_TIV_matched_train_sample_80_per.age(index_females_train_sample_ATM)), cell2mat(age_TIV_matched_train_sample_80_per.age(index_males_train_sample_ATM)) );
        if h == 0
            fprintf('No significant difference in age between males and females in age-TIV-matched trainings-sample! \n')
        elseif h == 1
             fprintf('Significant difference in age between males and females in age-TIV-matched trainings-sample! Need to recheck! \n')
             return
        end
        save(fullfile(savedir, 'ttest_age_ATM_train_M_F'), 'h', 'p', 'ci', 'stats')
        clear h p ci stats

        % ttest TIV testsample:
        [h,p,ci,stats] = ttest2( cell2mat(age_TIV_matched_test_sample_20_per.age(index_females_test_sample_ATM)), cell2mat(age_TIV_matched_test_sample_20_per.age(index_males_test_sample_ATM)) );
        if h == 0
            fprintf('No significant difference in age between males and females in age-TIV-matched test-sample! \n')
        elseif h == 1
             fprintf('Significant difference in age between males and females in age-TIV-matched test-sample! Need to recheck! \n')
             return
        end
        save(fullfile(savedir, 'ttest_age_ATM_test_M_F'), 'h', 'p', 'ci', 'stats')
        clear h p ci stats
        
        
        % ttest TIV train vs. test
        [h,p,ci,stats] = ttest2( cell2mat(age_TIV_matched_train_sample_80_per.TIV), cell2mat(age_TIV_matched_test_sample_20_per.TIV) );
        if h == 0
            fprintf('No significant difference in TIV between age-TIV-matched trainings- and testsample! \n')
        elseif h == 1
             fprintf('Significant difference in TIV between age-TIV-matched trainings- and testsample! Need to recheck! \n')
             return
        end
        save(fullfile(savedir, 'ttest_TIV_ATM_train_test'), 'h', 'p', 'ci', 'stats')
        clear h p ci stats
         
        % ttest age train vs. test
        [h,p,ci,stats] = ttest2( cell2mat(age_TIV_matched_train_sample_80_per.age), cell2mat(age_TIV_matched_test_sample_20_per.age) );
        if h == 0
            fprintf('No significant difference in age between age-TIV-matched trainings- and testsample! \n')
        elseif h == 1
             fprintf('Significant difference in age between age-TIV-matched trainings- and testsample! Need to recheck! \n')
             return
        end
        save(fullfile(savedir, 'ttest_age_ATM_train_test'), 'h', 'p', 'ci', 'stats')
        clear h p ci stats
        
clear index_females_test_sample_ATM index_females_train_sample_ATM index_males_train_sample_ATM index_males_test_sample_ATM        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% ttests for age-matched datasets:

        index_females_train_sample_AM = cell2mat(age_matched_train_sample_80_per.sex) == 'F';
        index_males_train_sample_AM = cell2mat(age_matched_train_sample_80_per.sex) == 'M';

        index_females_test_sample_AM = cell2mat(age_matched_test_sample_20_per.sex) == 'F';
        index_males_test_sample_AM = cell2mat(age_matched_test_sample_20_per.sex) == 'M';

        % ttest TIV trainingssample:
        [h,p,ci,stats] = ttest2( cell2mat(age_matched_train_sample_80_per.TIV(index_females_train_sample_AM)), cell2mat(age_matched_train_sample_80_per.TIV(index_males_train_sample_AM)) );
        if h == 0
            fprintf('No significant difference in TIV between males and females in age-matched trainings-sample! Need to recheck!\n')
            return
        elseif h == 1
            fprintf('Significant difference in TIV between males and females in age-matched trainings-sample! \n')
        end
        save(fullfile(savedir, 'ttest_TIV_AM_train_M_F'), 'h', 'p', 'ci', 'stats')
        clear h p ci stats
            
        % ttest TIV testsample:
        [h,p,ci,stats] = ttest2( cell2mat(age_matched_test_sample_20_per.TIV(index_females_test_sample_AM)), cell2mat(age_matched_test_sample_20_per.TIV(index_males_test_sample_AM)) );
        if h == 0
            fprintf('No significant difference in TIV between males and females in age-matched test-sample! Need to recheck!\n')
            return
        elseif h == 1
            fprintf('Significant difference in TIV between males and females in age-matched test-sample! \n')
        end
        save(fullfile(savedir, 'ttest_TIV_AM_test_M_F'), 'h', 'p', 'ci', 'stats')
        clear h p ci stats
            
        % ttest age trainingssample:
        [h,p,ci,stats] = ttest2( cell2mat(age_matched_train_sample_80_per.age(index_females_train_sample_AM)), cell2mat(age_matched_train_sample_80_per.age(index_males_train_sample_AM)) );
        if h == 0
            fprintf('No significant difference in age between males and females in age-matched trainings-sample! \n')
        elseif h == 1
             fprintf('Significant difference in age between males and females in age-matched trainings-sample! Need to recheck! \n')
             return
        end
        save(fullfile(savedir, 'ttest_age_AM_train_M_F'), 'h', 'p', 'ci', 'stats')
        clear h p ci stats

        % ttest age testsample:
        [h,p,ci,stats] = ttest2( cell2mat(age_matched_test_sample_20_per.age(index_females_test_sample_AM)), cell2mat(age_matched_test_sample_20_per.age(index_males_test_sample_AM)) );
        if h == 0
            fprintf('No significant difference in age between males and females in age-matched test-sample! \n')
        elseif h == 1
             fprintf('Significant difference in age between males and females in age-matched test-sample! Need to recheck! \n')
             return
        end
        save(fullfile(savedir, 'ttest_age_AM_test_M_F'), 'h', 'p', 'ci', 'stats')
        clear h p ci stats

         
        % ttest TIV train vs. test
        [h,p,ci,stats] = ttest2( cell2mat(age_matched_train_sample_80_per.TIV), cell2mat(age_matched_test_sample_20_per.TIV) );
        if h == 0
            fprintf('No significant difference in TIV between age-matched trainings- and testsample! \n')
        elseif h == 1
             fprintf('Significant difference in TIV between age-matched trainings- and testsample! Need to recheck! \n')
             return
        end
        save(fullfile(savedir, 'ttest_TIV_AM_train_test'), 'h', 'p', 'ci', 'stats')
        clear h p ci stats
         
        % ttest age train vs. test
        [h,p,ci,stats] = ttest2( cell2mat(age_matched_train_sample_80_per.age), cell2mat(age_matched_test_sample_20_per.age) );
        if h == 0
            fprintf('No significant difference in age between age-matched trainings- and testsample! \n')
        elseif h == 1
             fprintf('Significant difference in age between age-matched trainings- and testsample! Need to recheck! \n')
             return
        end
        save(fullfile(savedir, 'ttest_age_AM_train_test'), 'h', 'p', 'ci', 'stats')
        clear h p ci stats
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%% ttest age ATM vs. AM training-samples:
        [h,p,ci,stats] = ttest2( cell2mat(age_TIV_matched_train_sample_80_per.age), cell2mat(age_matched_train_sample_80_per.age) );
        if h == 0
            fprintf('No significant difference in age between ATM and AM trainings-samples! \n')
        elseif h == 1
             fprintf('Significant difference in age between ATM and AM trainings-samples! Need to recheck! \n')
             return
        end
        save(fullfile(savedir, 'ttest_age_train_ATM_AM'), 'h', 'p', 'ci', 'stats')
        clear h p ci stats
        
    %%% ttest age ATM vs. AM test-samples:
        [h,p,ci,stats] = ttest2( cell2mat(age_TIV_matched_test_sample_20_per.age), cell2mat(age_matched_test_sample_20_per.age) );
        if h == 0
            fprintf('No significant difference in age between ATM and AM test-samples! \n')
        elseif h == 1
             fprintf('Significant difference in age between ATM and AM test-samples! Need to recheck! \n')
             return
        end
        save(fullfile(savedir, 'ttest_age_test_ATM_AM'), 'h', 'p', 'ci', 'stats')
        clear h p ci stats


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% save data:
save(fullfile(savedir, 'age_TIV_matched_train_sample'), 'age_TIV_matched_train_sample_80_per')
save(fullfile(savedir, 'age_TIV_matched_test_sample'), 'age_TIV_matched_test_sample_20_per')
save(fullfile(savedir, 'age_matched_train_sample'), 'age_matched_train_sample_80_per')
save(fullfile(savedir, 'age_matched_test_sample'), 'age_matched_test_sample_20_per')

        