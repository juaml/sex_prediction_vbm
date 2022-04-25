% function to combine all raw tables for their TIV-information; calculate
% descriptive statistics of TIV and exclude possible outlier:

function function_02_plot_TIV_all_subjects(Path_2_raw_big_tables)

%%% create new directory to save the variables:
if ~exist('02_plot_TIV_all_tables', 'dir')
    mkdir('02_plot_TIV_all_tables')
end

savedir = fullfile(pwd, '02_plot_TIV_all_tables');
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% combine all tables together:

combined_big_table = table();

Overview_tables_01_big_tables = dir(Path_2_raw_big_tables);
% delete the first 3 rows, the rest are the tables
Overview_tables_01_big_tables = Overview_tables_01_big_tables(4:end);

for i = 1:size(Overview_tables_01_big_tables,1)
    
    load(fullfile(Path_2_raw_big_tables, Overview_tables_01_big_tables(i).name));
    combined_big_table = [combined_big_table; big_table];
end


% add CoRR tables:
Overview_CoRR_tables = dir(fullfile(Path_2_raw_big_tables, 'CoRR_tables'));
% delete the first 2 rows, the rest are the tables
Overview_CoRR_tables = Overview_CoRR_tables(3:end);

for ii = 1:size(Overview_CoRR_tables,1)
    load(fullfile(Path_2_raw_big_tables, 'CoRR_tables', Overview_CoRR_tables(ii).name));
    combined_big_table = [combined_big_table; big_table];
end

save(fullfile(savedir, 'combined_big_tables'), 'combined_big_table')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% plot TIV distribution:
figure
hold on
histogram(cell2mat(combined_big_table.TIV))
ylabel('Frequency in subjects')
xlabel('Total Intracranial Volume (TIV)')
title('TIV in all subjects combined together')
hold off
saveas(gcf, fullfile(savedir, 'plot_TIV_all_subjects'), 'jpeg')


%%% calculate descriptive TIV statistics:
TIV_descr_stats.min = min(cell2mat(combined_big_table.TIV));
TIV_descr_stats.max = max(cell2mat(combined_big_table.TIV));
TIV_descr_stats.mean = mean(cell2mat(combined_big_table.TIV));
TIV_descr_stats.median = median(cell2mat(combined_big_table.TIV));
TIV_descr_stats.std = std(cell2mat(combined_big_table.TIV));

save(fullfile(savedir, 'descriptive_TIV_statistics'), 'TIV_descr_stats')
