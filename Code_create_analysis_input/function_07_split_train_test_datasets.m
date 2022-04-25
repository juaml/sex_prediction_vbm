% function to split the combined tables into a 80%-train and 20%-test
% dataset:

function function_07_split_train_test_datasets(Path_2_combined_tables)

%%% create new directory to save the variables:
if ~exist('07_train_test_set_split', 'dir')
    mkdir('07_train_test_set_split')
end

savedir = fullfile(pwd, '07_train_test_set_split');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% compute numbers for 80%-20% split:
age_TIV_matched_table = load(fullfile(Path_2_combined_tables, 'big_table_age_TIV_matched_3mm_paths'));
age_TIV_matched_table = age_TIV_matched_table.big_table;
clear big_table

N = size(age_TIV_matched_table,1);

% if N for the training sample is odd, add 1; so that the N for training
% and test set is even in both cases:
N_train_sample = round(N * 0.8);
if mod(N_train_sample,2) ~= 0
    N_train_sample = N_train_sample+1;
end

N_test_sample = N - N_train_sample;
N_20_per_females = N_test_sample/2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% split age-TIV-matched table into train- and test- dataset:

% create index for females to use only the females in the first step:
index_females = cell2mat(age_TIV_matched_table.sex) == 'F';
age_TIV_matched_females = age_TIV_matched_table(index_females,:);

% shuffle table, so that not only the 1000Brains dataset is represented
% mostly:
rand_index = randperm(size(age_TIV_matched_females,1));
age_TIV_matched_females = age_TIV_matched_females(rand_index,:);

TIV_females = cell2mat(age_TIV_matched_females.TIV);
age_females = cell2mat(age_TIV_matched_females.age);

% define dataset-specific TIV- and age-levels by quartiles:
percentiles_TIV = prctile(cell2mat(age_TIV_matched_females.TIV), [25 50 75]);
percentiles_age = prctile(cell2mat(age_TIV_matched_females.age), [25 50 75]);

age_TIV_matched_females_TIV_0_25_age_0_25 = age_TIV_matched_females( TIV_females < percentiles_TIV(1) & age_females < percentiles_age(1) ,:);
age_TIV_matched_females_TIV_0_25_age_25_50 = age_TIV_matched_females( TIV_females < percentiles_TIV(1) &  age_females >= percentiles_age(1) & age_females < percentiles_age(2),:);
age_TIV_matched_females_TIV_0_25_age_50_75 = age_TIV_matched_females( TIV_females < percentiles_TIV(1) &  age_females >= percentiles_age(2) & age_females < percentiles_age(3),:);
age_TIV_matched_females_TIV_0_25_age_75_100 = age_TIV_matched_females( TIV_females < percentiles_TIV(1) &  age_females >= percentiles_age(3),:);

age_TIV_matched_females_TIV_25_50_age_0_25  = age_TIV_matched_females( TIV_females >= percentiles_TIV(1) & TIV_females < percentiles_TIV(2) &  age_females < percentiles_age(1),:);
age_TIV_matched_females_TIV_25_50_age_25_50 = age_TIV_matched_females( TIV_females >= percentiles_TIV(1) & TIV_females < percentiles_TIV(2) & age_females >= percentiles_age(1) & age_females < percentiles_age(2),:);
age_TIV_matched_females_TIV_25_50_age_50_75 = age_TIV_matched_females( TIV_females >= percentiles_TIV(1) & TIV_females < percentiles_TIV(2) & age_females >= percentiles_age(2) & age_females < percentiles_age(3),:);
age_TIV_matched_females_TIV_25_50_age_75_100 = age_TIV_matched_females( TIV_females >= percentiles_TIV(1) & TIV_females < percentiles_TIV(2) & age_females >= percentiles_age(3),:);

age_TIV_matched_females_TIV_50_75_age_0_25 = age_TIV_matched_females( TIV_females >= percentiles_TIV(2) & TIV_females < percentiles_TIV(3) &  age_females < percentiles_age(1),:);
age_TIV_matched_females_TIV_50_75_age_25_50 = age_TIV_matched_females( TIV_females >= percentiles_TIV(2) & TIV_females < percentiles_TIV(3) & age_females >= percentiles_age(1) & age_females < percentiles_age(2),:);
age_TIV_matched_females_TIV_50_75_age_50_75 = age_TIV_matched_females( TIV_females >= percentiles_TIV(2) & TIV_females < percentiles_TIV(3) & age_females >= percentiles_age(2) & age_females < percentiles_age(3),:);
age_TIV_matched_females_TIV_50_75_age_75_100 = age_TIV_matched_females( TIV_females >= percentiles_TIV(2) & TIV_females < percentiles_TIV(3) & age_females >= percentiles_age(3),:);

