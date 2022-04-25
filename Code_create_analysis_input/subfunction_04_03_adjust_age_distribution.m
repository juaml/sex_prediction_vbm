
%%% since the age-matched sample may contain more subjects than the
%%% age-TIV-matched sample, a similar N for both samples but also an equal
%%% age-distribution needs to be ensured
%%% Therefore, the following function computes the number of subjects in all
%%% age levels in the age-TIV-matched sample and selects the same number of
%%% subjects of the respective age level in the age-matched sample:

function subfunction_04_03_adjust_age_distribution(savedir, dataset)

% load age-TIV-matched and age-matched table:
big_table_age_TIV_matched = load(fullfile(savedir, [dataset, '_big_table_age_TIV_matched']));
big_table_age_TIV_matched = big_table_age_TIV_matched.big_table_matched_subjects;

big_table_age_matched = load(fullfile(savedir, [dataset, '_big_table_age_matched_no_adjusted_age_ranges']));
big_table_age_matched = big_table_age_matched.big_table_matched_subjects;


% in case the age-TIV-matched file is bigger than the age-matched file,
% this code won´ work, return to initial script:
if size(big_table_age_TIV_matched,1) > size(big_table_age_matched,1)
    fprintf('More subjects in age-TIV-matched-table than in age-matched table, age-distribution adjustment will not work! \n') 
    return
end

% select only females in age-TIV-matched table (a respective male-match of
% a female subject might be in a different age-level even though the
% age-difference is less then 1 e.g. 29.9 and 30.8)
age_TIV_matched_subjects_females = big_table_age_TIV_matched(cell2mat(big_table_age_TIV_matched.sex) == 'F',:);

% define limits for each age-level:
nr_sub_younger_20 = sum(cell2mat(age_TIV_matched_subjects_females.age) < 20);
nr_sub_20_to_29 = sum( cell2mat(age_TIV_matched_subjects_females.age) >= 20 & cell2mat(age_TIV_matched_subjects_females.age) < 30 );
nr_sub_30_to_39 = sum( cell2mat(age_TIV_matched_subjects_females.age) >= 30 & cell2mat(age_TIV_matched_subjects_females.age) < 40 );
nr_sub_40_to_49 = sum( cell2mat(age_TIV_matched_subjects_females.age) >= 40 & cell2mat(age_TIV_matched_subjects_females.age) < 50 );
nr_sub_50_to_59 = sum( cell2mat(age_TIV_matched_subjects_females.age) >= 50 & cell2mat(age_TIV_matched_subjects_females.age) < 60 );
nr_sub_older_60 = sum( cell2mat(age_TIV_matched_subjects_females.age) >= 60);

% safety check whether all subjects are covered with these age-groups:
if size(age_TIV_matched_subjects_females,1) ~= nr_sub_younger_20 + nr_sub_20_to_29 + nr_sub_30_to_39 + nr_sub_40_to_49 + nr_sub_50_to_59 + nr_sub_older_60
    fprintf('Need to recheck numbers in age-groups! \n')
    return
end

% select only females from the age-matched table, so that the assignment
% with the numbers defined above can work appropriately:
age_matched_subjects_females = big_table_age_matched(cell2mat(big_table_age_matched.sex) == 'F',:);

% divide table into the age-groups:
age_matched_subjects_females_younger_20 = age_matched_subjects_females( cell2mat(age_matched_subjects_females.age) < 20,:);
age_matched_subjects_females_20_29 = age_matched_subjects_females( cell2mat(age_matched_subjects_females.age) >= 20 & cell2mat(age_matched_subjects_females.age) < 30 ,:);
age_matched_subjects_females_30_39 = age_matched_subjects_females( cell2mat(age_matched_subjects_females.age) >= 30 & cell2mat(age_matched_subjects_females.age) < 40 ,:);
age_matched_subjects_females_40_49 = age_matched_subjects_females( cell2mat(age_matched_subjects_females.age) >= 40 & cell2mat(age_matched_subjects_females.age) < 50 ,:);
age_matched_subjects_females_50_59 = age_matched_subjects_females( cell2mat(age_matched_subjects_females.age) >= 50 & cell2mat(age_matched_subjects_females.age) < 60 ,:);
age_matched_subjects_females_older_60 = age_matched_subjects_females( cell2mat(age_matched_subjects_females.age) >= 60,:);

