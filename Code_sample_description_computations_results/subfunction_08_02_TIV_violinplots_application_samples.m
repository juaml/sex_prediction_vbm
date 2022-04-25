
function subfunction_08_02_TIV_violinplots_application_samples(Path_2_merged_tables, savedir, dataname)

% load data:
load(fullfile(Path_2_merged_tables, ['merged_table_', dataname]));

%%% create new variable in table sorting subjects into correctly and not correctly classified males and
%%% females:

for i = 1:size(merged_table,1)
    if isequal(merged_table.group{i},'CM') & merged_table.pred(i) == 0
        merged_table.classified_sex{i} = 'CM classified as male';
    elseif isequal(merged_table.group{i},'CM') & merged_table.pred(i) == 1
        merged_table.classified_sex{i} = 'CM classified as female';
    elseif isequal(merged_table.group{i},'CW') & merged_table.pred(i) == 0
        merged_table.classified_sex{i} = 'CW classified as male';
    elseif isequal(merged_table.group{i},'CW') & merged_table.pred(i) == 1
        merged_table.classified_sex{i} = 'CW classified as female'; 
        
    elseif isequal(merged_table.group{i},'TM') & merged_table.pred(i) == 0
        merged_table.classified_sex{i} = 'TM classified as male';
    elseif isequal(merged_table.group{i},'TM') & merged_table.pred(i) == 1
        merged_table.classified_sex{i} = 'TM classified as female';
    elseif isequal(merged_table.group{i},'TW') & merged_table.pred(i) == 0
        merged_table.classified_sex{i} = 'TW classified as male'; 
    elseif isequal(merged_table.group{i},'TW') & merged_table.pred(i) == 1
        merged_table.classified_sex{i} = 'TW classified as female';
    end
end

merged_table = sortrows(merged_table, 'classified_sex');

% in case there are missing incorrect classified subjects, fill table with
% subjects having a TIV of 0, so that the name is displayed in the boxplot
% but not the TIV itself:

% CM classified as female:
if sum(strcmp('CM classified as female', merged_table.classified_sex)) == 0
    n = size(merged_table,1) +1;
    merged_table.TIV{n} = 0;
    merged_table.classified_sex{n} = 'CM classified as female';
    merged_table.sex{n} = 'M';
    merged_table.gender{n} = 'M';
end

% CW classified as male:
if sum(strcmp('CW classified as male', merged_table.classified_sex)) == 0
    n = size(merged_table,1) +1;
    merged_table.TIV{n} = 0;
    merged_table.classified_sex{n} = 'CW classified as male';
    merged_table.sex{n} = 'F';
    merged_table.gender{n} = 'F';
end

% TM classified as male:
if sum(strcmp('TM classified as male', merged_table.classified_sex)) == 0
    n = size(merged_table,1) +1;
    merged_table.TIV{n} = 0;
    merged_table.classified_sex{n} = 'TM classified as male';
    merged_table.sex{n} = 'F';
    merged_table.gender{n} = 'M';
end

% TW classified as female:
if sum(strcmp('TW classified as female', merged_table.classified_sex)) == 0
    n = size(merged_table,1) +1;
    merged_table.TIV{n} = 0;
    merged_table.classified_sex{n} = 'TW classified as female';
    merged_table.sex{n} = 'M';
    merged_table.gender{n} = 'F';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% split table into cis- and transgender individuals:

cisgender_table = table();
n = 1;
for i = 1:size(merged_table)
    if merged_table.sex{i} == merged_table.gender{i};
        cisgender_table(n,:) = merged_table(i,:);
        n = n+1;
    end
end
clear n i

transgender_table = table();
n = 1;
for i = 1:size(merged_table)
    if merged_table.sex{i} ~= merged_table.gender{i};
        transgender_table(n,:) = merged_table(i,:);
        n = n+1;
    end
end
clear n i


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% violinplot:

group = cisgender_table.classified_sex;
figure
hold on
vs = violinplot(cell2mat(cisgender_table.TIV), group, 'GroupOrder', {'CM classified as male', 'CM classified as female', 'CW classified as female', 'CW classified as male'});
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
saveas(gcf, fullfile(savedir, ['violinplot_cisgender_', dataname]), 'jpeg')
saveas(gcf, fullfile(savedir, ['violinplot_cisgender_', dataname]))


group = transgender_table.classified_sex;
figure
hold on
vs = violinplot(cell2mat(transgender_table.TIV), group, 'GroupOrder', {'TW classified as male', 'TW classified as female', 'TM classified as female', 'TM classified as male'});
vs(1).ViolinColor = [0.3010 0.7450 0.9330];
vs(2).ViolinColor = [0.3010 0.7450 0.9330];
vs(3).ViolinColor = [0.8500 0.3250 0.0980];
vs(4).ViolinColor = [0.8500 0.3250 0.0980];
ylabel('TIV');
ylim([1000 2000]);
%set(gca, 'FontSize', 15)
%set(gca, 'LineWidth', 1.5)
set(gca, 'FontSize', 22)
set(gca, 'LineWidth', 3)
hold off
%saveas(gcf, fullfile(savedir, ['violinplot_', dataname, '.svg']))
saveas(gcf, fullfile(savedir, ['violinplot_transgender_', dataname]), 'jpeg')
saveas(gcf, fullfile(savedir, ['violinplot_transgender_', dataname]))
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