age_TIV_matched_females_TIV_75_100_age_0_25 = age_TIV_matched_females( TIV_females >= percentiles_TIV(3) &  age_females < percentiles_age(1),:);
age_TIV_matched_females_TIV_75_100_age_25_50 = age_TIV_matched_females( TIV_females >= percentiles_TIV(3) & age_females >= percentiles_age(1) & age_females < percentiles_age(2),:);
age_TIV_matched_females_TIV_75_100_age_50_75 = age_TIV_matched_females( TIV_females >= percentiles_TIV(3) & age_females >= percentiles_age(2) & age_females < percentiles_age(3),:);
age_TIV_matched_females_TIV_75_100_age_75_100 = age_TIV_matched_females( TIV_females >= percentiles_TIV(3) & age_females >= percentiles_age(3),:);

% safety check, that all subjects are covered:
nr_subjects =               size(age_TIV_matched_females_TIV_0_25_age_0_25,1) + size(age_TIV_matched_females_TIV_0_25_age_25_50,1) + size(age_TIV_matched_females_TIV_0_25_age_50_75,1) + size(age_TIV_matched_females_TIV_0_25_age_75_100,1);
nr_subjects = nr_subjects + size(age_TIV_matched_females_TIV_25_50_age_0_25,1) + size(age_TIV_matched_females_TIV_25_50_age_25_50,1) + size(age_TIV_matched_females_TIV_25_50_age_50_75,1) + size(age_TIV_matched_females_TIV_25_50_age_75_100,1);
nr_subjects = nr_subjects + size(age_TIV_matched_females_TIV_50_75_age_0_25,1) + size(age_TIV_matched_females_TIV_50_75_age_25_50,1) + size(age_TIV_matched_females_TIV_50_75_age_50_75,1) + size(age_TIV_matched_females_TIV_50_75_age_75_100,1);
nr_subjects = nr_subjects + size(age_TIV_matched_females_TIV_75_100_age_0_25,1) + size(age_TIV_matched_females_TIV_75_100_age_25_50,1) + size(age_TIV_matched_females_TIV_75_100_age_50_75,1) + size(age_TIV_matched_females_TIV_75_100_age_75_100,1);

if nr_subjects ~= size(age_TIV_matched_females,1)
    fprintf('Need to recheck numbers in function_07! \n')
    return
end
    

% iterate through all percentiles and add one female until the number of
% 20% females is reached:

test_sample_20_per_females = table();
n = 1;

i = 1;
while size(test_sample_20_per_females,1) < N_20_per_females
    
        % TIV 0-25:
        test_sample_20_per_females(n,:) = age_TIV_matched_females_TIV_0_25_age_0_25(i,:);
        n = n+1;
        if size(test_sample_20_per_females,1) == N_20_per_females
            break
        end

        test_sample_20_per_females(n,:) = age_TIV_matched_females_TIV_0_25_age_25_50(i,:);
        n = n+1;
        if size(test_sample_20_per_females,1) == N_20_per_females
            break
        end

        test_sample_20_per_females(n,:) = age_TIV_matched_females_TIV_0_25_age_50_75(i,:);
        n = n+1;
        if size(test_sample_20_per_females,1) == N_20_per_females
            break
        end

        test_sample_20_per_females(n,:) = age_TIV_matched_females_TIV_0_25_age_75_100(i,:);
        n = n+1;
        if size(test_sample_20_per_females,1) == N_20_per_females
            break
        end
        
        
        % TIV 25-50:
        test_sample_20_per_females(n,:) = age_TIV_matched_females_TIV_25_50_age_0_25(i,:);
        n = n+1;
        if size(test_sample_20_per_females,1) == N_20_per_females
            break
        end

        test_sample_20_per_females(n,:) = age_TIV_matched_females_TIV_25_50_age_25_50(i,:);
        n = n+1;
        if size(test_sample_20_per_females,1) == N_20_per_females
            break
        end

        test_sample_20_per_females(n,:) = age_TIV_matched_females_TIV_25_50_age_50_75(i,:);
        n = n+1;
        if size(test_sample_20_per_females,1) == N_20_per_females
            break
        end

        test_sample_20_per_females(n,:) = age_TIV_matched_females_TIV_25_50_age_75_100(i,:);
        n = n+1;
        if size(test_sample_20_per_females,1) == N_20_per_females
            break
        end
    
    
        % TIV 50-75:
        test_sample_20_per_females(n,:) = age_TIV_matched_females_TIV_50_75_age_0_25(i,:);
        n = n+1;
        if size(test_sample_20_per_females,1) == N_20_per_females
            break
        end

        test_sample_20_per_females(n,:) = age_TIV_matched_females_TIV_50_75_age_25_50(i,:);
        n = n+1;
        if size(test_sample_20_per_females,1) == N_20_per_females
            break
        end

        test_sample_20_per_females(n,:) = age_TIV_matched_females_TIV_50_75_age_50_75(i,:);
        n = n+1;
        if size(test_sample_20_per_females,1) == N_20_per_females
            break
        end

        test_sample_20_per_females(n,:) = age_TIV_matched_females_TIV_50_75_age_75_100(i,:);
        n = n+1;
        if size(test_sample_20_per_females,1) == N_20_per_females
            break
        end
        
        
        % TIV 75-100:
        test_sample_20_per_females(n,:) = age_TIV_matched_females_TIV_75_100_age_0_25(i,:);
        n = n+1;
        if size(test_sample_20_per_females,1) == N_20_per_females
            break
        end

        test_sample_20_per_females(n,:) = age_TIV_matched_females_TIV_75_100_age_25_50(i,:);
        n = n+1;
        if size(test_sample_20_per_females,1) == N_20_per_females
            break
        end

        test_sample_20_per_females(n,:) = age_TIV_matched_females_TIV_75_100_age_50_75(i,:);
        n = n+1;
        if size(test_sample_20_per_females,1) == N_20_per_females
            break
        end

        test_sample_20_per_females(n,:) = age_TIV_matched_females_TIV_75_100_age_75_100(i,:);
        n = n+1;
        if size(test_sample_20_per_females,1) == N_20_per_females
            break
        end    
    
    i = i+1;
