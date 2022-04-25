% in case the adjustment of age-ranges with the age-quartiles did not work,
% this script adjustes the age-ranges via dividing the age-TIV-matched
% sample into 10 parts according to age:

function subfunction_04_05_adjust_age_distribution_percentiles(savedir, dataset, big_table_age_TIV_matched, big_table_age_matched)

% select only females in age-TIV-matched table (a respective male-match of
% a female subject might be in a different age-level even though the
% age-difference is less then 1 e.g. 29.9 and 30.8)
age_TIV_matched_subjects_females = big_table_age_TIV_matched(cell2mat(big_table_age_TIV_matched.sex) == 'F',:);

% define dataset-specific age-levels by percentiles:
percentiles = prctile(cell2mat(age_TIV_matched_subjects_females.age),[10 20 30 40 50 60 70 80 90]);

% define limits for each age-level:
nr_sub_0_10 = sum(cell2mat(age_TIV_matched_subjects_females.age) < percentiles(1) );
nr_sub_10_20 = sum( cell2mat(age_TIV_matched_subjects_females.age) >= percentiles(1) & cell2mat(age_TIV_matched_subjects_females.age) < percentiles(2) );
nr_sub_20_30 = sum( cell2mat(age_TIV_matched_subjects_females.age) >= percentiles(2) & cell2mat(age_TIV_matched_subjects_females.age) < percentiles(3) );
nr_sub_30_40 = sum( cell2mat(age_TIV_matched_subjects_females.age) >= percentiles(3) & cell2mat(age_TIV_matched_subjects_females.age) < percentiles(4) );
nr_sub_40_50 = sum( cell2mat(age_TIV_matched_subjects_females.age) >= percentiles(4) & cell2mat(age_TIV_matched_subjects_females.age) < percentiles(5) );
nr_sub_50_60 = sum( cell2mat(age_TIV_matched_subjects_females.age) >= percentiles(5) & cell2mat(age_TIV_matched_subjects_females.age) < percentiles(6) );
nr_sub_60_70 = sum( cell2mat(age_TIV_matched_subjects_females.age) >= percentiles(6) & cell2mat(age_TIV_matched_subjects_females.age) < percentiles(7) );
nr_sub_70_80 = sum( cell2mat(age_TIV_matched_subjects_females.age) >= percentiles(7) & cell2mat(age_TIV_matched_subjects_females.age) < percentiles(8) );
nr_sub_80_90 = sum( cell2mat(age_TIV_matched_subjects_females.age) >= percentiles(8) & cell2mat(age_TIV_matched_subjects_females.age) < percentiles(9) );
nr_sub_90_100 = sum( cell2mat(age_TIV_matched_subjects_females.age) >= percentiles(9) );

nr_all_percentiles = nr_sub_0_10 + nr_sub_10_20 + nr_sub_20_30 + nr_sub_30_40 + nr_sub_40_50 + nr_sub_50_60 + nr_sub_60_70 + nr_sub_70_80 + nr_sub_80_90 + nr_sub_90_100;

% safety check whether all subjects are covered with these age-groups:
if size(age_TIV_matched_subjects_females,1) ~= nr_all_percentiles
    fprintf('Need to recheck numbers in age-groups! \n')
    return
end

% select only females from the age-matched table, so that the assignment
% with the numbers defined above can work appropriately:
age_matched_subjects_females = big_table_age_matched(cell2mat(big_table_age_matched.sex) == 'F',:);

