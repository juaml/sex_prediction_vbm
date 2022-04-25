
function subfunction_03_01_merge_result_files_overview_tables(Path_2_result_txt_files, analysis_input_table, dataname, savedir)

% import predictions:

predictions_table_struct = importdata(fullfile(Path_2_result_txt_files, [dataname, '.txt']));

pred = predictions_table_struct.data(:,1);
pred_proba_0 = predictions_table_struct.data(:,2);
pred_proba_1 = predictions_table_struct.data(:,3);

predictions_table = table(pred, pred_proba_0, pred_proba_1);


%%% merge predictions with overview_table:
merged_table = [predictions_table, analysis_input_table];

save(fullfile(savedir,['merged_table_', dataname]), 'merged_table')
