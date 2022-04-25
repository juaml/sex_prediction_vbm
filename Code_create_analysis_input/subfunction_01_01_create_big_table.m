
function subfunction_01_01_create_big_table(Path_2_cat12, Path_2_lookups, savedir, dataset, name_lookup, site_folder, folder_name, ses, min_age, max_age)


% Create empty variables to fill in:

Sample_site = [];
Subject = [];
Session = [];
age = [];
sex = [];
isPatient = [];
wasPatient = [];
Path = [];
GMV = [];
TIV = [];


subct = 1;

% load lookup:
Lookup = load(fullfile(Path_2_lookups, [name_lookup, '_look_up.mat']));

%%% iterative process for each subject:

for sub = 1:numel(Lookup.sub)
    

    % writing in command window with which subject the script is currently
    % working with:
    if site_folder == 1
        fprintf('Working on subject %i in directory %s in folder %s in dataset %s \n',sub, Lookup.sub{sub}, folder_name, dataset);
    elseif site_folder == 0
        fprintf('Working on subject %i in directory %s in dataset %s \n',sub, Lookup.sub{sub}, dataset);
    end
            


            % Path to each individual subject_folder in cat12.5 data:
            if site_folder == 1
                path2sub = fullfile(Path_2_cat12, dataset, folder_name, Lookup.sub{sub});
            elseif site_folder == 0
                path2sub = fullfile(Path_2_cat12,  dataset, Lookup.sub{sub});
            end
            
            %%% Check for missing subjects:
            % in case one subject of the lookup-file is not in the cat_12.5 data 
            % the loop will go on to the next subject:
            if not( (exist (path2sub) == 7) );
                if site_folder == 1
                    fprintf('Data does not exist for subject %i in directory %s in folder %s in dataset %s \n',sub, Lookup.sub{sub}, folder_name, dataset);
                elseif site_folder == 0
                    fprintf('Data does not exist for subject %i in directory %s in dataset %s \n',sub, Lookup.sub{sub}, dataset);
                end
            
                continue;
            end

 
            %%% always extract the first session (if available) of each subject:
            % in case a dataset contains sessions, the ses-parameter  should be set on ses = 1, so that in this if-loop
            % always the first session will be extracted for the further
            % file-path:
            if ses == 1
                Overview_sessions_in_subject_folder = dir(path2sub);
                % choose the 3 foldername (first and second are other directories);
                session = Overview_sessions_in_subject_folder(3).name;
                path2file = fullfile(path2sub, session, 'mri',['m0wp1',Lookup.sub{sub},'_',session,'.nii.gz']);
            elseif ses == 0
                if isequal(dataset, 'GOBS_CIVET')
                    path2file = fullfile(path2sub, 'mri',['m0wp1',Lookup.sub{sub}(5:end),'.nii.gz']);
                else
                    path2file = fullfile(path2sub, 'mri',['m0wp1',Lookup.sub{sub},'.nii.gz']);
                end
            end            
            

            %%% Path to the mat-file in report-folder that contains the GMV-value:
            % in case a dataset contains sessions, the ses-parameter  should be set on ses = 1, so that in this if-loop
            % always the first session will be extracted for the further
            % file-path:
            if ses == 1;
                path2matfile = fullfile(path2sub, session, 'report',['cat_',Lookup.sub{sub},'_',session,'.mat']);      
            elseif ses == 0;
                if isequal(dataset, 'GOBS_CIVET')
                    path2matfile = fullfile(path2sub, 'report',['cat_',Lookup.sub{sub}(5:end),'.mat']);
                else
                    path2matfile = fullfile(path2sub, 'report',['cat_',Lookup.sub{sub},'.mat']);
                end
            end

    
      %%% fill variables if nifti of the current subject exists:
      
      if not (exist (path2file) == 2) | not (exist (path2matfile) == 2)
            fprintf('nifti-file and/or mat-file does not exist for subject %i in directory %s in dataset %s \n',sub, Lookup.sub{sub}, dataset);
            continue
        else
                
            
            try 
                % fill variables:
                
                % Sample/Site:
                if site_folder == 1
                    Sample_site{subct} = fullfile(dataset,folder_name);
                elseif site_folder == 0
                    Sample_site{subct} = dataset;
                end
                
                % Subject:
                Subject{subct} = Lookup.sub{sub};
                
                % Session:
                if ses == 1
                    Session{subct} = session;
                elseif ses == 0
                    Session{subct} = '-';
                end
                
                % age:
                age{subct} = Lookup.Cov(sub,2);
                
                % sex:
                if Lookup.Cov(sub,1) == 1
                    sex{subct} = 'M';
                elseif Lookup.Cov(sub,1) == 2;
                    sex{subct} = 'F';
                else
                    sex{subct} = 'NaN';    
                end
                                
                % isPatient:
                if isequal(dataset, 'HCP')
                    % in case the subject is from the HCP s1200 release,
                    % code them as not patient, since all subjects in this
                    % release are healthy according to this website:
                    % https://www.humanconnectome.org/study/hcp-young-adult/document/1200-subjects-data-release
                    isPatient{subct} = 0;
                else
                    isPatient{subct} = Lookup.Cov(sub,3);
                end
                
                
                % if the column 'was Patient' exists, take the information,
                % else write NaNs in the variable:
                if size(Lookup.Covariates,2) == 4
                    wasPatient{subct} = Lookup.Cov(sub,4);
                elseif size(Lookup.Covariates,2) < 4
                    wasPatient{subct} = 'NaN';
                end
                    
                
                % Path to nifti:
                Path{subct} = path2file;
                
                % Mat-file:
                matfile = load(path2matfile);
                GMV{subct} = matfile.S.subjectmeasures.vol_abs_CGW(2);
                
                % TIV-Value:
                TIV{subct} = matfile.S.subjectmeasures.vol_TIV;
                
                
                fprintf('Entering subject %i in directory %s in dataset %s \n',sub, Lookup.sub{sub}, dataset);
                subct = subct +1;   
                
            catch
                fprintf('Error loading data for subject %3i in directory %12s \n',sub,Lookup.sub{sub});
                continue
            end
    
    
      end
        
      
end
      
            
% create table:
T = table(Sample_site', Subject', Session', age', sex', isPatient', wasPatient', Path', GMV', TIV');
headers = {'Sample_site', 'Subject', 'Session', 'age', 'sex','isPatient', 'wasPatient', 'Path', 'GMV', 'TIV'};
T.Properties.VariableNames = headers;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% only save subjects that match the criteria:
% criteria: age range 18-65
% age range is 18-65, as in the transgender paper, so we apply the same
% age range, by excluding subjects under 18 and older than 65

% exclude patients in the colums ispatient and waspatient

big_table = table();
m = 1;

for ii = 1:size(T,1)
    
    if T.age{ii} < min_age | T.age{ii} >= max_age | T.isPatient{ii} == 1 | T.wasPatient{ii} == 1 | isnan(T.age{ii}) | isnan(T.sex{ii}) | isnan(T.isPatient{ii})
        continue
    else
        big_table(m,:) = T(ii,:);
        m = m+1;
    end
end

    
%%% save variables in different formats:
if site_folder == 1;
    save(fullfile(savedir, ['big_table_', dataset, '_', folder_name]), 'big_table');
elseif site_folder == 0;
    save(fullfile(savedir, ['big_table_', dataset]), 'big_table');
end
    
    