
function subfunction_06_01_create_violinplots_probabilities_appl_samples(Path_2_merged_tables, savedir, dataname)

% load data:
load(fullfile(Path_2_merged_tables, ['merged_table_', dataname]));

if isequal(dataname(1:9), 'barcelona') 
    merged_table = sortrows(merged_table, 'group');
end

% violinplot:
group = merged_table.group;
figure
hold on
vs = violinplot(merged_table.pred_proba_0, group);
vs(1).ViolinColor = [0 0.4470 0.7410];
vs(2).ViolinColor = [0.6350 0.0780 0.1840];
vs(3).ViolinColor = [0.8500 0.3250 0.0980];
vs(4).ViolinColor = [0.3010 0.7450 0.9330];
ylabel('assigned probability of being classified as male');
ylim([0 1]);
set(gca, 'FontSize', 15)
set(gca, 'LineWidth', 1.5)
hold off
%saveas(gcf, fullfile(savedir, ['violinplot_', dataname, '.svg']))
saveas(gcf, fullfile(savedir, ['violinplot_', dataname]), 'jpeg')
saveas(gcf, fullfile(savedir, ['violinplot_', dataname]))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% computation of ttests and CohensD:

[h,p,ci,stats] = ttest2(merged_table.pred_proba_0(strcmp(merged_table.group, 'CM')), merged_table.pred_proba_0(strcmp(merged_table.group, 'TW')));
ttest_CM_TW.h = h;
ttest_CM_TW.p = p;
ttest_CM_TW.ci = ci;
ttest_CM_TW.stats = stats;
clear h p stats r ci
save(fullfile(savedir, ['Ttest_probability_CM_TW_', dataname]), 'ttest_CM_TW')

[h,p,ci,stats] = ttest2(merged_table.pred_proba_0(strcmp(merged_table.group, 'CW')), merged_table.pred_proba_0(strcmp(merged_table.group, 'TM')));
ttest_CW_TM.h = h;
ttest_CW_TM.p = p;
ttest_CW_TM.ci = ci;
ttest_CW_TM.stats = stats;
clear h p stats r ci
save(fullfile(savedir, ['Ttest_probability_CW_TM_', dataname]), 'ttest_CW_TM')


d = computeCohen_d(merged_table.pred_proba_0(strcmp(merged_table.group, 'CM')), merged_table.pred_proba_0(strcmp(merged_table.group, 'TW')));
save(fullfile(savedir, ['CohensD_probability_CM_TW_', dataname]), 'd')
clear d

d = computeCohen_d(merged_table.pred_proba_0(strcmp(merged_table.group, 'CW')), merged_table.pred_proba_0(strcmp(merged_table.group, 'TM')));
save(fullfile(savedir, ['CohensD_probability_CW_TM_', dataname]), 'd')
clear d