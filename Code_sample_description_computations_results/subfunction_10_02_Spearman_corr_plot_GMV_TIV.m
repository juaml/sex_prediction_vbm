
function subfunction_10_02_Spearman_corr_plot_GMV_TIV(savedir, table, dataname, plotname)

%%% compute spearman rank correlations:

index_females = strcmp(table.sex, 'F');
index_males = strcmp(table.sex, 'M');

% compute correlation with GMV:
[rho,pval] = corr(cell2mat(table.GMV), cell2mat(table.TIV), 'type', 'Spearman');
save(fullfile(savedir, ['Corr_Spearman_',dataname, '_GMV_TIV']), 'rho', 'pval')

% save correlation values as strings:
txt_rho = ['rho = ', num2str(rho)];
txt_pval = ['pval = ', num2str(pval)];
clear rho pval

%%% compute correlation separately for males and females:

% females:
[rho,pval] = corr(cell2mat(table.GMV(index_females)), cell2mat(table.TIV(index_females)), 'type', 'Spearman');
save(fullfile(savedir, ['Corr_Spearman', dataname, '_GMV_TIV_females']), 'rho', 'pval')

txt_rho_females = ['rho = ', num2str(rho)];
txt_pval_females = ['pval = ', num2str(pval)];
clear rho pval

% males:
[rho,pval] = corr(cell2mat(table.GMV(index_males)), cell2mat(table.TIV(index_males)), 'type', 'Spearman');
save(fullfile(savedir, ['Corr_Spearman_', dataname, '_GMV_TIV_males']), 'rho', 'pval')

txt_rho_males = ['rho = ', num2str(rho)];
txt_pval_males = ['pval = ', num2str(pval)];
clear rho pval

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
hold on
scatter(cell2mat(table.GMV), cell2mat(table.TIV))
h = lsline
set(h(1),'color','r')
set(h,'LineWidth',1)
xlabel('GMV');
ylabel('TIV');
title(plotname)
xlim([350 1000])
ylim([950 2100])

% corr-values in figure:
text(370, 2050, txt_rho)
text(370, 2000, txt_pval)

text(370, 1900, 'corr females:')
text(370, 1850, txt_rho_females)
text(370, 1800, txt_pval_females)

text(370, 1700, 'corr males:')
text(370, 1650, txt_rho_males)
text(370, 1600, txt_pval_males)



% t-statistics in figure:
%text(650, 1200, txt_GMV)
%text(650, 1150, txt_TIV)

hold off
saveas(gcf, fullfile(savedir, [dataname, '_GMV_TIV_corr_spearman']), 'jpeg')
