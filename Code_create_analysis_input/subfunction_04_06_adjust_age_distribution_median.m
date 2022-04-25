% in case the adjustment of age-ranges with the percentiles did not work,
% this script adjustes the age-ranges via dividing the age-TIV-matched
% sample into 2 parts according to age:

function subfunction_04_06_adjust_age_distribution_median(savedir, dataset, big_table_age_TIV_matched, big_table_age_matched)

% select only females in age-TIV-matched table (a respective male-match of
% a female subject might be in a different age-level even though the
% age-difference is less then 1 e.g. 29.9 and 30.8)
age_TIV_matched_subjects_females = big_table_age_TIV_matched(cell2mat(big_table_age_TIV_matched.sex) == 'F',:);

% define dataset-specific age-levels by percentiles:
median_split = median(cell2mat(age_TIV_matched_subjects_females.age));

% define limits for each age-level:
nr_sub_younger_median = sum(cell2mat(age_TIV_matched_subjects_females.age) < median_split);
nr_sub_older_median = sum(cell2mat(age_TIV_matched_subjects_females.age) >= median_split);

% safety check whether all subjects are covered with these age-groups:
if size(age_TIV_matched_subjects_females,1) ~= nr_sub_younger_median + nr_sub_older_median
    fprintf('Need to recheck numbers in age-groups! \n')
    return
end

% select only females from the age-matched table, so that the assignment
% with the numbers defined above can work appropriately:
age_matched_subjects_females = big_table_age_matched(cell2mat(big_table_age_matched.sex) == 'F',:);

% divide table into the age-groups:
age_matched_females_younger_median = age_matched_subjects_females( cell2mat(age_matched_subjects_females.age) < median_split ,:);
age_matched_females_older_median = age_matched_subjects_females( cell2mat(age_matched_subjects_females.age) >= median_split ,:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% safety check whether all subjects are covered with these age-groups:
if size(age_matched_subjects_females,1) ~= size(age_matched_females_younger_median,1) + size(age_matched_females_older_median,1)
    fprintf('Need to recheck numbers in age-matched age-groups! \n')
    return
end

% if one of the numbers of the age-TIV-matched age-group is higher than the
% number of subjects in the respective age-group, move on to the next
% dataset instead;
% if this is not the case, iterate through all age-groups and define a
% new-age-matched table having the same N as the age-TIV-matched table:

if nr_sub_younger_median > size(age_matched_females_younger_median,1) | nr_sub_older_median > size(age_matched_females_older_median,1)
    fprintf('Adjusting age-distributions via median-split won´t work! Move on to the next dataset! \n')
    return
else

         % define emtpy table to save the women that were selected from each
         % age-splitted array:
         limited_females_of_age_groups = table();
         n = 1;

         % iterate through all age-splitted arrays an save the females until the
         % limit for both age-classes is reached in the previously defined table:
         for i = 1:nr_sub_younger_median
             limited_females_of_age_groups(n,:) = age_matched_females_younger_median(i,:);
             n = n+1;
         end
         clear i
         
         for i = 1:nr_sub_older_median
             limited_females_of_age_groups(n,:) = age_matched_females_older_median(i,:);
             n = n+1;
         end
         clear i
         

         %%% iterate through the new defined table (limited_females_of_age_groups)
         %%% and write the female with the matching male person in a new table
         age_matched_subjects = table();
         m = 1;

         for i = 1:size(limited_females_of_age_groups,1)

             for ii = 1:size(big_table_age_matched,1)
                 % if the female IDs match, write this line of the table and the
                 % respective matching male in the new age_matched_subjects-table:
                 if isequal(cell2mat(limited_females_of_age_groups.Subject(i)), cell2mat(big_table_age_matched.Subject(ii)))
                     age_matched_subjects(m,:) = big_table_age_matched(ii,:);
                     age_matched_subjects(m+1,:) = big_table_age_matched(ii+1,:);
                     m = m+2;
                 end
             end
         end


         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         % safety-check whether tables have now the same N:
         if isequal( size(age_matched_subjects,1), size(big_table_age_TIV_matched,1) )
             fprintf('Equal nr. of subjects in age-matched and age-TIV-matched table! \n');
         else 
             fprintf('Unequal nr. of subjects in age-matched and age-TIV-matched table! \n');
             return
         end
         clear big_table_age_matched

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        % check whether males and females do not differ in age, but do differ in TIV:
        index_matched_subjects_males = cell2mat(age_matched_subjects.sex) == 'M';
        index_matched_subjects_females = cell2mat(age_matched_subjects.sex) == 'F';

        %%% ttest age:
        [h,p,ci,stats] = ttest2(cell2mat(age_matched_subjects.age(index_matched_subjects_females)), cell2mat(age_matched_subjects.age(index_matched_subjects_males)));
        if h == 0
            fprintf('No significant difference in age between males and females in age-matched table in dataset %s \n', dataset)
        elseif h == 1
             fprintf('Significant difference in age between males and females in age-matched table in dataset %s, Need to recheck!\n', dataset)
             return
        end
        clear h p ci stats
        
        %%% ttest TIV:
        [h,p,ci,stats] = ttest2(cell2mat(age_matched_subjects.TIV(index_matched_subjects_females)), cell2mat(age_matched_subjects.TIV(index_matched_subjects_males)));
        if h == 0
            fprintf('No significant difference in TIV between males and females in age-matched table in dataset, Need to recheck! %s \n', dataset)
            return
        elseif h == 1
             fprintf('Significant difference in TIV between males and females in age-matched table in dataset %s \n', dataset)
        end
        clear h p ci stats

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % check that there is no sign. diff in age-distributions between
        % age-matched and age-TIV-matched sample:
        [h,p,ci,stats] = ttest2(cell2mat(age_matched_subjects.age), cell2mat(big_table_age_TIV_matched.age));
        if h == 0
            fprintf('No significant difference in age between age-matched and age-TIV-matched table in dataset %s \n', dataset)
        elseif h == 1
             fprintf('Significant difference in age between age-matched and age-TIV-matched table in dataset %s, Need to recheck!\n', dataset)
             return 
        end
        clear h p ci stats

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % double check that there is no overlap between age-matched and
        % age-TIV-matched sample:
        all_IDs = [age_matched_subjects.Subject; big_table_age_TIV_matched.Subject];

        if isequal( size(unique(all_IDs),1), ( size(age_matched_subjects,1) + size(big_table_age_TIV_matched,1) ) )
            fprintf('No overlap in age-matched and age-TIV-matched tables! \n');
        else
            fprintf('Overlap in age-matched and age-TIV-matched tables! Need to recheck! \n');
            return
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

        % delete old and save new data:
        old_age_matched_table = fullfile(savedir, [dataset, '_big_table_age_matched_no_adjusted_age_ranges.mat']);
        delete(old_age_matched_table)
        
        big_table_matched_subjects = age_matched_subjects;
        save(fullfile(savedir, [dataset, '_big_table_age_matched']), 'big_table_matched_subjects')

 end
         