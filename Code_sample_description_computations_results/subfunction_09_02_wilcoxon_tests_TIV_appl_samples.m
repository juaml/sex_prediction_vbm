
%%% ttests to evaluate whether TIV-distributions differ between incorrect and correctly classified cis- and transgender males and females:
%%% after evaluating whether a test of homongenous variances is not
%%% significant:

function subfunction_09_02_wilcoxon_tests_TIV_appl_samples(Path_2_merged_tables, savedir, dataname)

% load data:
load(fullfile(Path_2_merged_tables, ['merged_table_', dataname]));

%%% create new variable in table sorting subjects into correctly and not correctly classified males and
%%% females:

for i = 1:size(merged_table,1)
    if isequal(merged_table.group{i},'CM') & merged_table.pred(i) == 0
        merged_table.sex_correctly_classified{i} = 'CM_classified_as_male';
    elseif isequal(merged_table.group{i},'CM') & merged_table.pred(i) == 1
        merged_table.sex_correctly_classified{i} = 'CM_classified_as_female';
    elseif isequal(merged_table.group{i},'CW') & merged_table.pred(i) == 0
        merged_table.sex_correctly_classified{i} = 'CW_classified_as_male';
    elseif isequal(merged_table.group{i},'CW') & merged_table.pred(i) == 1
        merged_table.sex_correctly_classified{i} = 'CW_classified_as_female';    
    elseif isequal(merged_table.group{i},'TM') & merged_table.pred(i) == 0
        merged_table.sex_correctly_classified{i} = 'TM_classified_as_male';
    elseif isequal(merged_table.group{i},'TM') & merged_table.pred(i) == 1
        merged_table.sex_correctly_classified{i} = 'TM_classified_as_female';
    elseif isequal(merged_table.group{i},'TW') & merged_table.pred(i) == 0
        merged_table.sex_correctly_classified{i} = 'TW_classified_as_male'; 
    elseif isequal(merged_table.group{i},'TW') & merged_table.pred(i) == 1
        merged_table.sex_correctly_classified{i} = 'TW_classified_as_female';
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%% cisgender males correct vs. males incorrect:
    try
     [p,h,stats] = ranksum(cell2mat(merged_table.TIV(strcmp(merged_table.sex_correctly_classified, 'CM_classified_as_male'))), cell2mat(merged_table.TIV(strcmp(merged_table.sex_correctly_classified, 'CM_classified_as_female'))),'alpha', 0.005, 'method', 'approximate');
        
        % compute effect sizes:
        r = stats.zval/sqrt(sum(strcmp(merged_table.group, 'CM')));
        R2 = stats.zval^2/sum(strcmp(merged_table.group, 'CM'));
     
        % save statistics and effect sizes:
        wilcoxon_rank_sum_CM.h = h;
        wilcoxon_rank_sum_CM.p = p;
        wilcoxon_rank_sum_CM.stats = stats;
        wilcoxon_rank_sum_CM.r = r;
        wilcoxon_rank_sum_CM.R2 = R2;
        clear h p stats r R2
        save(fullfile(savedir, ['Wilcoxon_rank_sum_TIV_CM_classified_as_male_female_', dataname]), 'wilcoxon_rank_sum_CM')
    catch
        fprintf('Missing of two sides for wilcoxon test, not able to compare CM classified as either male or female in %s \n', dataname)
    end
    

%%% cisgender females correct vs. females incorrect:
    try
     [p,h,stats] = ranksum(cell2mat(merged_table.TIV(strcmp(merged_table.sex_correctly_classified, 'CW_classified_as_female'))), cell2mat(merged_table.TIV(strcmp(merged_table.sex_correctly_classified, 'CW_classified_as_male'))),'alpha', 0.005, 'method', 'approximate');
        
        % compute effect sizes:
        r = stats.zval/sqrt(sum(strcmp(merged_table.group, 'CW')));
        R2 = stats.zval^2/sum(strcmp(merged_table.group, 'CW'));
     
        % save statistics and effect sizes:
        wilcoxon_rank_sum_CW.h = h;
        wilcoxon_rank_sum_CW.p = p;
        wilcoxon_rank_sum_CW.stats = stats;
        wilcoxon_rank_sum_CW.r = r;
        wilcoxon_rank_sum_CW.R2 = R2;
        clear h p stats r R2
        save(fullfile(savedir, ['Wilcoxon_rank_sum_TIV_CW_classified_as_male_female_', dataname]), 'wilcoxon_rank_sum_CW')
    catch
        fprintf('Missing of two sides for wilcoxon test, not able to compare CW classified as either male or female in %s \n', dataname)
    end
    
    
%%% transgender men correct vs. men incorrect:
    try
       [p,h,stats] = ranksum(cell2mat(merged_table.TIV(strcmp(merged_table.sex_correctly_classified, 'TM_classified_as_female'))), cell2mat(merged_table.TIV(strcmp(merged_table.sex_correctly_classified, 'TM_classified_as_male'))),'alpha', 0.005, 'method', 'approximate');
        
        % compute effect sizes:
        r = stats.zval/sqrt(sum(strcmp(merged_table.group, 'TM')));
        R2 = stats.zval^2/sum(strcmp(merged_table.group, 'TM'));
     
        % save statistics and effect sizes:
        wilcoxon_rank_sum_TM.h = h;
        wilcoxon_rank_sum_TM.p = p;
        wilcoxon_rank_sum_TM.stats = stats;
        wilcoxon_rank_sum_TM.r = r;
        wilcoxon_rank_sum_TM.R2 = R2;
        clear h p stats r R2
        save(fullfile(savedir, ['Wilcoxon_rank_sum_TIV_TM_classified_as_male_female_', dataname]), 'wilcoxon_rank_sum_TM')
    catch
        fprintf('Missing of two sides for wilcoxon test, not able to compare TM classified as either male or female in %s \n', dataname)
    end
    
    
%%% transgender women correct vs. women incorrect:
    try
        [p,h,stats] = ranksum(cell2mat(merged_table.TIV(strcmp(merged_table.sex_correctly_classified, 'TW_classified_as_male'))), cell2mat(merged_table.TIV(strcmp(merged_table.sex_correctly_classified, 'TW_classified_as_female'))),'alpha', 0.005, 'method', 'approximate');
        
        % compute effect sizes:
        r = stats.zval/sqrt(sum(strcmp(merged_table.group, 'TW')));
        R2 = stats.zval^2/sum(strcmp(merged_table.group, 'TW'));
     
        % save statistics and effect sizes:
        wilcoxon_rank_sum_TW.h = h;
        wilcoxon_rank_sum_TW.p = p;
        wilcoxon_rank_sum_TW.stats = stats;
        wilcoxon_rank_sum_TW.r = r;
        wilcoxon_rank_sum_TW.R2 = R2;
        clear h p stats r R2
        save(fullfile(savedir, ['Wilcoxon_rank_sum_TIV_TW_classified_as_male_female_', dataname]), 'wilcoxon_rank_sum_TW')
    catch
        fprintf('Missing of two sides for wilcoxon test, not able to compare TW classified as either male or female in %s \n', dataname)
    end
    