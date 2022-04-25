
function subfunction_08_01_TIV_violinplots_test_samples(Path_2_merged_tables, savedir, dataname)


% load data:
load(fullfile(Path_2_merged_tables, ['merged_table_', dataname]));


%%% create new variable in table sorting subjects into correctly and not correctly classified males and
%%% females:

for i = 1:size(merged_table,1)
    if merged_table.sex{i} == 'M' & merged_table.pred(i) == 0
        merged_table.classified_sex_violinplot{i} = 'men classified as male';
        
    elseif merged_table.sex{i} == 'M' & merged_table.pred(i) == 1
        merged_table.classified_sex_violinplot{i} = 'men classified as female';
        
    elseif merged_table.sex{i} == 'F' & merged_table.pred(i) == 1
        merged_table.classified_sex_violinplot{i} = 'women classified as female';
        
    elseif merged_table.sex{i} == 'F' & merged_table.pred(i) == 0
        merged_table.classified_sex_violinplot{i} = 'women classified as male';
        
    end
end

merged_table = sortrows(merged_table, 'classified_sex_violinplot');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% violinplot:
group = merged_table.classified_sex_violinplot;
figure
hold on
vs = violinplot(cell2mat(merged_table.TIV), group, 'GroupOrder', {'men classified as male', 'men classified as female', 'women classified as female', 'women classified as male'});
vs(1).ViolinColor = [0 0.4470 0.7410];
vs(2).ViolinColor = [0 0.4470 0.7410];
vs(3).ViolinColor = [0.6350 0.0780 0.1840];
vs(4).ViolinColor = [0.6350 0.0780 0.1840];
ylabel('TIV');
ylim([1000 2000]);
%set(gca, 'FontSize', 15)
%set(gca, 'LineWidth', 1.5)
set(gca, 'FontSize', 22)
set(gca, 'LineWidth', 3)
hold off
%saveas(gcf, fullfile(savedir, ['violinplot_', dataname, '.svg']))
saveas(gcf, fullfile(savedir, ['violinplot_', dataname]), 'jpeg')
saveas(gcf, fullfile(savedir, ['violinplot_', dataname]))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