% safety check whether all subjects are covered with these age-groups:
if size(age_matched_subjects_females,1) ~= size(age_matched_subjects_females_younger_20,1) + size(age_matched_subjects_females_20_29,1) + size(age_matched_subjects_females_30_39,1) + size(age_matched_subjects_females_40_49,1) + size(age_matched_subjects_females_50_59,1) + size(age_matched_subjects_females_older_60,1)
    fprintf('Need to recheck numbers in age-matched age-groups! \n')
    return
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if one of the numbers of the age-TIV-matched age-group is higher than the
% number of subjects in the respective age-group, try age-quartiles
% instead;
% if this is not the case, iterate through all age-groups and define a
% new-age-matched table having the same N as the age-TIV-matched table:

if nr_sub_younger_20 > size(age_matched_subjects_females_younger_20,1) | nr_sub_20_to_29 > size(age_matched_subjects_females_20_29,1) | nr_sub_30_to_39 > size(age_matched_subjects_females_30_39,1) | nr_sub_40_to_49 > size(age_matched_subjects_females_40_49,1) | nr_sub_50_to_59 > size(age_matched_subjects_females_50_59,1) | nr_sub_older_60 > size(age_matched_subjects_females_older_60,1)
    fprintf('Adjusting age-distributions via age-steps (with 10 years each) won´t work, try quartiles instead \n')
    subfunction_04_04_adjust_age_distribution_quartiles(savedir, dataset, big_table_age_TIV_matched, big_table_age_matched)
else
    
         % define emtpy table to save the women that were selected from each
         % age-splitted array:
         limited_females_of_age_groups = table();
         n = 1;

         % iterate through all age-splitted arrays an save the females until the
         % limit for each age-class is reached in the previously defined table:

         for i = 1:nr_sub_younger_20
             limited_females_of_age_groups(n,:) = age_matched_subjects_females_younger_20(i,:);
             n = n+1;
         end
         clear i

         for i = 1:nr_sub_20_to_29
             limited_females_of_age_groups(n,:) = age_matched_subjects_females_20_29(i,:);
             n = n+1;
         end
         clear i

         for i = 1:nr_sub_30_to_39
             limited_females_of_age_groups(n,:) = age_matched_subjects_females_30_39(i,:);
             n = n+1;
         end
         clear i

         for i = 1:nr_sub_40_to_49
             limited_females_of_age_groups(n,:) = age_matched_subjects_females_40_49(i,:);
             n = n+1;
         end
         clear i

         for i = 1:nr_sub_50_to_59
             limited_females_of_age_groups(n,:) = age_matched_subjects_females_50_59(i,:);
             n = n+1;
         end
         clear i

         for i = 1:nr_sub_older_60
             limited_females_of_age_groups(n,:) = age_matched_subjects_females_older_60(i,:);
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
             fprintf('Unequal nr. of subjects in age-matched and age-TIV-matched table! Need to recheck! \n');
             return
         end
        

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        % check whether males and females do not differ in age, but do differ in TIV:
        index_matched_subjects_males = cell2mat(age_matched_subjects.sex) == 'M';
        index_matched_subjects_females = cell2mat(age_matched_subjects.sex) == 'F';

        %%% ttest age
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
        [h,p,ci,stats] = ttest2( cell2mat(age_matched_subjects.age), cell2mat(big_table_age_TIV_matched.age));
        if h == 0
            fprintf('No significant difference in age between age-matched and age-TIV-matched table in dataset %s \n', dataset)
        elseif h == 1
             fprintf('Significant difference in age between age-matched and age-TIV-matched table in dataset %s, Try adjustment via quartiles instead! \n', dataset)
             subfunction_04_04_adjust_age_distribution_quartiles(savedir, dataset, big_table_age_TIV_matched, big_table_age_matched)
             
             % if the adjustment via quartiles worked return, otherwise
             % throw error message and move on to the next dataset
             if exist (fullfile(savedir, [dataset, '_big_table_age_matched.mat']))
                 fprintf('Adjustment via quartiles worked!')
                 return
             else
                 fprintf('Adjustment via quartiles did not work!')
                 return
             end
              
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
        clear big_table_age_matched

        % delete old and save new data:
        old_age_matched_table = fullfile(savedir, [dataset, '_big_table_age_matched_no_adjusted_age_ranges.mat']);
        delete(old_age_matched_table)
        
        big_table_matched_subjects = age_matched_subjects;
        save(fullfile(savedir, [dataset, '_big_table_age_matched']), 'big_table_matched_subjects')

end
