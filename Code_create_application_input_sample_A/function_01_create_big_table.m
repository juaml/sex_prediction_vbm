
% function to create big_table for Aachen data:

function function_01_create_big_table(Path_2_table, Path_2_cat_data)

%%% create new directory to save the variables:
if ~exist(fullfile('01_big_table'), 'dir')
    mkdir('01_big_table')
end

savedir = fullfile(pwd, '01_big_table');
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% import sheets from Excel:

%%% demographic data:

% Import the data
[~, ~, raw] = xlsread(Path_2_table,'Demo');
raw = raw(4:end,:);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
stringVectors = string(raw(:,[2,7]));
stringVectors(ismissing(stringVectors)) = '';
raw = raw(:,[1,3,4,5,6]);

% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

% Create output variable
data = reshape([raw{:}],size(raw));

% Create table
Demograhphic_overview = table;

% Allocate imported array to column variable names
Demograhphic_overview.VarName1 = data(:,1);
Demograhphic_overview.ID = stringVectors(:,1);
Demograhphic_overview.Age = data(:,2);
Demograhphic_overview.Handness = data(:,3);
Demograhphic_overview.EducationLevel = data(:,4);
Demograhphic_overview.HormonalTreatment = data(:,5);
Demograhphic_overview.VarName7 = stringVectors(:,2);

% Clear temporary variables
clearvars data raw stringVectors R;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Import the data
[~, ~, raw] = xlsread(Path_2_table,'TIV');
raw = raw(3:end,:);
stringVectors = string(raw(:,[1,2,3,4,5,6]));
stringVectors(ismissing(stringVectors)) = '';

% Create table
Brain_data_overview = table;

% Allocate imported array to column variable names
Brain_data_overview.Name = stringVectors(:,1);
Brain_data_overview.Total = stringVectors(:,2);
Brain_data_overview.GM = stringVectors(:,3);
Brain_data_overview.WM = stringVectors(:,4);
Brain_data_overview.CSF = stringVectors(:,5);
Brain_data_overview.WMH = stringVectors(:,6);

% Clear temporary variables
clearvars data raw stringVectors;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% combine both tables, fill in variables for big_table:

Sample_site = [];
Subject = [];
Session = [];
age = [];
group = [];
sex = [];
gender = [];
isPatient = [];
wasPatient = [];
Diagnosis = [];
Handedness = [];
EducationLevel = [];
HormonalTreatment = [];
Path = [];
TIV = [];
GMV = [];
WM = [];
CSF = [];
WMH = [];


% safety check that both tables have the same number of subjects:
if size(Brain_data_overview,1) ~= size(Demograhphic_overview,1)
    fprintf('Number of subjects in Aachen tables are not equal! Need to recheck!')
    return
end

