
function subfunction_04_01_compute_classification_report(Path_2_merged_tables, savedir, dataname)

% load merged table:
load(fullfile(Path_2_merged_tables, ['merged_table_', dataname]));

% m = 0
% f = 1

% compute how often males and females were classified correctly and not:

N_actual_males = sum(cell2mat(merged_table.sex) == 'M');
N_actual_females = sum(cell2mat(merged_table.sex) == 'F');

N_actual_male_pred_male = sum(cell2mat(merged_table.sex) == 'M' & merged_table.pred == 0);
N_actual_male_pred_female = sum(cell2mat(merged_table.sex) == 'M' & merged_table.pred == 1);

N_actual_female_pred_female = sum(cell2mat(merged_table.sex) == 'F' & merged_table.pred == 1);
N_actual_female_pred_male = sum(cell2mat(merged_table.sex) == 'F' & merged_table.pred == 0);

% safety check whether the numbers make sense:
if N_actual_male_pred_male + N_actual_male_pred_female == N_actual_males
    
else
    fprintf('Numbers of predictions do not make sense for males in sample %s ! Need to recheck! \n', savename)
    return
end
        
if N_actual_female_pred_male + N_actual_female_pred_female == N_actual_females

    else
    fprintf('Numbers of predictions do not make sense for females in sample %s ! Need to recheck! \n', savename)
    return
end


%%% compute relevant numbers:

%  transfer numbers to confusion matrix terms (prediction of males)
TP = N_actual_male_pred_male;
TN = N_actual_female_pred_female;
FP = N_actual_female_pred_male;
FN = N_actual_male_pred_female;

%%% save numbers in the variable confusion matrix:
confusion_matrix.TP = TP;
confusion_matrix.TN = TN;
confusion_matrix.FP = FP;
confusion_matrix.FN = FN;

confusion_matrix.N_actual_male_pred_male = N_actual_male_pred_male;
confusion_matrix.N_actual_female_pred_female = N_actual_female_pred_female;
confusion_matrix.N_actual_female_pred_male = N_actual_female_pred_male;
confusion_matrix.N_actual_male_pred_female = N_actual_male_pred_female;



% sensitivity/recall/true positive rate (TPR):
recall_TPR = TP/(TP+FN);

% precision (positive predictive value, PPV):
precision_PPV = TP/(TP+FP);


% specificity/selectivity/true negative rate (TNR):
specificity_TNR = TN/(TN+FP);

% negative predictive value (NPV):
NPV = TN/(TN+FN);



% f1-score:
f1 = 2*( (precision_PPV * recall_TPR)/(precision_PPV + recall_TPR) );

% accuracy:
accuracy = (TP+TN)/(TP+TN+FP+FN);

% balanced accuracy:
BA = (recall_TPR + specificity_TNR)/2;



%%% save data:
save(fullfile(savedir, ['classification_report_' ,dataname]), 'N_actual_males', 'N_actual_females', 'confusion_matrix', 'recall_TPR', 'precision_PPV', 'specificity_TNR', 'NPV', 'f1', 'accuracy', 'BA')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
