
% function to combine the age-TIV-matched and age-matched tables,recheck
% again with ttests whether the distributions are as they should be and transform the 
% Paths to the 3mm Paths and write them in a txt-file

function function_05_combine_matched_tables_ttests_3mm_paths_txt(Path_2_matched_tables)

%%% create new directory to save the variables:
if ~exist('05_combined_matched_tables_ttests_txt_3mm_GMV_extraction', 'dir')
    mkdir('05_combined_matched_tables_ttests_txt_3mm_GMV_extraction')
end

savedir = fullfile(pwd, '05_combined_matched_tables_ttests_txt_3mm_GMV_extraction');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% create an overview of the matched_tables:
overview_matched_tables = dir(Path_2_matched_tables);

%choose only those big_tables, that are not a directory:
overview_only_tables = [];
n = 1;

for i = 1:size(overview_matched_tables)
    if overview_matched_tables(i).isdir == 1
        continue
    else
        overview_only_tables{n,1} = overview_matched_tables(i).name;
        n = n+1;
    end    
end
clear i n

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% iterate through all datasets and merge tables into two big tables
% (age-matched and age-TIV-matched):

big_table_merged_age_TIV_matched = table();
big_table_merged_age_matched = table();

n = 1;
while n < size(overview_only_tables,1) +1
    
    current_dataset = overview_only_tables{n};
    current_dataset = current_dataset(1:end-30);
    %current_dataset = erase(current_dataset, '_big_table_age_TIV_matched.mat');
    
    Path_age_TIV_matched_table = fullfile(Path_2_matched_tables, [current_dataset, '_big_table_age_TIV_matched.mat']);
    Path_age_matched_table = fullfile(Path_2_matched_tables, [current_dataset, '_big_table_age_matched.mat']);
    
    if (exist(Path_age_TIV_matched_table) == 2 && exist(Path_age_matched_table) == 2)
        
        load(Path_age_TIV_matched_table);
        big_table_merged_age_TIV_matched = [big_table_merged_age_TIV_matched; big_table_matched_subjects];
        clear big_table_matched_subjects
        
        load(Path_age_matched_table);
        big_table_merged_age_matched = [big_table_merged_age_matched; big_table_matched_subjects];
        clear big_table_matched_subjects
        
        n = n+2;
    else
        n = n+2;;
    end
end
clear n
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% add CoRR-tables:

% create an overview of the matched_tables:
overview_matched_CoRR_tables = dir(fullfile(Path_2_matched_tables, 'CoRR_tables'));

%choose only those big_tables, that are not a directory:
overview_only_tables_CoRR = [];
n = 1;

for i = 1:size(overview_matched_CoRR_tables)
    if overview_matched_CoRR_tables(i).isdir == 1
        continue
    else
        overview_only_tables_CoRR{n,1} = overview_matched_CoRR_tables(i).name;
        n = n+1;
    end    
end
clear i n


% iterate through all datasets and merge tables into two big tables
% (age-matched and age-TIV-matched):
n = 1;
while n < size(overview_only_tables_CoRR,1) +1
    
    current_dataset = overview_only_tables_CoRR{n};
    current_dataset = current_dataset(1:end-30);
    %current_dataset = erase(current_dataset, '_big_table_age_TIV_matched.mat');
    
    Path_age_TIV_matched_table = fullfile(Path_2_matched_tables, 'CoRR_tables', [current_dataset, '_big_table_age_TIV_matched.mat']);
    Path_age_matched_table = fullfile(Path_2_matched_tables, 'CoRR_tables',[current_dataset, '_big_table_age_matched.mat']);
    
    if (exist(Path_age_TIV_matched_table) == 2 && exist(Path_age_matched_table) == 2)
        
        load(Path_age_TIV_matched_table);
        big_table_merged_age_TIV_matched = [big_table_merged_age_TIV_matched; big_table_matched_subjects];
        clear big_table_matched_subjects
        
        load(Path_age_matched_table);
        big_table_merged_age_matched = [big_table_merged_age_matched; big_table_matched_subjects];
        clear big_table_matched_subjects
        
        n = n+2;
    else
        n = n+2;;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% ttests in separate function:
subfunction_05_01_ttests(savedir, big_table_merged_age_matched, big_table_merged_age_TIV_matched)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% create txt-files:

clearvars -except savedir

% age-TIV-matched table:
load(fullfile(savedir, 'big_table_age_TIV_matched'))

fid = fopen('big_table_age_TIV_matched.txt', 'wt');
for i = 1:size(big_table_merged_age_TIV_matched,1)
    fprintf(fid, '%s \n', big_table_merged_age_TIV_matched.Path{i});
end
fclose(fid);
clear i big_table_merged_age_TIV_matched


% age-matched table:
load(fullfile(savedir, 'big_table_age_matched'))

fid = fopen('big_table_age_matched.txt', 'wt');
for i = 1:size(big_table_merged_age_matched,1)
    fprintf(fid, '%s \n', big_table_merged_age_matched.Path{i});
end
fclose(fid);
clear i big_table_merged_age_matched

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% rename Paths in big_tables to 3mm Paths:

% age-TIV-matched table:
load(fullfile(savedir, 'big_table_age_TIV_matched'))
big_table = big_table_merged_age_TIV_matched;

for i = 1:size(big_table,1)
    old_Path_1mm = big_table.Path{i};
    new_Path_3mm = strrep(old_Path_1mm, 'cat_12.5','transgender_replication/data');
    big_table.Path(i) = {new_Path_3mm};
end
save(fullfile(savedir, 'big_table_age_TIV_matched_3mm_paths'), 'big_table')
clear big_table    


% age-matched table:
load(fullfile(savedir, 'big_table_age_matched'))
big_table = big_table_merged_age_matched;

for i = 1:size(big_table,1)
    old_Path_1mm = big_table.Path{i};
    new_Path_3mm = strrep(old_Path_1mm, 'cat_12.5','transgender_replication/data');
    big_table.Path(i) = {new_Path_3mm};
end
save(fullfile(savedir, 'big_table_age_matched_3mm_paths'), 'big_table')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% check that there is no overlap between the combined age-matched table and
% the combined age-TIV-matched table:

big_table_age_matched = load(fullfile(savedir, 'big_table_age_matched_3mm_paths.mat'));
big_table_age_matched = big_table_age_matched.big_table;

big_table_age_TIV_matched = load(fullfile(savedir, 'big_table_age_TIV_matched_3mm_paths.mat'));
big_table_age_TIV_matched = big_table_age_TIV_matched.big_table;
clear big_table

all_IDs = [big_table_age_matched.Subject; big_table_age_TIV_matched.Subject];

if size(unique(all_IDs),1) == size(all_IDs,1)
    fprintf('No overlap in combined age-matched table and combined age-TIV-matched table! \n')
else
    fprintf('Overlap in combined age-matched table and combined age-TIV-matched table! \n')
    exit
end
    

end
