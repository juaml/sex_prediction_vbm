

function subfunction_01_01_compute_demographic_variables_cisgender(big_table, dataname, plotname, savedir)

N = size(big_table,1);

index_females = strcmp(big_table.sex, 'F');
index_males = strcmp(big_table.sex, 'M');

N_males = size(big_table(index_males,:),1);
N_females = size(big_table(index_females,:),1);

age_all_subjects.min = min(cell2mat(big_table.age));
age_all_subjects.max = max(cell2mat(big_table.age));
age_all_subjects.mean = mean(cell2mat(big_table.age));
age_all_subjects.median = median(cell2mat(big_table.age));
age_all_subjects.std = std(cell2mat(big_table.age));

age_females.min = min(cell2mat(big_table.age(index_females)));
age_females.max = max(cell2mat(big_table.age(index_females)));
age_females.mean = mean(cell2mat(big_table.age(index_females)));
age_females.median = median(cell2mat(big_table.age(index_females)));
age_females.std = std(cell2mat(big_table.age(index_females)));

age_males.min = min(cell2mat(big_table.age(index_males)));
age_males.max = max(cell2mat(big_table.age(index_males)));
age_males.mean = mean(cell2mat(big_table.age(index_males)));
age_males.median = median(cell2mat(big_table.age(index_males)));
age_males.std = std(cell2mat(big_table.age(index_males)));

[h, p, ci, stats] = ttest2(cell2mat(big_table.age(index_females)), cell2mat(big_table.age(index_males)));
ttest_age.h = h;
ttest_age.p = p;
ttest_age.ci = ci;
ttest_age.stats = stats;
clear h p ci stats

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

TIV_all_subjects.min = min(cell2mat(big_table.TIV));
TIV_all_subjects.max = max(cell2mat(big_table.TIV));
TIV_all_subjects.mean = mean(cell2mat(big_table.TIV));
TIV_all_subjects.median = median(cell2mat(big_table.TIV));
TIV_all_subjects.std = std(cell2mat(big_table.TIV));

TIV_females.min = min(cell2mat(big_table.TIV(index_females)));
TIV_females.max = max(cell2mat(big_table.TIV(index_females)));
TIV_females.mean = mean(cell2mat(big_table.TIV(index_females)));
TIV_females.median = median(cell2mat(big_table.TIV(index_females)));
TIV_females.std = std(cell2mat(big_table.TIV(index_females)));

TIV_males.min = min(cell2mat(big_table.TIV(index_males)));
TIV_males.max = max(cell2mat(big_table.TIV(index_males)));
TIV_males.mean = mean(cell2mat(big_table.TIV(index_males)));
TIV_males.median = median(cell2mat(big_table.TIV(index_males)));
TIV_males.std = std(cell2mat(big_table.TIV(index_males)));

[h, p, ci, stats] = ttest2(cell2mat(big_table.TIV(index_females)), cell2mat(big_table.TIV(index_males)));
ttest_TIV.h = h;
ttest_TIV.p = p;
ttest_TIV.ci = ci;
ttest_TIV.stats = stats;
clear h p ci stats

save(fullfile(savedir, [dataname, '_sample_demographic_variables']), 'N', 'N_females', 'N_males', 'age_all_subjects', 'age_females', 'age_males', 'TIV_all_subjects', 'TIV_males', 'TIV_females')

save(fullfile(savedir, [dataname, '_sample_ttests']), 'ttest_age', 'ttest_TIV')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% create names for groups:
for i = 1:size(big_table,1)
    if big_table.sex{i} == 'F';
        group{i} = 'women';
    elseif big_table.sex{i} == 'M';
        group{i} = 'men';
    end
end

group = cellstr(group');

% Violinplot with title:
figure
hold on
vs = violinplot(cell2mat(big_table.TIV), group);
vs(1).ViolinColor = [0 0.4470 0.7410];
vs(2).ViolinColor = [0.6350 0.0780 0.1840];
ylabel('TIV');
ylim([1000 2000]);
set(gca, 'FontSize', 15)
set(gca, 'LineWidth', 1.5)
title(plotname)
hold off
saveas(gcf, fullfile(savedir, [dataname, '_plot_TIV_with_title']), 'jpeg')
saveas(gcf, fullfile(savedir, [dataname, '_plot_TIV_with_title']))


