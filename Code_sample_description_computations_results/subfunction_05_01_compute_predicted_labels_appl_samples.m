

function subfunction_05_01_compute_predicted_labels_appl_samples(Path_2_merged_tables, savedir, dataname)

% load table:
load(fullfile(Path_2_merged_tables, ['merged_table_', dataname]));

% define indexes for cis- and transgender males and females:
index_CM = strcmp(merged_table.group, 'CM');
index_CW = strcmp(merged_table.group, 'CW');
index_TW = strcmp(merged_table.group, 'TW');
index_TM = strcmp(merged_table.group, 'TM');

% define separate tables for each group (easier for later computations):
table_CM = merged_table(index_CM,:);
table_CW = merged_table(index_CW,:);
table_TW = merged_table(index_TW,:);
table_TM = merged_table(index_TM,:);


% calculate amount of subjects predicted as male (0) or female (1):
CM_pred_as_0_male = sum(table_CM.pred == 0);
CM_pred_as_1_female = sum(table_CM.pred == 1);

CW_pred_as_0_male = sum(table_CW.pred == 0);
CW_pred_as_1_female = sum(table_CW.pred == 1);

TW_pred_as_0_male = sum(table_TW.pred == 0);
TW_pred_as_1_female = sum(table_TW.pred == 1);

TM_pred_as_0_male = sum(table_TM.pred == 0);
TM_pred_as_1_female = sum(table_TM.pred == 1);


%%% compute TPRs for each category:
TPR.CM = CM_pred_as_0_male/size(table_CM,1);
TPR.CW = CW_pred_as_1_female/size(table_CW,1);
TPR.TM = TM_pred_as_1_female/size(table_TM,1);
TPR.TW = TW_pred_as_0_male/size(table_TW,1);


%%% separate accuracies for cisgender and transgender individuals:
% accuracy = (TP+TN)/(TP+TN+FP+FN);

% cisgender:
accuracy_cisgender = (CM_pred_as_0_male + CW_pred_as_1_female)/(CM_pred_as_0_male + CM_pred_as_1_female + CW_pred_as_0_male + CW_pred_as_1_female);

% transgender:
accuracy_transgender = (TM_pred_as_1_female + TW_pred_as_0_male)/(TM_pred_as_1_female + TM_pred_as_0_male + TW_pred_as_0_male + TW_pred_as_1_female);


save(fullfile(savedir, [dataname, '_predicted_transgender_labels']), 'TPR', 'CM_pred_as_0_male', 'CM_pred_as_1_female', 'CW_pred_as_0_male', 'CW_pred_as_1_female', 'TW_pred_as_0_male', 'TW_pred_as_1_female', 'TM_pred_as_0_male', 'TM_pred_as_1_female', 'accuracy_cisgender', 'accuracy_transgender')




