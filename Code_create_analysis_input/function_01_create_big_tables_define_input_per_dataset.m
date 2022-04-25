
% function to create inital tables of all datasets having structural data
% in the cat_12.5 folder on Juseless and meeting the criteria (age-range,
% healthy control)

function function_01_create_big_tables_define_input_per_dataset(Path_2_cat12, Path_2_lookups, min_age, max_age)

%%% create new directory to save the variables:
if ~exist('01_big_tables', 'dir')
    mkdir('01_big_tables')
end

savedir = fullfile(pwd, '01_big_tables');
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% 1000Brains:

dataset = '1000Gehirne';
name_lookup = 'FZJ_1000';
site_folder = 0;
folder_name = '';
ses = 1;
subfunction_01_01_create_big_table(Path_2_cat12, Path_2_lookups, savedir, dataset, name_lookup, site_folder, folder_name, ses, min_age, max_age)

%%% CamCAN:
dataset = 'CamCAN';
name_lookup = 'CamCAN';
site_folder = 0;
folder_name = '';
ses = 0;
subfunction_01_01_create_big_table(Path_2_cat12, Path_2_lookups, savedir, dataset, name_lookup, site_folder, folder_name, ses, min_age, max_age)

%%% DLBS:
dataset = 'DLBS';
name_lookup = 'DLBS';
site_folder = 0;
folder_name = '';
ses = 1;
subfunction_01_01_create_big_table(Path_2_cat12, Path_2_lookups, savedir, dataset, name_lookup, site_folder, folder_name, ses, min_age, max_age)

%%% eNKI:
dataset = 'eNKI';
name_lookup = 'eNKI';
site_folder = 0;
folder_name = '';
ses = 1;
subfunction_01_01_create_big_table(Path_2_cat12, Path_2_lookups, savedir, dataset, name_lookup, site_folder, folder_name, ses, min_age, max_age)

%%% GOBS_CIVET:
dataset = 'GOBS_CIVET';
name_lookup = 'GOBS_CIVET';
site_folder = 0;
folder_name = '';
ses = 0;
subfunction_01_01_create_big_table(Path_2_cat12, Path_2_lookups, savedir, dataset, name_lookup, site_folder, folder_name, ses, min_age, max_age)

%%% HCP:
dataset = 'HCP';
name_lookup = 'HCP_s1200';
site_folder = 0;
folder_name = '';
ses = 0;
subfunction_01_01_create_big_table(Path_2_cat12, Path_2_lookups, savedir, dataset, name_lookup, site_folder, folder_name, ses, min_age, max_age)

%%% OASIS3:
dataset = 'OASIS3';
name_lookup = 'OASIS3';
site_folder = 0;
folder_name = '';
ses = 1;
subfunction_01_01_create_big_table(Path_2_cat12, Path_2_lookups, savedir, dataset, name_lookup, site_folder, folder_name, ses, min_age, max_age)

%%% PNC:
dataset = 'PNC';
name_lookup = 'PNC';
site_folder = 0;
folder_name = '';
ses = 0;
subfunction_01_01_create_big_table(Path_2_cat12, Path_2_lookups, savedir, dataset, name_lookup, site_folder, folder_name, ses, min_age, max_age)


%%% IXI:
dataset = 'IXI';
name_lookup = 'IXI';
site_folder = 1;
ses = 0;

names_folder = {'Guys'; 'HH'; 'IOP'};

for i = 1:size(names_folder,1)
    folder_name = names_folder{i};
    subfunction_01_01_create_big_table(Path_2_cat12, Path_2_lookups, savedir, dataset, name_lookup, site_folder, folder_name, ses, min_age, max_age)
end


%%% CoRR:
% define new savedir, since the CoRR-tables are a lot:

if ~exist(fullfile('01_big_tables','CoRR_tables'), 'dir')
    mkdir(fullfile('01_big_tables','CoRR_tables'))
end

savedir = fullfile(pwd, '01_big_tables','CoRR_tables');

dataset = 'CoRR';
name_lookup = 'CoRR';
site_folder = 1;
ses = 1;

names_folder = {'BMB_1'; 'BNU_1'; 'BNU_2'; 'BNU_3'; 'HNU_1'; 'IACAS'; 'IBA_TRT'; 'IPCAS_1'; 'IPCAS_2'; 'IPCAS_3'; 'IPCAS_4'; 'IPCAS_5'; 'IPCAS_6'; 'IPCAS_7'; 'IPCAS_8'; 'JHNU'; 'LMU_1'; 'LMU_2'; 'LMU_3'; 'MPG_1'; 'MRN'; 'NKI_TRT'; 'NYU_1'; 'NYU_2'; 'SWU_1'; 'SWU_2'; 'SWU_3'; 'SWU_4'; 'UM'; 'UPSM_1'; 'Utah_1'; 'Utah_2'; 'UWM'; 'XHCUMS'};

for i = 1:size(names_folder,1)
    folder_name = names_folder{i};
    subfunction_01_01_create_big_table(Path_2_cat12, Path_2_lookups, savedir, dataset, name_lookup, site_folder, folder_name, ses, min_age, max_age)
end

