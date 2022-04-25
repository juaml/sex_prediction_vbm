

function subfunction_02_02_compute_demographic_variables_transgender(big_table, dataname, plotname, savedir)

N = size(big_table,1);

index_CM = strcmp(big_table.group, 'CM');
index_CW = strcmp(big_table.group, 'CW');
index_TM = strcmp(big_table.group, 'TM');
index_TW = strcmp(big_table.group, 'TW');
        
N_CM = sum(index_CM);
N_CW = sum(index_CW);
N_TM = sum(index_TM);
N_TW = sum(index_TW);


age_all_subjects.min = min(cell2mat(big_table.age));
age_all_subjects.max = max(cell2mat(big_table.age));
age_all_subjects.mean = mean(cell2mat(big_table.age));
age_all_subjects.median = median(cell2mat(big_table.age));
age_all_subjects.std = std(cell2mat(big_table.age));

age_CM.min = min(cell2mat(big_table.age(index_CM)));
age_CM.max = max(cell2mat(big_table.age(index_CM)));
age_CM.mean = mean(cell2mat(big_table.age(index_CM)));
age_CM.median = median(cell2mat(big_table.age(index_CM)));
age_CM.std = std(cell2mat(big_table.age(index_CM)));

age_CW.min = min(cell2mat(big_table.age(index_CW)));
age_CW.max = max(cell2mat(big_table.age(index_CW)));
age_CW.mean = mean(cell2mat(big_table.age(index_CW)));
age_CW.median = median(cell2mat(big_table.age(index_CW)));
age_CW.std = std(cell2mat(big_table.age(index_CW)));

age_TM.min = min(cell2mat(big_table.age(index_TM)));
age_TM.max = max(cell2mat(big_table.age(index_TM)));
age_TM.mean = mean(cell2mat(big_table.age(index_TM)));
age_TM.median = median(cell2mat(big_table.age(index_TM)));
age_TM.std = std(cell2mat(big_table.age(index_TM)));

age_TW.min = min(cell2mat(big_table.age(index_TW)));
age_TW.max = max(cell2mat(big_table.age(index_TW)));
age_TW.mean = mean(cell2mat(big_table.age(index_TW)));
age_TW.median = median(cell2mat(big_table.age(index_TW)));
age_TW.std = std(cell2mat(big_table.age(index_TW)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

TIV_all_subjects.min = min(cell2mat(big_table.TIV));
TIV_all_subjects.max = max(cell2mat(big_table.TIV));
TIV_all_subjects.mean = mean(cell2mat(big_table.TIV));
TIV_all_subjects.median = median(cell2mat(big_table.TIV));
TIV_all_subjects.std = std(cell2mat(big_table.TIV));

TIV_CM.min = min(cell2mat(big_table.TIV(index_CM)));
TIV_CM.max = max(cell2mat(big_table.TIV(index_CM)));
TIV_CM.mean = mean(cell2mat(big_table.TIV(index_CM)));
TIV_CM.median = median(cell2mat(big_table.TIV(index_CM)));
TIV_CM.std = std(cell2mat(big_table.TIV(index_CM)));

TIV_CW.min = min(cell2mat(big_table.TIV(index_CW)));
TIV_CW.max = max(cell2mat(big_table.TIV(index_CW)));
TIV_CW.mean = mean(cell2mat(big_table.TIV(index_CW)));
TIV_CW.median = median(cell2mat(big_table.TIV(index_CW)));
TIV_CW.std = std(cell2mat(big_table.TIV(index_CW)));

TIV_TM.min = min(cell2mat(big_table.TIV(index_TM)));
TIV_TM.max = max(cell2mat(big_table.TIV(index_TM)));
TIV_TM.mean = mean(cell2mat(big_table.TIV(index_TM)));
TIV_TM.median = median(cell2mat(big_table.TIV(index_TM)));
TIV_TM.std = std(cell2mat(big_table.TIV(index_TM)));

TIV_TW.min = min(cell2mat(big_table.TIV(index_TW)));
TIV_TW.max = max(cell2mat(big_table.TIV(index_TW)));
TIV_TW.mean = mean(cell2mat(big_table.TIV(index_TW)));
TIV_TW.median = median(cell2mat(big_table.TIV(index_TW)));
TIV_TW.std = std(cell2mat(big_table.TIV(index_TW)));

save(fullfile(savedir, [dataname, '_sample_demographic_variables']), 'N', 'N_CM', 'N_CW', 'N_TM', 'N_TW', 'age_all_subjects', 'age_CM', 'age_CW', 'age_TM', 'age_TW', 'TIV_all_subjects', 'TIV_CM', 'TIV_CW', 'TIV_TM', 'TIV_TW')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Violinplots:
group = big_table.group;

% Violinplot without title (APA-style):
figure
hold on
vs = violinplot(cell2mat(big_table.TIV), group)
vs(1).ViolinColor = [0 0.4470 0.7410];
vs(2).ViolinColor = [0.6350 0.0780 0.1840];
vs(3).ViolinColor = [0.8500 0.3250 0.0980];
vs(4).ViolinColor = [0.3010 0.7450 0.9330];
ylabel('TIV');
ylim([1000 2000]);
set(gca, 'FontSize', 15)
set(gca, 'LineWidth', 1.5)
title(plotname)
hold off
saveas(gcf, fullfile(savedir, [dataname, '_plot_TIV_with_title']), 'jpeg')
saveas(gcf, fullfile(savedir, [dataname, '_plot_TIV_with_title']))
