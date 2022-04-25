
% function to match males and females, once for age and once for age and
% TIV

function function_04_prepare_matching(Path_2_clean_big_tables, max_age_diff, max_TIV_diff)

%%% create new directory to save the variables:
if ~exist('04_within_sample_site_matched_tables', 'dir')
    mkdir('04_within_sample_site_matched_tables')
end

savedir = fullfile(pwd, '04_within_sample_site_matched_tables');
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% create overview of all big_tables in the "cleaned big tables" directory:

overview_clean_big_tables = dir(Path_2_clean_big_tables);

%choose only those big_tables, that are not a directory:
overview_only_tables = [];
n = 1;

for i = 1:size(overview_clean_big_tables)
    if overview_clean_big_tables(i).isdir == 1
        continue
    else
        overview_only_tables{n,1} = overview_clean_big_tables(i).name;
        n = n+1;
    end
    
end
clear i n

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% matching for all datasets:

% iterate through all datasets and provide age-TIV matching and
% age-matching:

for ii = 1:size(overview_only_tables,1)
    load(fullfile(Path_2_clean_big_tables, overview_only_tables{ii}));
    
    % define dataset the function is currently working in:
    dataset = big_table.Sample_site{1};
    
    if not (isempty(strfind(dataset, '/')))
        dataset = strrep(dataset, '/', '_');
    end
    
    % age-TIV-matching:
    
    %fprintf('Working on age-TIV-matching for dataset %s \n', dataset)
    subfunction_04_01_age_TIV_matching(savedir, big_table, max_age_diff, max_TIV_diff, dataset)
    
    % in case the age-TIV-matched table only contains 1 match (2 subjects),
    % move on to the next dataset and delete the age-TIV-matched table,
    % otherwise continue with age-matching:
    age_TIV_matched_table = fullfile(savedir, [dataset ,'_big_table_age_TIV_matched.mat']);
    load(age_TIV_matched_table);
    
    if size(big_table_matched_subjects,1) < 5
        delete(age_TIV_matched_table)
        continue
    end
        
    % age-matching:
    
    %fprintf('Working on age-matching for dataset %s \n', dataset)
    subfunction_04_02_age_matching(savedir, big_table, max_age_diff, dataset)
    
    % ensure a similar age-distribution between age-matched and
    % age-TIV-matched data:
    
    %fprintf('Working on adjusting age-distribution for dataset %s \n', dataset)
    subfunction_04_03_adjust_age_distribution(savedir, dataset)
        
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear savedir

%%% create new directory to save the variables:
if ~exist(fullfile('04_within_sample_site_matched_tables', 'CoRR_tables'), 'dir')
    mkdir(fullfile('04_within_sample_site_matched_tables', 'CoRR_tables'))
end

savedir = fullfile(pwd, '04_within_sample_site_matched_tables', 'CoRR_tables');
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% create overview of all big_tables of the CoRR-dataset in the "cleaned big tables" directory:
clear overview_clean_big_tables overview_only_tables

overview_clean_CoRR_big_tables = dir(fullfile(Path_2_clean_big_tables, 'CoRR_tables'));

%choose only those big_tables, that are not a directory:
overview_only_tables = [];
n = 1;

for i = 1:size(overview_clean_CoRR_big_tables)
    if overview_clean_CoRR_big_tables(i).isdir == 1
        continue
    else
        overview_only_tables{n,1} = overview_clean_CoRR_big_tables(i).name;
        n = n+1;
    end
    
end
clear i n

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% matching for all CoRR-datasets:

% iterate through all CoRR-datasets and provide age-TIV matching and
% age-matching:

for ii = 1:size(overview_only_tables,1)
    load(fullfile(Path_2_clean_big_tables, 'CoRR_tables', overview_only_tables{ii}));
    
    if size(big_table,1) < 6
        continue
    end
    
    % define dataset the function is currently working in:
    dataset = big_table.Sample_site{1};
    if not (isempty(strfind(dataset, '/')))
        dataset = strrep(dataset, '/', '_');
    end
    
    % age-TIV-matching:
    
    %fprintf('Working on age-TIV-matching for dataset %s \n', dataset)
    subfunction_04_01_age_TIV_matching(savedir, big_table, max_age_diff, max_TIV_diff, dataset)
    
    % in the CoRR-dataset, it might be that the age-TIV-matched dataset was
    % not saved since there were not enough subjects to match, in this
    % case, no age-matching takes place, instead move on to the next Site
    % of CoRR:
    if not (exist(fullfile(savedir, [dataset, '_big_table_age_TIV_matched.mat'])))
        continue
    end
    
    % in case the age-TIV-matched table only contains 1 match (2 subjects),
    % move on to the next dataset and delete the age-TIV-matched table,
    % otherwise continue with age-matching:
    age_TIV_matched_table = fullfile(savedir, [dataset ,'_big_table_age_TIV_matched.mat']);
    load(age_TIV_matched_table);
    
    if size(big_table_matched_subjects,1) < 5
        delete(age_TIV_matched_table)
        continue
    end
    
    % age-matching:
    
    %fprintf('Working on age-matching for dataset %s \n', big_table.Sample_site{1})
    subfunction_04_02_age_matching(savedir, big_table, max_age_diff, dataset)  
    
    % ensure a similar age-distribution between age-matched and
    % age-TIV-matched data:
    
    %fprintf('Working on adjusting age-distribution for dataset %s \n', dataset)
    subfunction_04_03_adjust_age_distribution(savedir, dataset)
     
end