end
clear n i age_TIV_matched_females_TIV_0_25_age_0_25 age_TIV_matched_females_TIV_0_25_age_25_50 age_TIV_matched_females_TIV_0_25_age_50_75 age_TIV_matched_females_TIV_0_25_age_75_100
clear age_TIV_matched_females_TIV_25_50_age_0_25 age_TIV_matched_females_TIV_25_50_age_25_50 age_TIV_matched_females_TIV_25_50_age_50_75 age_TIV_matched_females_TIV_25_50_age_75_100
clear age_TIV_matched_females_TIV_50_75_age_0_25 age_TIV_matched_females_TIV_50_75_age_25_50 age_TIV_matched_females_TIV_50_75_age_50_75 age_TIV_matched_females_TIV_50_75_age_75_100
clear age_TIV_matched_females_TIV_75_100_age_0_25 age_TIV_matched_females_TIV_75_100_age_25_50 age_TIV_matched_females_TIV_75_100_age_50_75 age_TIV_matched_females_TIV_75_100_age_75_100

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%%% define the remaining 80% as training-dataset:

% iterate through the age-TIV-matched females, if an Subject-ID does not
% occur in the test-dataset, write this row in a new trainings-table:

train_sample_80_per_females = table();
n = 1;

for i = 1:size(age_TIV_matched_females,1)
   if ismember(age_TIV_matched_females.Subject(i), test_sample_20_per_females.Subject)
       continue
   else
       train_sample_80_per_females(n,:) = age_TIV_matched_females(i,:);
       n = n+1;
   end  
    
end

if not(size(train_sample_80_per_females,1) + size(test_sample_20_per_females,1) == size(age_TIV_matched_females,1))
    fprintf('Need to recheck numbers in function 07 after splitting age-TIV-matched table! \n')
    return
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% trace back which males belongs to the female subjects in the train and
% test sample:

train_sample_80per = table();
n = 1;

for i = 1:size(train_sample_80_per_females,1)
    
    for ii = 1:size(age_TIV_matched_table,1)
        if isequal( train_sample_80_per_females.Subject(i), age_TIV_matched_table.Subject(ii) )
            train_sample_80per(n,:) = age_TIV_matched_table(ii,:);
            train_sample_80per(n+1,:) = age_TIV_matched_table(ii+1,:);
            n = n+2;
        else
            continue
        end
    end  
end
clear n i ii

test_sample_20per = table();
n = 1;

for i = 1:size(test_sample_20_per_females,1)
    
    for ii = 1:size(age_TIV_matched_table,1)
        if isequal( test_sample_20_per_females.Subject(i), age_TIV_matched_table.Subject(ii) )
            test_sample_20per(n,:) = age_TIV_matched_table(ii,:);
            test_sample_20per(n+1,:) = age_TIV_matched_table(ii+1,:);
            n = n+2;
        else
            continue
        end
    end  
end
clear n i ii

age_TIV_matched_train_sample_80_per = train_sample_80per;
age_TIV_matched_test_sample_20_per = test_sample_20per;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear index_females rand_index age_females percentiles_age test_sample_20_per_females train_sample_80_per_females train_sample_80per test_sample_20per
%%% split age-matched table:

age_matched_table = load(fullfile(Path_2_combined_tables, 'big_table_age_matched_3mm_paths'));
age_matched_table = age_matched_table.big_table;
clear big_table

% create index for females to use only the females in the first step:
index_females = cell2mat(age_matched_table.sex) == 'F';
age_matched_females = age_matched_table(index_females,:);

