
function subfunction_07_01_create_violinplots_probabilities_test_samples(Path_2_merged_tables, savedir, dataname)

% load data:
load(fullfile(Path_2_merged_tables, ['merged_table_', dataname]));

% create new variable in table of sex renaming 'M' to 'men' and 'F' to
% 'women':

% create names for groups:
for i = 1:size(merged_table,1)
    if merged_table.sex{i} == 'F';
        merged_table.group{i} = 'women';
    elseif merged_table.sex{i} == 'M';
        merged_table.group{i} = 'men';
    end
end

% sortrow, so that males appear first:
merged_table = sortrows(merged_table, 'sex', 'descend');

% violinplot:
group = merged_table.group;
figure
hold on
vs = violinplot(merged_table.pred_proba_0, group);
vs(1).ViolinColor = [0 0.4470 0.7410];
vs(2).ViolinColor = [0.6350 0.0780 0.1840];
ylabel('assigned probability of being classified as male');
ylim([0 1]);
set(gca, 'FontSize', 15)
set(gca, 'LineWidth', 1.5)
hold off
%saveas(gcf, fullfile(savedir, ['violinplot_', dataname, '.svg']))
saveas(gcf, fullfile(savedir, ['violinplot_', dataname]), 'jpeg')
saveas(gcf, fullfile(savedir, ['violinplot_', dataname]))