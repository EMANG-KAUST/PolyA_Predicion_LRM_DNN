function [Mdl,accuracy0,sensitivity0,specificity0,precision0,gmean0,f1score0,ytrue,yfit]=Training_LR(Combine_TR)
% %%% ####################################### 
[M,N]=size(Combine_TR);
training_set= array2table(NO_T(Combine_TR));
training_set.class = Combine_TR(:,end);

%% Model training
Mdl= fitglm(training_set,'linear','Distribution','binomial','link', 'logit');






