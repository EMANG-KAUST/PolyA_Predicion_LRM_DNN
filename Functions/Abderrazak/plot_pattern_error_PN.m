function  plot_pattern_error_PN(figr, W_pos, W_neg, W_err, W_err_sm, lgnd)
figure(figr);
    subplot(211);
    plot(W_pos,'LineWidth',2);hold on
    plot(W_neg, 'LineWidth',2);hold off
    A=legend(lgnd);
    A.FontSize=14;
    title(strcat('Extracted DNA sequence pattern '));
    xlabel('position')
    ylabel(strcat('Necleolide Repeatability '));

    set(gca,'fontsize',16)

    subplot(212);
    plot(W_err, 'LineWidth',2);hold on
    plot(W_err_sm, 'LineWidth',2);hold on
    A=legend('|error|','Smoothed error');
    A.FontSize=14;
    title(strcat('Necleolide Repeatability [difference %] '));
    xlabel('position')
    ylabel('Error Difference %')

    set(gca,'fontsize',16)