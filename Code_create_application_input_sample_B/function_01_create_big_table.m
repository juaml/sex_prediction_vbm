
% function to create big_table for Barcelona data:

function function_01_create_big_table(Path_2_table, Path_2_cat_data)

%%% create new directory to save the variables:
if ~exist(fullfile('01_big_table'), 'dir')
    mkdir('01_big_table')
end

savedir = fullfile(pwd, '01_big_table');
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% import txt-file:

% Initialize variables.
filename = Path_2_table;
delimiter = '\t';
startRow = 2;

% Format for each line of text:
%   column1: text (%s)
%	column2: text (%s)
%   column3: double (%f)
%	column4: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%f%f%[^\n\r]';

% Open the text file.
fileID = fopen(filename,'r');

% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');

% Close the text file.
fclose(fileID);

% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

% Create output variable
descriptives = table(dataArray{1:end-1}, 'VariableNames', {'code','group','age','education'});

% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% define variables for big_table:

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
EducationLevel = [];
Path = [];
GMV = [];
TIV = [];



subct = 1;
% iterative process for each subject:
for i = 1:size(descriptives,1)
    
     % writing in command window with which subject the script is currently
     % working with:
     fprintf('Working on subject nr.%i \n',i);
     
     path2file = fullfile(Path_2_cat_data, strcat('sub', descriptives.code(i)), 'mri', strcat('m0wp1sub',  descriptives.code(i),'.nii'));
     path2matfile = fullfile(Path_2_cat_data, strcat('sub', descriptives.code(i)),'report', strcat('cat_sub', descriptives.code(i),'.mat'));
     
     if not (exist (path2file) == 2) | not (exist (path2matfile) == 2)
         fprintf('nifti-file and/or mat-file does not exist for subject nr.%i \n',i);
         continue
         
     else
         try
             %%% fill in variables:

             % Sample/Site:
             Sample_site{subct} = 'Barcelona_trans_data';
             
             % Subject-ID:
             Subject{subct} = char(descriptives.code(i));
             
             % Session:
             Session{subct} = '-';

             % age:
             age{subct} = descriptives.age(i);
             
             
             sex_gender_ID = char(descriptives.group(i));
             
             % group (CM or TM etc.)
             if isequal(sex_gender_ID, 'cismen')
                 group{subct} = 'CM';
             elseif isequal(sex_gender_ID, 'ciswomen')
                 group{subct} = 'CW';
             elseif isequal(sex_gender_ID, 'transmen')
                 group{subct} = 'TM';
             elseif isequal(sex_gender_ID, 'transwomen')
                 group{subct} = 'TW';
             end
             
             % (biological) sex -> sex assigned at birth
             if isequal(sex_gender_ID, 'cismen')
                 sex{subct} = 'M';
             elseif isequal(sex_gender_ID, 'ciswomen')
                 sex{subct} = 'F';
             elseif isequal(sex_gender_ID, 'transmen')
                 sex{subct} = 'F';
             elseif isequal(sex_gender_ID, 'transwomen')
                 sex{subct} = 'M';
             end
             
             % gender identity (how the subjects identify themselves):
             if isequal(sex_gender_ID, 'cismen')
                 gender{subct} = 'M';
             elseif isequal(sex_gender_ID, 'ciswomen')
                 gender{subct} = 'F';
             elseif isequal(sex_gender_ID, 'transmen')
                 gender{subct} = 'M';
             elseif isequal(sex_gender_ID, 'transwomen')
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
             wasPatient{subct} = NaN;
             
             % Diagnosis:
             if isequal(group{i}, 'CM')
                 Diagnosis{subct} = 0;
             elseif isequal(group{i}, 'CW')
                 Diagnosis{subct} = 0;
             elseif isequal(group{i}, 'TM')
                 Diagnosis{subct} = 'gender dysphoria';
             elseif isequal(group{i}, 'TW')
                 Diagnosis{subct} = 'gender dysphoria';
             end
             
             % Educational level:
             EducationLevel{subct} = descriptives.education(i);
             
             %Path to nifti:
             Path{subct} = char(path2file);
             
             % Values of brain measures:
             load(path2matfile);
             
             GMV{subct} = S.subjectmeasures.vol_abs_CGW(2);
             TIV{subct} = S.subjectmeasures.vol_TIV;
             
             fprintf('Entering subject nr.%i! \n',i);
             subct = subct +1;  
             
         catch
              fprintf('Error loading data for subject nr.%i, Need to recheck! \n',i);
              continue
         end
     end

end


big_table = table(Sample_site', Subject', Session', age', group', sex', gender', isPatient', wasPatient', Diagnosis', EducationLevel', Path', GMV', TIV');
headers = {'Sample_site', 'Subject', 'Session', 'age', 'group', 'sex', 'gender', 'isPatient', 'wasPatient', 'Diagnosis', 'EducationLevel', 'Path', 'GMV', 'TIV'};
big_table.Properties.VariableNames = headers;

save(fullfile(savedir,['big_table_Barcelona_transgender_data']), 'big_table');