% divide table into the age-groups:
age_matched_females_0_10_per = age_matched_subjects_females( cell2mat(age_matched_subjects_females.age) < percentiles(1),:);
age_matched_females_10_20_per = age_matched_subjects_females( cell2mat(age_matched_subjects_females.age) >= percentiles(1) & cell2mat(age_matched_subjects_females.age) < percentiles(2) ,:);
age_matched_females_20_30_per = age_matched_subjects_females( cell2mat(age_matched_subjects_females.age) >= percentiles(2) & cell2mat(age_matched_subjects_females.age) < percentiles(3) ,:);
age_matched_females_30_40_per = age_matched_subjects_females( cell2mat(age_matched_subjects_females.age) >= percentiles(3) & cell2mat(age_matched_subjects_females.age) < percentiles(4) ,:);
age_matched_females_40_50_per = age_matched_subjects_females( cell2mat(age_matched_subjects_females.age) >= percentiles(4) & cell2mat(age_matched_subjects_females.age) < percentiles(5) ,:);
age_matched_females_50_60_per = age_matched_subjects_females( cell2mat(age_matched_subjects_females.age) >= percentiles(5) & cell2mat(age_matched_subjects_females.age) < percentiles(6) ,:);
age_matched_females_60_70_per = age_matched_subjects_females( cell2mat(age_matched_subjects_females.age) >= percentiles(6) & cell2mat(age_matched_subjects_females.age) < percentiles(7) ,:);
age_matched_females_70_80_per = age_matched_subjects_females( cell2mat(age_matched_subjects_females.age) >= percentiles(7) & cell2mat(age_matched_subjects_females.age) < percentiles(8) ,:);
age_matched_females_80_90_per = age_matched_subjects_females( cell2mat(age_matched_subjects_females.age) >= percentiles(8) & cell2mat(age_matched_subjects_females.age) < percentiles(9) ,:);
age_matched_females_90_100_per = age_matched_subjects_females( cell2mat(age_matched_subjects_females.age) >= percentiles(9) ,:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% safety check whether all subjects are covered with these age-groups:
nr_all_age_matched_subjects = size(age_matched_females_0_10_per,1) + size(age_matched_females_10_20_per,1) + size(age_matched_females_20_30_per,1) + size(age_matched_females_30_40_per,1) + size(age_matched_females_40_50_per,1) + size(age_matched_females_50_60_per,1) + size(age_matched_females_60_70_per,1) + size(age_matched_females_70_80_per,1) + size(age_matched_females_80_90_per,1) + size(age_matched_females_90_100_per,1);                             

if size(age_matched_subjects_females,1) ~= nr_all_age_matched_subjects
    fprintf('Need to recheck numbers in age-matched age-groups! \n')
    return
end

% if one of the numbers of the age-TIV-matched age-group is higher than the
% number of subjects in the respective age-group, move on to the next
% dataset;
% if this is not the case, iterate through all age-groups and define a
% new-age-matched table having the same N as the age-TIV-matched table:

if nr_sub_0_10 > size(age_matched_females_0_10_per,1) | nr_sub_10_20 > size(age_matched_females_10_20_per,1) | nr_sub_20_30 > size(age_matched_females_20_30_per,1) | nr_sub_30_40 > size(age_matched_females_30_40_per,1) | nr_sub_40_50 > size(age_matched_females_40_50_per,1) | nr_sub_50_60 > size(age_matched_females_50_60_per,1) | nr_sub_60_70 > size(age_matched_females_60_70_per,1) | nr_sub_70_80 > size(age_matched_females_70_80_per,1) | nr_sub_90_100 > size(age_matched_females_90_100_per,1)
    fprintf('Adjusting age-distributions via percentiles won´t work! Try median-split instead! \n')
    subfunction_04_06_adjust_age_distribution_median(savedir, dataset, big_table_age_TIV_matched, big_table_age_matched)
else

         % define emtpy table to save the women that were selected from each
         % age-splitted array:
         limited_females_of_age_groups = table();
         n = 1;

         % iterate through all age-splitted arrays an save the females until the
         % limit for both age-classes is reached in the previously defined table:

         for i = 1:nr_sub_0_10_per
             limited_females_of_age_groups(n,:) = age_matched_females_0_10_per(i,:);
             n = n+1;  
         end
         clear i
         
         for i = 1:nr_sub_10_20_per
             limited_females_of_age_groups(n,:) = age_matched_females_10_20_per(i,:);
             n = n+1;  
         end
         clear i
         
         for i = 1:nr_sub_20_30_per
             limited_females_of_age_groups(n,:) = age_matched_females_20_30_per(i,:);
             n = n+1;  
         end
         clear i
         
         for i = 1:nr_sub_30_40_per
             limited_females_of_age_groups(n,:) = age_matched_females_30_40_per(i,:);
             n = n+1;  
         end
         clear i
         
         for i = 1:nr_sub_40_50_per
             limited_females_of_age_groups(n,:) = age_matched_females_40_50_per(i,:);
             n = n+1;  
         end
         clear i
         
         for i = 1:nr_sub_50_60_per
             limited_females_of_age_groups(n,:) = age_matched_females_50_60_per(i,:);
             n = n+1;  
         end
         clear i
         
         for i = 1:nr_sub_60_70_per
             limited_females_of_age_groups(n,:) = age_matched_females_60_70_per(i,:);
             n = n+1;  
         end
         clear i
         
         for i = 1:nr_sub_70_80_per
             limited_females_of_age_groups(n,:) = age_matched_females_70_80_per(i,:);
             n = n+1;  
         end
         clear i
         
         for i = 1:nr_sub_80_90_per
             limited_females_of_age_groups(n,:) = age_matched_females_80_90_per(i,:);
             n = n+1;  
         end
         clear i
         
         for i = 1:nr_sub_90_100_per
             limited_females_of_age_groups(n,:) = age_matched_females_90_100_per(i,:);
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
             fprintf('Significant difference in age between age-matched and age-TIV-matched table in dataset %s, Try median-split instead!\n', dataset)
             subfunction_04_06_adjust_age_distribution_median(savedir, dataset, big_table_age_TIV_matched, big_table_age_matched)
             %return
             
             % if the adjustment via median-split worked return, otherwise
             % throw error message and move on to the next dataset
             if exist (fullfile(savedir, [dataset, '_big_table_age_matched.mat']))
                 fprintf('Adjustment via median-split worked!')
                 return
             else
                 fprintf('Adjustment via median-split did not work!')
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

        % delete old and save new data:
        old_age_matched_table = fullfile(savedir, [dataset, '_big_table_age_matched_no_adjusted_age_ranges.mat']);
        delete(old_age_matched_table)
        
        big_table_matched_subjects = age_matched_subjects;
        save(fullfile(savedir, [dataset, '_big_table_age_matched']), 'big_table_matched_subjects')

end
