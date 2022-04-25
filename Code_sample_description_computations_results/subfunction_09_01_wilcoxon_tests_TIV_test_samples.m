
function subfunction_09_01_wilcoxon_tests_TIV_test_samples(Path_2_merged_tables, savedir, dataname)

load(fullfile(Path_2_merged_tables, ['merged_table_', dataname]));


%%% create new variable in table sorting subjects into correctly and not correctly classified males and
%%% females (in accordance with their sex assigned at birth)

for i = 1:size(merged_table,1)
    if merged_table.sex{i} == 'M' & merged_table.pred(i) == 0
        merged_table.sex_classified_in_accordance_with_sex_assigned_at_birth{i} = 'male_classified_as_male';
    elseif merged_table.sex{i} == 'M' & merged_table.pred(i) == 1
        merged_table.sex_classified_in_accordance_with_sex_assigned_at_birth{i} = 'male_classified_as_female';
    elseif merged_table.sex{i} == 'F' & merged_table.pred(i) == 1
        merged_table.sex_classified_in_accordance_with_sex_assigned_at_birth{i} = 'female_classified_as_female';
    elseif merged_table.sex{i} == 'F' & merged_table.pred(i) == 0
        merged_table.sex_classified_in_accordance_with_sex_assigned_at_birth{i} = 'female_classified_as_male';
    end
end

merged_table = sortrows(merged_table, 'sex_classified_in_accordance_with_sex_assigned_at_birth');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% wilcoxon-tests to evaluate whether TIV-distributions differ between incorrect and correctly classified males and females:

    % alpha = 0.005 due to conservative alpha level caused by multiple
    % tests that are not directly related to each other
    % method approximate to evalute zvals in application samples
   
    %%% males:
    [p,h,stats] = ranksum(cell2mat(merged_table.TIV(strcmp(merged_table.sex_classified_in_accordance_with_sex_assigned_at_birth, 'male_classified_as_male'))), cell2mat(merged_table.TIV(strcmp(merged_table.sex_classified_in_accordance_with_sex_assigned_at_birth, 'male_classified_as_female'))),'alpha', 0.005, 'method', 'approximate');
    
    % compute effect sizes:
    r = stats.zval/sqrt(sum(strcmp(merged_table.sex, 'M')));
    R2 = stats.zval^2/sum(strcmp(merged_table.sex, 'M'));
    
    % save statistics and effect sizes:
    wilcoxon_rank_sum_males.h = h;
    wilcoxon_rank_sum_males.p = p;
    wilcoxon_rank_sum_males.stats = stats;
    wilcoxon_rank_sum_males.r = r;
    wilcoxon_rank_sum_males.R2 = R2;
    clear h p stats r R2
    save(fullfile(savedir, ['Wilcoxon_rank_sum_TIV_males_classified_as_male_female_', dataname]), 'wilcoxon_rank_sum_males')

    
    %%% females:
    [p,h,stats] = ranksum(cell2mat(merged_table.TIV(strcmp(merged_table.sex_classified_in_accordance_with_sex_assigned_at_birth, 'female_classified_as_female'))), cell2mat(merged_table.TIV(strcmp(merged_table.sex_classified_in_accordance_with_sex_assigned_at_birth, 'female_classified_as_male'))),'alpha', 0.005, 'method', 'approximate');
    
    % compute effect sizes:
    r = stats.zval/sqrt(sum(strcmp(merged_table.sex, 'F')));
    R2 = stats.zval^2/sum(strcmp(merged_table.sex, 'F'));
    
    % save statistics and effect sizes:
    wilcoxon_rank_sum_females.h = h;
    wilcoxon_rank_sum_females.p = p;
    wilcoxon_rank_sum_females.stats = stats;
    wilcoxon_rank_sum_females.r = r;
    wilcoxon_rank_sum_females.R2 = R2;
    clear h p stats r R2
    save(fullfile(savedir, ['Wilcoxon_rank_sum_TIV_females_classified_as_male_female_', dataname]), 'wilcoxon_rank_sum_females')    

