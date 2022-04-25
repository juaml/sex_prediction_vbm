

function function_03_big_tables_exclude_TIV_outlier(Path_2_raw_big_tables)

%%% create new directory to save the variables:
if ~exist('03_big_tables_TIV_outlier_excluded', 'dir')
    mkdir('03_big_tables_TIV_outlier_excluded')
end

savedir = fullfile(pwd, '03_big_tables_TIV_outlier_excluded');
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load descriptive statistics of TIV of the previous folder:
load(fullfile(pwd, '02_plot_TIV_all_tables', 'descriptive_TIV_statistics'));

TIV_mean_plus_3std = TIV_descr_stats.mean + (3 * TIV_descr_stats.std);
TIV_mean_minus_3std = TIV_descr_stats.mean - (3 * TIV_descr_stats.std);


%%% iterate through all tables of the folder 01_big_tables and exclude
%%% subjects that have TIV-value higher/lower than 3std from the overall
%%% mean:

Overview_tables_01_big_tables = dir(Path_2_raw_big_tables);
% delete the first 3 rows, the rest are the tables
Overview_tables_01_big_tables = Overview_tables_01_big_tables(4:end);


for i = 1:size(Overview_tables_01_big_tables,1)
    
    new_big_table = table();
    m = 1;
    
    load(fullfile(Path_2_raw_big_tables, Overview_tables_01_big_tables(i).name));
    fprintf('Working on excluding TIV outlier in dataset %s \n', Overview_tables_01_big_tables(i).name)
     
    for ii = 1:size(big_table,1)
        if big_table.TIV{ii} < TIV_mean_minus_3std | big_table.TIV{ii} > TIV_mean_plus_3std
            continue
        else
            new_big_table(m,:) = big_table(ii,:);
            m = m+1;
        end
    end
    
    % save new big_table as big table again:
    clear big_table
    big_table = new_big_table;
    save(fullfile(savedir, Overview_tables_01_big_tables(i).name), 'big_table')

end

clear i ii

%%% create new directory to save the variables:
if ~exist('03_big_tables_TIV_outlier_excluded/CoRR_tables', 'dir')
    mkdir('03_big_tables_TIV_outlier_excluded/CoRR_tables')
end


% similar procedure as above with the CoRR tables:
Overview_CoRR_tables = dir(fullfile(Path_2_raw_big_tables, 'CoRR_tables'));
% delete the first 2 rows, the rest are the tables
Overview_CoRR_tables = Overview_CoRR_tables(3:end);


for i = 1:size(Overview_CoRR_tables,1)
    
    new_big_table = table();
    m = 1;
    
    load(fullfile(Path_2_raw_big_tables, 'CoRR_tables', Overview_CoRR_tables(i).name));
    fprintf('Working on excluding TIV outlier in dataset %s \n', Overview_CoRR_tables(i).name)

    
    for ii = 1:size(big_table,1)
        if big_table.TIV{ii} < TIV_mean_minus_3std | big_table.TIV{ii} > TIV_mean_plus_3std
            continue
        else
            new_big_table(m,:) = big_table(ii,:);
            m = m+1;
        end
    end
    
    % save new big_table as big table again:
    clear big_table
    big_table = new_big_table;
    save(fullfile(savedir, 'CoRR_tables', Overview_CoRR_tables(i).name), 'big_table')

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Check whether excluding outlier worked:

%%% combine all new tables:

combined_new_big_table = table();

Overview_tables_03_big_tables = dir(savedir);
% delete the first 3 rows, the rest are the tables
Overview_tables_03_big_tables = Overview_tables_03_big_tables(4:end);

for i = 1:size(Overview_tables_03_big_tables,1)
    
    load(fullfile(savedir, Overview_tables_03_big_tables(i).name));
    combined_new_big_table = [combined_new_big_table; big_table];
end


% add CoRR tables:
Overview_CoRR_tables = dir(fullfile(savedir, 'CoRR_tables'));
% delete the first 2 rows, the rest are the tables
Overview_CoRR_tables = Overview_CoRR_tables(3:end);

for ii = 1:size(Overview_CoRR_tables,1)
    
    load(fullfile(savedir, 'CoRR_tables', Overview_CoRR_tables(ii).name));
    combined_new_big_table = [combined_new_big_table; big_table];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if min(cell2mat(combined_new_big_table.TIV)) > TIV_mean_minus_3std & max(cell2mat(combined_new_big_table.TIV)) < TIV_mean_plus_3std
    fprintf('Excluding TIV outlier worked! \n')
else
    fprintf('Excluding TIV outlier did not work! Need to recheck! \n')
    return
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load old combined table to check how many subjects were deleted:
load(fullfile(pwd, '02_plot_TIV_all_tables', 'combined_big_tables.mat'));

nr_deleted_subjects = size(combined_big_table,1) - size(combined_new_big_table,1);
fprintf('%i subjects were deleted due to high or low TIV above 3 std borders!  \n', nr_deleted_subjects)

fprintf('%i subjects are overall in all big_tables after excluding TIV outlier and before matching procedure! \n', size(combined_new_big_table,1))
