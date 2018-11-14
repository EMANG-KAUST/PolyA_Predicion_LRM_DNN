function [accuracy0,sensitivity0,specificity0,precision0,gmean0,f1score0,ytrue,yfit,C]=Test_LR(Mdl,Combine_TS)

[M_TS,N_TS]=size(Combine_TS);
testing_set = array2table(NO_T(Combine_TS));
testing_set.class = Combine_TS(:,end);

%% Model_testing 
yfit0 = Mdl.predict(testing_set);
yfit0=yfit0-min(yfit0);yfit0=yfit0/max(yfit0);
yfit=double(yfit0>0.5);

%% Compute the accuracy
[accuracy0,sensitivity0,specificity0,precision0,gmean0,f1score0,CC]=prediction_performance(testing_set.class, yfit);
ytrue=Combine_TS(:,end);

C=CC(:)';