% shuffle table, so that not only the 1000Brains dataset is represented
% mostly:
rand_index = randperm(size(age_matched_females,1));
age_matched_females = age_matched_females(rand_index,:);

age_females = cell2mat(age_matched_females.age);

% define dataset-specific age-levels by quartiles:
percentiles_age = prctile(cell2mat(age_matched_females.age), [25 50 75]);

age_matched_females_age_0_25 = age_matched_females( age_females < percentiles_age(1) ,:);
age_matched_females_age_25_50 = age_matched_females( age_females >= percentiles_age(1) & age_females < percentiles_age(2),:);
age_matched_females_age_50_75 = age_matched_females( age_females >= percentiles_age(2) & age_females < percentiles_age(3),:);
age_matched_females_age_75_100 = age_matched_females( age_females >= percentiles_age(3),:);

% safety-check that all subjects are covered:
if size(age_matched_females,1) ~= size(age_matched_females_age_0_25,1) + size(age_matched_females_age_25_50,1) + size(age_matched_females_age_50_75,1) + size(age_matched_females_age_75_100,1)
    fprintf('Need to recheck numbers in function_07! \n')
    return
end


test_sample_20_per_females = table();
n = 1;

i = 1;
while size(test_sample_20_per_females,1) < N_20_per_females
    
    test_sample_20_per_females(n,:) = age_matched_females_age_0_25(i,:);
    n = n+1;
    if size(test_sample_20_per_females,1) == N_20_per_females
        break
    end
    
    test_sample_20_per_females(n,:) = age_matched_females_age_25_50(i,:);
    n = n+1;
    if size(test_sample_20_per_females,1) == N_20_per_females
        break
    end
    
    test_sample_20_per_females(n,:) = age_matched_females_age_50_75(i,:);
    n = n+1;
    if size(test_sample_20_per_females,1) == N_20_per_females
        break
    end
    
    test_sample_20_per_females(n,:) = age_matched_females_age_75_100(i,:);
    n = n+1;
    if size(test_sample_20_per_females,1) == N_20_per_females
        break
    end
    
    i = i+1;
end
clear n i age_matched_females_age_0_25 age_matched_females_age_25_50 age_matched_females_age_50_75 age_matched_females_age_75_100

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% define the remaining 80% as training-dataset:

% iterate through the age-matched females, if an Subject-ID does not
% occur in the test-dataset, write this row in a new trainings-table:

train_sample_80_per_females = table();
n = 1;

for i = 1:size(age_matched_females,1)
   if ismember(age_matched_females.Subject(i), test_sample_20_per_females.Subject)
       continue
   else
       train_sample_80_per_females(n,:) = age_matched_females(i,:);
       n = n+1;
   end  
    
end

if not(size(train_sample_80_per_females,1) + size(test_sample_20_per_females,1) == size(age_matched_females,1))
    fprintf('Need to recheck numbers in function 07 after splitting age-matched table! \n')
    return
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% trace back which males belongs to the female subjects in the train and
% test sample:

train_sample_80per = table();
n = 1;

for i = 1:size(train_sample_80_per_females,1)
    
    for ii = 1:size(age_matched_table,1)
        if isequal( train_sample_80_per_females.Subject(i), age_matched_table.Subject(ii) )
            train_sample_80per(n,:) = age_matched_table(ii,:);
            train_sample_80per(n+1,:) = age_matched_table(ii+1,:);
            n = n+2;
        else
            continue
        end
    end  
end
clear n i ii

test_sample_20per = table();
n = 1;

for i = 1:size(test_sample_20_per_females,1)
    
    for ii = 1:size(age_matched_table,1)
        if isequal( test_sample_20_per_females.Subject(i), age_matched_table.Subject(ii) )
            test_sample_20per(n,:) = age_matched_table(ii,:);
            test_sample_20per(n+1,:) = age_matched_table(ii+1,:);
            n = n+2;
        else
            continue
        end
    end  
end
clear n i ii

age_matched_train_sample_80_per = train_sample_80per;
age_matched_test_sample_20_per = test_sample_20per;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% check that there is no overlap between the trainings-and test-sets:

all_IDs = [age_TIV_matched_train_sample_80_per.Subject; age_TIV_matched_test_sample_20_per.Subject; age_matched_train_sample_80_per.Subject; age_matched_test_sample_20_per.Subject];

if size(all_IDs,1) == size(unique(all_IDs),1)
    fprintf('No overlap in all test and trainings-samples! \n')
    else
    fprintf('Overlap in combined age-matched table and combined age-TIV-matched table! \n')
    return
end
    
subfunction_07_01_ttest(savedir, age_TIV_matched_train_sample_80_per, age_TIV_matched_test_sample_20_per, age_matched_train_sample_80_per, age_matched_test_sample_20_per)
