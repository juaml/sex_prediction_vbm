
% function for age-matching:

function subfunction_04_02_age_matching(savedir, big_table, max_age_diff, dataset)

% load age-TIV-matched table:
load(fullfile(savedir, [dataset, '_big_table_age_TIV_matched']));


age_TIV_matched_subjects = big_table_matched_subjects;
clear big_table_matched_subjects

% delete subjects that already occured in the age-TIV-matched dataset!
clean_big_table = table();
p = 1;

for a = 1:size(big_table,1)
    if ismember(big_table.Subject(a), age_TIV_matched_subjects.Subject)
        continue
    else
        clean_big_table(p,:) = big_table(a,:);
        p = p+1;
    end
end
clear a p

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Split big_table into males and females:
sex = cell2mat(clean_big_table.sex);

big_tables_males = clean_big_table(sex == 'M',:);
big_table_females = clean_big_table(sex == 'F',:);


% define new table for the matched subjects:
big_table_matched_subjects = table();
m = 1;

%%% iterate through all females and try to find an adequate match from the
%%% male group (adequate in terms of the matching criteria defined in the Script_00):

for i = 1:size(big_table_females,1)
    
    % define age and TIV of the current female person:
    current_age_female = big_table_females.age{i};
    current_TIV_female = big_table_females.TIV{i};
    current_ID_female = big_table_females.Subject{i};
        
    %fprintf('Working on age-matching on female-no. %i in directory %s in dataset %s \n', i, current_ID_female, dataset);
    
    
     % define empty table for all intermediate possible male matches that
     % match the matching criteria:
     intermediate_table = table();
     n = 1;
     
     for iii = 1:size(big_tables_males,1)
         
         % define age and TIV of the current male subject:
         current_age_male = big_tables_males.age{iii};
         current_TIV_male = big_tables_males.TIV{iii};
        
         %%% if the current male subject matches the matching-criteria, write
         %%% these information in the intermediate table:
         
         % compute absolute differences in age and TIV:
         diff_age = abs(current_age_female - current_age_male);
         
         if diff_age <= max_age_diff
             intermediate_table(n,:) = big_tables_males(iii,:);
             n = n +1;
         else
             continue
         end

     end

     % in case there are no possible matches for the current female subject
     % (in terms of an empty intermediate table) continue to the next
     % female subject in the loop:
     
     if size(intermediate_table,1) == 0
         %fprintf('No possible matches in age-matching on female-no. %i in directory %s in dataset %s \n', i, current_ID_female, dataset)
         continue
     end
         
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % delete subjects from the intermediate table whose ID is already in
    % the big_table_matched_subjects:
    if size(big_table_matched_subjects,1) > 1
        clean_intermediate_table = table();
        p = 1;

        for iiii = 1:size(intermediate_table,1)
            if ismember(intermediate_table.Subject(iiii), big_table_matched_subjects.Subject)
                continue
            else
                clean_intermediate_table(p,:) = intermediate_table(iiii,:);
                p = p+1;
            end
        end
        clear p iii intermediate_table
        
        intermediate_table = clean_intermediate_table;
        clear clean_intermediate_table
    end
        
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % after a potential cleaning of the intermediate table there are 3
    % possibilities left:
    
    % 1) no more male subject in the intermediate table -> no possible
    % matches, continue with the next female subject
    
    % 2) one male subject in intermediate table -> choose this one as best
    % match for the current female subject
    
    % 3) several male subject in intermediate table -> choose the one with
    % the mininum age-difference as best match

    if size(intermediate_table,1) == 0
        %fprintf('No possible matches in age-matching on female-no. %i in directory %s in dataset %s \n', i, current_ID_female, dataset)
        continue
        
    elseif size(intermediate_table,1) == 1
        big_table_matched_subjects(m,:) = big_table_females(i,:);
        big_table_matched_subjects(m+1,:) = intermediate_table;
        m = m+2;
        
    elseif size(intermediate_table,1) > 1
        
        % compute absolute age-difference of all male subject in the
        % intermediate table to the current female subject:
        intermediate_table.abs_age_diff = abs(cell2mat(intermediate_table.age) - current_age_female);
        
        % define the minimum of age-difference and choose this male subject
        % as best match for the current female subject:
        index_min_age_diff = intermediate_table.abs_age_diff == min(intermediate_table.abs_age_diff);
        
        % in case there is more than one subject with a minimum age
        % difference, choose the first one
        if sum(index_min_age_diff) > 1
            intermediate_table_only_min = intermediate_table(index_min_age_diff, 1:10);
            
            big_table_matched_subjects(m,:) = big_table_females(i,:);
            big_table_matched_subjects(m+1,:) = intermediate_table_only_min(1,:);
            m = m+2;
            
        else
            big_table_matched_subjects(m,:) = big_table_females(i,:);
            big_table_matched_subjects(m+1,:) = intermediate_table(index_min_age_diff,1:10);
            m = m+2;
        end
            
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% double check whether all subjects are unique in the new matched table:
if size(big_table_matched_subjects,1) == size(unique(big_table_matched_subjects.Subject),1)
    fprintf('All subjects in age-matched sample are unique! \n')
else
    fprintf('Subjects in age-matched sample are not unique; Need to recheck! \n') 
    return
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% save data:
save(fullfile(savedir, [dataset, '_big_table_age_matched_no_adjusted_age_ranges']), 'big_table_matched_subjects')
