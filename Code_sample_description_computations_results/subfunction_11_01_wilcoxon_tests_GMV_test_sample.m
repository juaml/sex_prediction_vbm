
function subfunction_11_01_wilcoxon_tests_GMV_test_sample(Path_2_merged_tables, savedir, dataname)

load(fullfile(Path_2_merged_tables, ['merged_table_', dataname]));


%%% create new variable in table sorting subjects into correctly and not correctly classified males and
%%% females:

for i = 1:size(merged_table,1)
    if merged_table.sex{i} == 'M' & merged_table.pred(i) == 0
        merged_table.sex_correctly_classified{i} = ' males correct';
    elseif merged_table.sex{i} == 'M' & merged_table.pred(i) == 1
        merged_table.sex_correctly_classified{i} = ' males incorrect';
    elseif merged_table.sex{i} == 'F' & merged_table.pred(i) == 1
        merged_table.sex_correctly_classified{i} = 'females correct';
    elseif merged_table.sex{i} == 'F' & merged_table.pred(i) == 0
        merged_table.sex_correctly_classified{i} = 'females incorrect';
    end
end

merged_table = sortrows(merged_table, 'sex_correctly_classified');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% wilcoxon-tests to evaluate whether GMV-distributions differ between incorrect and correctly classified males and females:

    % alpha = 0.005 due to conservative alpha level caused by multiple
    % tests that are not directly related to each other
    % method approximate to evalute zvals in application samples
   
    %%% males:
    [p,h,stats] = ranksum(cell2mat(merged_table.GMV(strcmp(merged_table.sex_correctly_classified, ' males correct'))), cell2mat(merged_table.GMV(strcmp(merged_table.sex_correctly_classified, ' males incorrect'))),'alpha', 0.005, 'method', 'approximate');
    
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
    save(fullfile(savedir, ['Wilcoxon_rank_sum_GMV_correct_incorrect_males_', dataname]), 'wilcoxon_rank_sum_males')


    
    
%%% females:
    [p,h,stats] = ranksum(cell2mat(merged_table.GMV(strcmp(merged_table.sex_correctly_classified, 'females correct'))), cell2mat(merged_table.GMV(strcmp(merged_table.sex_correctly_classified, 'females incorrect'))),'alpha', 0.005, 'method', 'approximate');
    
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
    save(fullfile(savedir, ['Wilcoxon_rank_sum_GMV_correct_incorrect_females_', dataname]), 'wilcoxon_rank_sum_females')    








