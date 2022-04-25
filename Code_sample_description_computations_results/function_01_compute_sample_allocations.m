
% function to read out all sample-names:

function function_01_compute_sample_allocations(Path_2_single_big_tables, Path_2_big_tables,Path_2_analysis_input)

%%% create new directory to save the variables:
if ~exist('01_sample_allocations', 'dir')
    mkdir('01_sample_allocations')
end

savedir = fullfile(pwd, '01_sample_allocations');
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% list numbers of subjects in the big tables that went into the analysis:

% empty cell to fill in dataset-name and number of subjects in the respective table:
names_sample_site_single_big_tables = [];

% create list of tables:
table_overview = dir(Path_2_single_big_tables);

if isequal(table_overview(3).name, '.DS_Store')
    table_overview = table_overview(5:end);
else
    table_overview = table_overview(4:end);
end

% iterate through tables to write number of subjects in this table in
% 'sample_allocation' variable:
for i = 1:size(table_overview,1)
    load(fullfile(Path_2_single_big_tables, table_overview(i).name));
    names_sample_site_single_big_tables{i,1} = big_table.Sample_site(1);
    names_sample_site_single_big_tables{i,2} = size(big_table,1);
end
clear i
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% do the same for the CoRR-folder:
names_sample_site_single_big_tables_CoRR = [];

% create list of tables:
table_overview_CoRR = dir(fullfile(Path_2_single_big_tables, 'CoRR_tables'));

if isequal(table_overview_CoRR(3).name, '.DS_Store')
    table_overview_CoRR = table_overview_CoRR(4:end);
else
    table_overview_CoRR = table_overview_CoRR(3:end);
end

% iterate through CoRR-tables to write number of subjects in this table in
% 'sample_allocation' variable:
for i = 1:size(table_overview_CoRR,1)
    load(fullfile(Path_2_single_big_tables, 'CoRR_tables', table_overview_CoRR(i).name));
    
    if size(big_table,1) == 0
        continue
    end
    
    names_sample_site_single_big_tables_CoRR{i,1} = big_table.Sample_site(1);
    names_sample_site_single_big_tables_CoRR{i,2} = size(big_table,1);
end
clear i table_overview table_overview_CoRR

% concentate data:
names_sample_site_single_big_tables = [names_sample_site_single_big_tables; names_sample_site_single_big_tables_CoRR];

% save data:
save(fullfile(savedir, 'sample_allocation_single_big_tables_before_matching'), 'names_sample_site_single_big_tables')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load tables:

%%% age-matched (AM):

% big_table:
AM_big_table = load(fullfile(Path_2_big_tables, 'big_table_age_matched_3mm_paths.mat'));
AM_big_table = AM_big_table.big_table;

% train:
AM_train = load(fullfile(Path_2_analysis_input, 'age_matched_train_sample_80per_overview_table.mat'));
AM_train = AM_train.analysis_input_table;

% test:
AM_test = load(fullfile(Path_2_analysis_input, 'age_matched_test_sample_20_per_overview_table.mat'));
AM_test = AM_test.analysis_input_table;


%%% age-TIV-matched (ATM):

% big_table:
ATM_big_table = load(fullfile(Path_2_big_tables, 'big_table_age_TIV_matched_3mm_paths.mat'));
ATM_big_table = ATM_big_table.big_table;

% train:
ATM_train = load(fullfile(Path_2_analysis_input, 'age_TIV_matched_train_sample_80per_overview_table.mat'));
ATM_train = ATM_train.analysis_input_table;

% test:
ATM_test = load(fullfile(Path_2_analysis_input, 'age_TIV_matched_test_sample_20_per_overview_table.mat'));
ATM_test = ATM_test.analysis_input_table;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% compute sample allocations for big_tables:

% AM:
names_sample_site_AM = unique(AM_big_table.Sample_site);
for i = 1:size(names_sample_site_AM,1)
    names_sample_site_AM{i,2} = sum(count(AM_big_table.Sample_site, names_sample_site_AM{i,1}));
end

% ATM:
names_sample_site_ATM = unique(ATM_big_table.Sample_site);
for i = 1:size(names_sample_site_ATM,1)
    names_sample_site_ATM{i,2} = sum(count(ATM_big_table.Sample_site, names_sample_site_ATM{i,1}));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% compute sample allocations for training and test-sets:

%%% AM:

% training-set:
names_sample_site_AM_train = unique(AM_train.Sample_site);
for i = 1:size(names_sample_site_AM_train,1)
    names_sample_site_AM_train{i,2} = sum(count(AM_train.Sample_site, names_sample_site_AM_train{i,1}));
end

% test-set:
names_sample_site_AM_test = unique(AM_test.Sample_site);
for i = 1:size(names_sample_site_AM_test,1)
    names_sample_site_AM_test{i,2} = sum(count(AM_test.Sample_site, names_sample_site_AM_test{i,1}));
end


%%% ATM:

% training-set:
names_sample_site_ATM_train = unique(ATM_train.Sample_site);
for i = 1:size(names_sample_site_ATM_train,1)
    names_sample_site_ATM_train{i,2} = sum(count(ATM_train.Sample_site, names_sample_site_ATM_train{i,1}));
end

% test-set:
names_sample_site_ATM_test = unique(ATM_test.Sample_site);
for i = 1:size(names_sample_site_ATM_test,1)
    names_sample_site_ATM_test{i,2} = sum(count(ATM_test.Sample_site, names_sample_site_ATM_test{i,1}));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% save allocations:

save(fullfile(savedir, 'sample_allocation_AM_big_table'), 'names_sample_site_AM')
save(fullfile(savedir, 'sample_allocation_ATM_big_table'), 'names_sample_site_ATM')

save(fullfile(savedir, 'sample_allocation_AM_train'), 'names_sample_site_AM_train')
save(fullfile(savedir, 'sample_allocation_AM_test'), 'names_sample_site_AM_test')

save(fullfile(savedir, 'sample_allocation_ATM_train'), 'names_sample_site_ATM_train')
save(fullfile(savedir, 'sample_allocation_ATM_test'), 'names_sample_site_ATM_test')

