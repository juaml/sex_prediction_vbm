function subfunction_10_01_corr_plot_GMV_TIV(savedir, table, dataname, plotname)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% t-tests females and males for TIV and GMV:


index_females = strcmp(table.sex, 'F');
index_males = strcmp(table.sex, 'M');


[h, p, ci, stats] = ttest2(cell2mat(table.TIV(index_females)), cell2mat(table.TIV(index_males)));
ttest_TIV.h = h;
ttest_TIV.p = p;
ttest_TIV.ci = ci;
ttest_TIV.stats = stats;
clear h p ci stats
save(fullfile(savedir, [dataname, '_sample_ttests_TIV']), 'ttest_TIV')


[h, p, ci, stats] = ttest2(cell2mat(table.GMV(index_females)), cell2mat(table.GMV(index_males)));
ttest_GMV.h = h;
ttest_GMV.p = p;
ttest_GMV.ci = ci;
ttest_GMV.stats = stats;
clear h p ci stats
save(fullfile(savedir, [dataname, '_sample_ttests_GMV']), 'ttest_GMV')

% demographic variables for GMV for males and feamles:

GMV_females.min = min(cell2mat(table.GMV(index_females)));
GMV_females.max = max(cell2mat(table.GMV(index_females)));
GMV_females.mean = mean(cell2mat(table.GMV(index_females)));
GMV_females.median = median(cell2mat(table.GMV(index_females)));
GMV_females.std = std(cell2mat(table.GMV(index_females)));

GMV_males.min = min(cell2mat(table.GMV(index_males)));
GMV_males.max = max(cell2mat(table.GMV(index_males)));
GMV_males.mean = mean(cell2mat(table.GMV(index_males)));
GMV_males.median = median(cell2mat(table.GMV(index_males)));
GMV_males.std = std(cell2mat(table.GMV(index_males)));

save(fullfile(savedir, [dataname, '_sample_demographic_variables_GMV']), 'GMV_females', 'GMV_males')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

txt_GMV = ['ttest GMV: h = ', num2str(ttest_GMV.h), ', pval = ', num2str(ttest_GMV.p), ', t-value = ', num2str(ttest_GMV.stats.tstat)];
txt_TIV = ['ttest TIV: h = ', num2str(ttest_TIV.h), ', pval = ', num2str(ttest_TIV.p), ', t-value = ', num2str(ttest_TIV.stats.tstat)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% compute correlation with GMV:
[rho,pval] = corr(cell2mat(table.GMV), cell2mat(table.TIV));
save(fullfile(savedir, ['Corr_',dataname, '_GMV_TIV']), 'rho', 'pval')

% save correlation values as strings:
txt_rho = ['r = ', num2str(rho)];
txt_pval = ['pval = ', num2str(pval)];
clear rho pval

%%% compute correlation separately for males and females:

% females:
[rho,pval] = corr(cell2mat(table.GMV(index_females)), cell2mat(table.TIV(index_females)));
save(fullfile(savedir, ['Corr_', dataname, '_GMV_TIV_females']), 'rho', 'pval')

txt_rho_females = ['r = ', num2str(rho)];
txt_pval_females = ['pval = ', num2str(pval)];
clear rho pval

% males:
[rho,pval] = corr(cell2mat(table.GMV(index_males)), cell2mat(table.TIV(index_males)));
save(fullfile(savedir, ['Corr', dataname, '_GMV_TIV_males']), 'rho', 'pval')

txt_rho_males = ['r = ', num2str(rho)];
txt_pval_males = ['pval = ', num2str(pval)];
clear rho pval

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
hold on
scatter(cell2mat(table.GMV), cell2mat(table.TIV))
xlim([350 1000])
ylim([950 2100])
h = lsline
set(h(1),'color','r')
set(h,'LineWidth',1)
xlabel('GMV');
ylabel('TIV');
title(plotname)


% corr-values in figure:
text(370, 2050, txt_rho)
text(370, 2000, txt_pval)

%text(370, 1900, 'corr females:')
%text(370, 1850, txt_rho_females)
%text(370, 1800, txt_pval_females)

%text(370, 1700, 'corr males:')
%text(370, 1650, txt_rho_males)
%text(370, 1600, txt_pval_males)



% t-statistics in figure:
text(650, 1200, txt_GMV)
text(650, 1150, txt_TIV)

hold off
saveas(gcf, fullfile(savedir, [dataname, '_GMV_TIV_corr']), 'jpeg')



%%% plot correlation separately for males and females:
figure
hold on
scatter(cell2mat(table.GMV(index_females)), cell2mat(table.TIV(index_females)), 'red')
scatter(cell2mat(table.GMV(index_males)), cell2mat(table.TIV(index_males)), 'blue')
legend('females', 'males')
xlabel('GMV');
ylabel('TIV');
title(plotname)
xlim([350 1000])
ylim([950 2100])


% corr-values in figure:
text(370, 1900, 'corr females:')
text(370, 1850, txt_rho_females)
text(370, 1800, txt_pval_females)

text(370, 1700, 'corr males:')
text(370, 1650, txt_rho_males)
text(370, 1600, txt_pval_males)

% t-statistics in figure:
text(650, 1200, txt_GMV)
text(650, 1150, txt_TIV)

hold off
saveas(gcf, fullfile(savedir, [dataname, '_GMV_TIV_corr_males_females_separated']), 'jpeg')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% separate plots for males and females:

figure
hold on
scatter(cell2mat(table.GMV(index_females)), cell2mat(table.TIV(index_females)), 'red')
xlim([350 1000])
ylim([950 2100])
h = lsline
set(h(1),'color','k')
set(h,'LineWidth',1)
xlabel('GMV');
ylabel('TIV');
title(plotname)
% corr-values in figure:
text(370, 1900, 'corr females:')
text(370, 1850, txt_rho_females)
text(370, 1800, txt_pval_females)
hold off
saveas(gcf, fullfile(savedir, [dataname, '_GMV_TIV_corr_females_only']), 'jpeg')

figure
hold on
scatter(cell2mat(table.GMV(index_males)), cell2mat(table.TIV(index_males)), 'blue')
xlim([350 1000])
ylim([950 2100])
h = lsline
set(h(1),'color','k')
set(h,'LineWidth',1)
xlabel('GMV');
ylabel('TIV');
title(plotname)
% corr-values in figure:
text(370, 1900, 'corr males:')
text(370, 1850, txt_rho_males)
text(370, 1800, txt_pval_males)
hold off
saveas(gcf, fullfile(savedir, [dataname, '_GMV_TIV_corr_males_only']), 'jpeg')
