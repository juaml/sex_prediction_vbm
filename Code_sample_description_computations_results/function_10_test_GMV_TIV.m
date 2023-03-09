
function function_10_test_GMV_TIV(Path_2_analysis_input)

%%% create new directory to save the variables:
if ~exist('10_test_TIV_GMV', 'dir')
    mkdir('10_test_TIV_GMV')
end

savedir = fullfile(pwd, '10_test_TIV_GMV');
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load training data:

% AM training & test:
AM_train_table = load(fullfile(Path_2_analysis_input, 'age_matched_train_sample_80per_overview_table.mat'));

AM_test_table = load(fullfile(Path_2_analysis_input, 'age_matched_test_sample_20_per_overview_table.mat'));


% ATM training & test:
ATM_train_table = load(fullfile(Path_2_analysis_input, 'age_TIV_matched_train_sample_80per_overview_table.mat'));

ATM_test_table = load(fullfile(Path_2_analysis_input, 'age_TIV_matched_test_sample_20_per_overview_table.mat'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% plot GMV and TIV:

% AM train & test separate and combined:

table = AM_train_table.analysis_input_table;
dataname = 'AM_train';
plotname = 'AM training sample';
subfunction_10_01_corr_plot_GMV_TIV(savedir, table, dataname, plotname)
subfunction_10_02_Spearman_corr_plot_GMV_TIV(savedir, table, dataname, plotname)
clear table dataname plotname

table = AM_test_table.analysis_input_table;
dataname = 'AM_test';
plotname = 'AM test sample';
subfunction_10_01_corr_plot_GMV_TIV(savedir, table, dataname, plotname)
subfunction_10_02_Spearman_corr_plot_GMV_TIV(savedir, table, dataname, plotname)
clear table dataname plotname

table = [AM_train_table.analysis_input_table; AM_test_table.analysis_input_table];
dataname = 'AM_train_test_combined';
plotname = 'AM train & test sample combined';
subfunction_10_01_corr_plot_GMV_TIV(savedir, table, dataname, plotname)
subfunction_10_02_Spearman_corr_plot_GMV_TIV(savedir, table, dataname, plotname)
clear table dataname plotname


% ATM train & test separate and combined:

table = ATM_train_table.analysis_input_table;
dataname = 'ATM_train';
plotname = 'ATM training sample';
subfunction_10_01_corr_plot_GMV_TIV(savedir, table, dataname, plotname)
subfunction_10_02_Spearman_corr_plot_GMV_TIV(savedir, table, dataname, plotname)
clear table dataname plotname

table = ATM_test_table.analysis_input_table;
dataname = 'ATM_test';
plotname = 'ATM test sample';
subfunction_10_01_corr_plot_GMV_TIV(savedir, table, dataname, plotname)
subfunction_10_02_Spearman_corr_plot_GMV_TIV(savedir, table, dataname, plotname)
clear table dataname plotname

table = [ATM_train_table.analysis_input_table; ATM_test_table.analysis_input_table];
dataname = 'ATM_train_test_combined';
plotname = 'ATM train & test sample combined';
subfunction_10_01_corr_plot_GMV_TIV(savedir, table, dataname, plotname)
subfunction_10_02_Spearman_corr_plot_GMV_TIV(savedir, table, dataname, plotname)
clear table dataname plotname




% AM and ATM train & test separate and combined:
table = [AM_train_table.analysis_input_table; AM_test_table.analysis_input_table; ATM_train_table.analysis_input_table; ATM_test_table.analysis_input_table];
dataname = 'AM_ATM_train_test_combined';
plotname = 'AM ATM train & test sample combined';
subfunction_10_01_corr_plot_GMV_TIV(savedir, table, dataname, plotname)
subfunction_10_02_Spearman_corr_plot_GMV_TIV(savedir, table, dataname, plotname)
clear table dataname plotname
