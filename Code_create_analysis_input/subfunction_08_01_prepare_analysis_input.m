%%% prepare analysis input by iterating through the trainings/test-sample
%%% and check whether the IDs match, if yes, write the respective
%%% information in a vector/table:

function subfunction_08_01_prepare_analysis_input(savedir, dataname, GLMFlags, splitted_table)

dat = GLMFlags.dat{1,1};

%analysis_input_table = table();

Subject = [];
age = [];
sex_f1_m0 = [];
TIV = [];

n = 1;

for i = 1:size(splitted_table,1)
    
    for ii = 1:size(GLMFlags.sub,2)
        
        if isequal( splitted_table.Subject(i), GLMFlags.sub(ii) ) & isequal( splitted_table.Sample_site(i), GLMFlags.SubDir(ii) )
            
            analysis_input_table(n,:) = splitted_table(i,:);
            age(n) = GLMFlags.Age(ii);
            sex_f1_m0(n) = GLMFlags.Female(ii);
            TIV(n) = GLMFlags.TIV(ii);
            GMV(n,:) = dat(ii,:);
            Subject{n} = GLMFlags.sub{ii};
            
            n = n+1;
        end
    
    end
end

age = age';
sex_f1_m0 = sex_f1_m0';
TIV = TIV';
Subject = Subject';

% add binary sex in table:
analysis_input_table.binary_sex = sex_f1_m0;

% safety check:
if isequal(Subject, analysis_input_table.Subject)  & isequal(age, cell2mat(analysis_input_table.age)) & isequal(TIV, cell2mat(analysis_input_table.TIV))
    fprintf('Transition to analysis-input worked for dataset %s \n', dataname)
    
    save(fullfile(savedir, [dataname, '_age']), 'age')
    save(fullfile(savedir, [dataname, '_sex_f1_m0']), 'sex_f1_m0')
    save(fullfile(savedir, [dataname, '_TIV']), 'TIV')
    save(fullfile(savedir, [dataname, '_GMV']), 'GMV')
    save(fullfile(savedir, [dataname, '_overview_table']), 'analysis_input_table')

else
    fprintf('Error in transition to analysis-input for dataset %s! Need to recheck! \n', dataname)
    return
end
    