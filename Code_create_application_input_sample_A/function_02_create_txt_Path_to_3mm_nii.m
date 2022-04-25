% function to create txt-file with Paths to niftis to get cat-data with 3mm
% resolution and to create a new table with these 3mm Paths

function function_02_create_txt_Path_to_3mm_nii(Path_2_big_table)

%%% create new directory to save the variables:
if ~exist(fullfile('02_big_table_3mm_paths'), 'dir')
    mkdir('02_big_table_3mm_paths')
end

savedir = fullfile(pwd, '02_big_table_3mm_paths');
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% create txt-files:

load(fullfile(Path_2_big_table, 'big_table_Aachen_transgender_data.mat'));

fid = fopen('big_table_Aachen_transgender_data.txt', 'wt');
for i = 1:size(big_table,1)
    fprintf(fid, '%s \n', big_table.Path{i});
end
fclose(fid)
clear i

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% rename Path in big_tables to 3mm Paths:

% add .gz at the end of each path in table with 1mm paths:
for i = 1:size(big_table,1)
    old_Path_1mm = big_table.Path{i};
    new_Path_3mm = strrep(old_Path_1mm, '.nii', '.nii.gz');
    big_table.Path(i) = {new_Path_3mm};
end
clear i old_Path_1mm new_Path_3mm


for i = 1:size(big_table,1)
    old_Path_1mm = big_table.Path{i};
    new_Path_3mm = strrep(old_Path_1mm, 'cat_12.5', 'cat_12.5_3mm_resolution/data');
    big_table.Path(i) = {new_Path_3mm};
end
clear i old_Path_1mm new_Path_3mm

save(fullfile(savedir, 'big_table_Aachen_transgender_data_3mm_paths'), 'big_table')


