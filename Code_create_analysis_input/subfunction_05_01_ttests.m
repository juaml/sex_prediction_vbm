
% function to test whether the combined big tables meet the criteria in
% terms of ttests:

function subfunction_05_01_ttests(savedir, big_table_merged_age_matched, big_table_merged_age_TIV_matched)

%%% ttests for age-TIV-matched table:

index_matched_subjects_males = cell2mat(big_table_merged_age_TIV_matched.sex) == 'M';
index_matched_subjects_females = cell2mat(big_table_merged_age_TIV_matched.sex) == 'F';

% ttest TIV:
[h,p,ci,stats] = ttest2(cell2mat(big_table_merged_age_TIV_matched.TIV(index_matched_subjects_females)), cell2mat(big_table_merged_age_TIV_matched.TIV(index_matched_subjects_males)));

        if h == 0
            fprintf('No significant difference in TIV between males and females in merged age-TIV-matched-table \n')
        elseif h == 1
             fprintf('Significant difference in TIV between males and females in merged age-TIV-matched-table, Need to recheck! \n')
             return
        end
        save(fullfile(savedir, 'ttest_statistics_TIV_age_TIV_matched_table'), 'h', 'p', 'ci', 'stats')
        clear h p ci stats
        
% ttest age:
[h,p,ci,stats] = ttest2(cell2mat(big_table_merged_age_TIV_matched.age(index_matched_subjects_females)), cell2mat(big_table_merged_age_TIV_matched.age(index_matched_subjects_males)));

        if h == 0
            fprintf('No significant difference in age between males and females in merged age-TIV-matched-table \n')
        elseif h == 1
             fprintf('Significant difference in age between males and females in merged age-TIV-matched-table, Need to recheck! \n')
             return
        end
        save(fullfile(savedir, 'ttest_statistics_age_age_TIV_matched_table'), 'h', 'p', 'ci', 'stats')
        clear h p ci stats

        clear index_matched_subjects_females index_matched_subjects_males
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
%%% ttests for age-matched table:
index_matched_subjects_males = cell2mat(big_table_merged_age_matched.sex) == 'M';
index_matched_subjects_females = cell2mat(big_table_merged_age_matched.sex) == 'F';

% ttest age:
[h,p,ci,stats] = ttest2(cell2mat(big_table_merged_age_matched.age(index_matched_subjects_females)), cell2mat(big_table_merged_age_matched.age(index_matched_subjects_males)));

        if h == 0
            fprintf('No significant difference in age between males and females in merged age-matched-table \n')
        elseif h == 1
             fprintf('Significant difference in age between males and females in merged age-matched-table, Need to recheck!\n')
             return
        end
        save(fullfile(savedir, 'ttest_statistics_age_age_matched_table'), 'h', 'p', 'ci', 'stats')
        clear h p ci stats

        
        
% ttest TIV:
[h,p,ci,stats] = ttest2(cell2mat(big_table_merged_age_matched.TIV(index_matched_subjects_females)), cell2mat(big_table_merged_age_matched.TIV(index_matched_subjects_males)));

        if h == 0
            fprintf('No significant difference in TIV between males and females in merged age-matched-table, Need to recheck! \n')
            return
        elseif h == 1
             fprintf('Significant difference in TIV between males and females in merged age-matched-table! \n')
        end
        save(fullfile(savedir, 'ttest_statistics_TIV_age_matched_table'), 'h', 'p', 'ci', 'stats')
        clear h p ci stats

        clear index_matched_subjects_females index_matched_subjects_males
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ttest to test whether the age-distribution in both tables is comparable:
[h,p,ci,stats] = ttest2(cell2mat(big_table_merged_age_matched.age), cell2mat(big_table_merged_age_TIV_matched.age));
        if h == 0
            fprintf('No significant difference in age between merged age-matched-table and merged age-TIV-matched-table! \n')
        elseif h == 1
             fprintf('Significant difference in age in merged age-matched-table and merged age-TIV-matched-table, Need to recheck!\n')
             return
        end
        save(fullfile(savedir, 'ttest_statistics_age_age_TIV_matched_table_age_matched_table'), 'h', 'p', 'ci', 'stats')
        clear h p ci stats

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% save big_tables:
save(fullfile(savedir, 'big_table_age_TIV_matched'), 'big_table_merged_age_TIV_matched')
save(fullfile(savedir, 'big_table_age_matched'), 'big_table_merged_age_matched')
