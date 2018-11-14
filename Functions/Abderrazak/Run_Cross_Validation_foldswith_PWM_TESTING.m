% It rus a k-folds cross validation using some inpur features and their
% corresponding sequances that will be used to genarate PWM feature using PWM_Ratio
% The output results return the optimal Logestic regressin model that gives the
% maximum accuracy in classifying the combined features [ input features + PWM]
% Important: the Pos_Sequences must be used to generate the  Pos_feature
% with the same order. Respctivelly for Neg_Sequences-->Neg_features

function  [CV_Test,ytrue,yfit]=Run_Cross_Validation_foldswith_PWM_TESTING(Mdl_optimal,DSP,Miers, Combined_TS ,PWM_Ratio, Miers1_Seq_pos, Miers1_Seq_neg, Miers2_Seq_pos, Miers2_Seq_neg,...
                                       Miers3_Seq_pos, Miers3_Seq_neg, PWMp_Mier1_k, PWMn_Mier1_k, PWMp_Mier2_k, PWMn_Mier2_k, PWMp_Mier3_k, PWMn_Mier3_k)


%% Split the input features from its  target
[Fp_test,Fn_test,Yp_test,Yn_test]=Split_Features_Pos_Neg(Combined_TS);

fprintf(' --------------------------------------------------------------------------------\n')
fprintf('| The Cross Validation Testing is running with PWM-Ratio= %d  \n',PWM_Ratio)
fprintf(' --------------------------------------------------------------------------------\n')

%% Genrate PWM based features from the generated PWMp_k and PWMn_k matrices

F_PWM_Mier1_TS=Apply_General_PWM_feature_generator(Miers1_Seq_pos,Miers1_Seq_neg, PWMp_Mier1_k,PWMn_Mier1_k);  %Ys_test_Mier1_k =F_PWM_Mier1_TS(:,end);  
F_PWM_Mier2_TS=Apply_General_PWM_feature_generator(Miers2_Seq_pos,Miers2_Seq_neg, PWMp_Mier2_k,PWMn_Mier2_k);  %Ys_test_Mier2_k =F_PWM_Mier2_TS(:,end);  
F_PWM_Mier3_TS=Apply_General_PWM_feature_generator(Miers3_Seq_pos,Miers3_Seq_neg, PWMp_Mier3_k,PWMn_Mier3_k);  Ys_test_k =F_PWM_Mier3_TS(:,end);  

%% Get the appropriate fold part from the input Features 
Other_features_test_k=[Fp_test(:,1:end-1);Fn_test(:,1:end-1)];

 NB_Miers=size(Miers,2);
if NB_Miers==1  
        PWM_Features_test_k=F_PWM_Mier1_TS(:,1:end-1);

    elseif NB_Miers==2
            PWM_Features_test_k=[F_PWM_Mier1_TS(:,1:end-1) F_PWM_Mier2_TS(:,1:end-1)];

        elseif NB_Miers==3
                PWM_Features_test_k=[F_PWM_Mier1_TS(:,1:end-1) F_PWM_Mier2_TS(:,1:end-1) F_PWM_Mier3_TS(:,1:end-1)];

end
% 
if DSP==0
     Fold_k_TS=[PWM_Features_test_k     Ys_test_k ];

elseif DSP==1
       Fold_k_TS=[Other_features_test_k   Ys_test_k ];


    elseif DSP==2
        Fold_k_TS=[PWM_Features_test_k   Other_features_test_k   Ys_test_k ];

end

[accuracy,sensitivity,specificity,precision,gmean,f1score,ytrue,yfit]=Test_LR(Mdl_optimal,Fold_k_TS);

CV_Test=[accuracy,sensitivity,specificity,precision,gmean,f1score];

%% Run the logitic regression 