% iterative process for each subject:
subct = 1;
for i = 1:size(Brain_data_overview,1)
    
    % check if IDs in both tables are similar:
    subject_ID = char(Brain_data_overview.Name(i));
    if ~isequal( subject_ID(5:8), char(Demograhphic_overview.ID(i)) )
        fprintf('Subject-IDs for subject nr.%i %s are not the same, Need to recheck! \n',i, Demograhphic_overview.ID(i));
        return
    end

    % writing in command window with which subject the script is currently
     % working with:
     fprintf('Working on subject nr.%i %s \n',i, Demograhphic_overview.ID(i));
     
     path2file = fullfile(Path_2_cat_data,strcat('m0wp1',Brain_data_overview.Name(i)));
     
     if not (exist (path2file) == 2)
         fprintf('nifti-file does not exist for subject nr.%i %s \n',i, Demograhphic_overview.ID(i));
         continue
         
     else
         try
             %%% fill in variables:
             
             % Sample/Site:
             Sample_site{subct} = 'Aachen_trans_data';
             
             % Subject-ID:
             Subject{subct} = char(Demograhphic_overview.ID(i));
             
             % Session:
             Session{subct} = '-';

             % age:
             age{subct} = Demograhphic_overview.Age(i);
             
             % group (CM or TM etc.)
             if isequal(subject_ID(5:6), 'Km')
                 group{subct} = 'CM';
             elseif isequal(subject_ID(5:6), 'Kw')
                 group{subct} = 'CW';
             elseif isequal(subject_ID(5:6), 'Tm')
                 group{subct} = 'TM';
             elseif isequal(subject_ID(5:6), 'Tw')
                 group{subct} = 'TW';
             end
             
             % (biological) sex -> sex assigned at birth
             if isequal(subject_ID(5:6), 'Km')
                 sex{subct} = 'M';
             elseif isequal(subject_ID(5:6), 'Kw')
                 sex{subct} = 'F';
             elseif isequal(subject_ID(5:6), 'Tm')
                 sex{subct} = 'F';
             elseif isequal(subject_ID(5:6), 'Tw')
                 sex{subct} = 'M';
             end
             
             
             % gender identity (how the subjects identify themselves):
             if isequal(subject_ID(5:6), 'Km')
                 gender{subct} = 'M';
             elseif isequal(subject_ID(5:6), 'Kw')
                 gender{subct} = 'F';
             elseif isequal(subject_ID(5:6), 'Tm')
                 gender{subct} = 'M';
             elseif isequal(subject_ID(5:6), 'Tw')
                 gender{subct} = 'F';
             end

             % isPatient:
             if isequal(group{i}, 'CM')
                 isPatient{subct} = 0;
             elseif isequal(group{i}, 'CW')
                 isPatient{subct} = 0;
             elseif isequal(group{i}, 'TM')
                 isPatient{subct} = 1;
             elseif isequal(group{i}, 'TW')
                 isPatient{subct} = 1;
             end
             
             % wasPatient:
             wasPatient{subct} = 0;
             
             % Diagnosis:
             if isequal(group{i}, 'CM')
                 Diagnosis{subct} = 0;
             elseif isequal(group{i}, 'CW')
                 Diagnosis{subct} = 0;
             elseif isequal(group{i}, 'TM')
                 Diagnosis{subct} = 'gender dysphoria, no other mental disorders';
             elseif isequal(group{i}, 'TW')
                 Diagnosis{subct} = 'gender dysphoria, no other mental disorders';
             end
                           
             % Handedness:
             Handedness{subct} = Demograhphic_overview.Handness(i);
             
             % Eductional level:
             EducationLevel{subct} = Demograhphic_overview.EducationLevel(i);
             
             % Status of hormonal treatment:
             HormonalTreatment{subct} = Demograhphic_overview.HormonalTreatment(i);
             
             % Path to nifti:
             Path{subct} = char(path2file);
             
             % Values of brain measures:
             TIV{subct} = double(Brain_data_overview.Total(i));
             GMV{subct} = double(Brain_data_overview.GM(i));
             WM{subct} = double(Brain_data_overview.WM(i));
             CSF{subct} = double(Brain_data_overview.CSF(i));
             WMH{subct} = double(Brain_data_overview.WMH(i));
             
             
             fprintf('Entering subject nr.%i %s! \n',i, Demograhphic_overview.ID(i));
             subct = subct +1;  
             
         catch
             fprintf('Error loading data for subject nr.%i %s , Need to recheck! \n',i, Demograhphic_overview.ID(i));
             continue
         end
     end
end


big_table = table(Sample_site', Subject', Session', age', group', sex', gender', isPatient', wasPatient', Diagnosis', Handedness', EducationLevel', HormonalTreatment', Path', TIV', GMV', WM', CSF', WMH');
headers = {'Sample_site', 'Subject', 'Session', 'age', 'group', 'sex', 'gender', 'isPatient', 'wasPatient', 'Diagnosis', 'Handedness', 'EducationLevel', 'HormonalTreatment', 'Path', 'TIV', 'GMV', 'WM', 'CSF', 'WMH'};
big_table.Properties.VariableNames = headers;
 

save(fullfile(savedir,['big_table_Aachen_transgender_data']), 'big_table');


