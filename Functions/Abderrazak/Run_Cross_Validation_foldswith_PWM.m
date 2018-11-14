% It rus a k-folds cross validation using some inpur features and their
% corresponding sequances that will be used to genarate PWM feature using PWM_Ratio
% The output results return the optimal Logestic regressin model that gives the
% maximum accuracy in classifying the combined features [ input features + PWM]
% Important: the Pos_Sequences must be used to generate the  Pos_feature
% with the same order. Respctivelly for Neg_Sequences-->Neg_features

function  [Mdl_optimal,Acc_Max, CV_results, CV_Accuracy, PWMp_Mier1_k_op, PWMn_Mier1_k_op, PWMp_Mier2_k_op, PWMn_Mier2_k_op, PWMp_Mier3_k_op, PWMn_Mier3_k_op]=Run_Cross_Validation_foldswith_PWM...
    (nb_folds,DSP,Miers, Combined_TR ,PWM_Ratio, Miers1_Seq_pos, Miers1_Seq_neg, Miers2_Seq_pos, Miers2_Seq_neg, Miers3_Seq_pos, Miers3_Seq_neg)


%% Split the input features from its  target
[Fp_train,Fn_train,Yp_train,Yn_train]=Split_Features_Pos_Neg(Combined_TR);

%% Create the partitions
Idx_seq=1:size(Fp_train,1);cnt0=0;Acc_Max=0;
CVO = cvpartition(Idx_seq,'k',nb_folds);
fprintf(' --------------------------------------------------------------------------------\n')
fprintf('| The Cross Validation training is running using %d Fold  with PWM-Ratio= %d  \n',nb_folds,PWM_Ratio)
fprintf(' --------------------------------------------------------------------------------\n')


for i = 1:CVO.NumTestSets
    
    fprintf('----- Fold %d  ----\n',i)
    trIdx = find( CVO.training(i)==1);
    teIdx = find( CVO.test(i)==1);
    
    %% Set the ratio of data to be used for the PWM
    M=max(size(trIdx)); PWM_TR=floor(M*PWM_Ratio);
    
    trIdx_PWM=trIdx(1:PWM_TR);

    %%  Generate the appropriate PWM based features for this classifiaction fold
    Miers1_Seq_pos_4PWM_TR=Miers1_Seq_pos(trIdx_PWM,:,:);Miers1_Seq_neg_4PWM_TR=Miers1_Seq_neg(trIdx_PWM,:,:);
    Miers2_Seq_pos_4PWM_TR=Miers2_Seq_pos(trIdx_PWM,:,:);Miers2_Seq_neg_4PWM_TR=Miers2_Seq_neg(trIdx_PWM,:,:);
    Miers3_Seq_pos_4PWM_TR=Miers3_Seq_pos(trIdx_PWM,:,:);Miers3_Seq_neg_4PWM_TR=Miers3_Seq_neg(trIdx_PWM,:,:);

    %% Prepare the sequences for Sequences to generate features for the Training and test 
    Miers1_Seq_pos_TR=Miers1_Seq_pos(trIdx,:,:);Miers1_Seq_neg_TR=Miers1_Seq_neg(trIdx,:,:);
    Miers2_Seq_pos_TR=Miers2_Seq_pos(trIdx,:,:);Miers2_Seq_neg_TR=Miers2_Seq_neg(trIdx,:,:);
    Miers3_Seq_pos_TR=Miers3_Seq_pos(trIdx,:,:);Miers3_Seq_neg_TR=Miers3_Seq_neg(trIdx,:,:);

    Miers1_Seq_pos_TS=Miers1_Seq_pos(teIdx,:,:);Miers1_Seq_neg_TS=Miers1_Seq_neg(teIdx,:,:);
    Miers2_Seq_pos_TS=Miers2_Seq_pos(teIdx,:,:);Miers2_Seq_neg_TS=Miers2_Seq_neg(teIdx,:,:);
    Miers3_Seq_pos_TS=Miers3_Seq_pos(teIdx,:,:);Miers3_Seq_neg_TS=Miers3_Seq_neg(teIdx,:,:);
    
    
    
    %% Genrate PWM based features from the generated PWMp_k and PWMn_k matrices
        %% Miers1
    [PWMp_Mier1_k,PWMn_Mier1_k]=CV_PWM_matrices_generatures3D(Miers1_Seq_pos_4PWM_TR,Miers1_Seq_neg_4PWM_TR);
    F_PWM_Mier1_TR=Apply_General_PWM_feature_generator(Miers1_Seq_pos_TR,Miers1_Seq_neg_TR, PWMp_Mier1_k,PWMn_Mier1_k); % Ys_train_Mier1_k=F_PWM_Mier1_TR(:,end);
    F_PWM_Mier1_TS=Apply_General_PWM_feature_generator(Miers1_Seq_pos_TS,Miers1_Seq_neg_TS, PWMp_Mier1_k,PWMn_Mier1_k);  %Ys_test_Mier1_k =F_PWM_Mier1_TS(:,end);  

        %% Miers2
    [PWMp_Mier2_k,PWMn_Mier2_k]=CV_PWM_matrices_generatures3D(Miers2_Seq_pos_4PWM_TR,Miers2_Seq_neg_4PWM_TR);
    F_PWM_Mier2_TR=Apply_General_PWM_feature_generator(Miers2_Seq_pos_TR,Miers2_Seq_neg_TR, PWMp_Mier2_k,PWMn_Mier2_k);  %Ys_train_Mier2_k=F_PWM_Mier2_TR(:,end);
    F_PWM_Mier2_TS=Apply_General_PWM_feature_generator(Miers2_Seq_pos_TS,Miers2_Seq_neg_TS, PWMp_Mier2_k,PWMn_Mier2_k);  %Ys_test_Mier2_k =F_PWM_Mier2_TS(:,end);  

        %% Miers3
    [PWMp_Mier3_k,PWMn_Mier3_k]=CV_PWM_matrices_generatures3D(Miers3_Seq_pos_4PWM_TR,Miers3_Seq_neg_4PWM_TR);
    F_PWM_Mier3_TR=Apply_General_PWM_feature_generator(Miers3_Seq_pos_TR,Miers3_Seq_neg_TR, PWMp_Mier3_k,PWMn_Mier3_k);  Ys_train_k=F_PWM_Mier3_TR(:,end);
    F_PWM_Mier3_TS=Apply_General_PWM_feature_generator(Miers3_Seq_pos_TS,Miers3_Seq_neg_TS, PWMp_Mier3_k,PWMn_Mier3_k);  Ys_test_k =F_PWM_Mier3_TS(:,end);  

    %% Get the appropriate fold part from the input Features 
    Other_features_train_k=[Fp_train(trIdx,1:end-1);Fn_train(trIdx,1:end-1)];
    NB_Miers=size(Miers,2);
    if NB_Miers==1
        PWM_Features_train_k=F_PWM_Mier1_TR(:,1:end-1);
        PWM_Features_test_k=F_PWM_Mier1_TS(:,1:end-1);

        elseif NB_Miers==2
            PWM_Features_train_k=[F_PWM_Mier1_TR(:,1:end-1) F_PWM_Mier2_TR(:,1:end-1) ];
            PWM_Features_test_k=[F_PWM_Mier1_TS(:,1:end-1) F_PWM_Mier2_TS(:,1:end-1) ];

             elseif NB_Miers==3
                 PWM_Features_train_k=[F_PWM_Mier1_TR(:,1:end-1) F_PWM_Mier2_TR(:,1:end-1) F_PWM_Mier3_TR(:,1:end-1)];
                 PWM_Features_test_k=[F_PWM_Mier1_TS(:,1:end-1) F_PWM_Mier2_TS(:,1:end-1)  F_PWM_Mier3_TS(:,1:end-1)];

    end
            
    %     
    Other_features_test_k =[Fp_train(teIdx,1:end-1);Fn_train(teIdx,1:end-1) ];
    PWM_Features_test_k=[F_PWM_Mier1_TS(:,1:end-1) F_PWM_Mier2_TS(:,1:end-1)  F_PWM_Mier3_TS(:,1:end-1)];
    %     

    Yf_train_k=[Yp_train(trIdx,:);    Yn_train(trIdx,:)];
    Yf_test_k=[Yp_train(teIdx,:);     Yn_train(teIdx,:)];
    
    %% Combine all features for the actual fold
    if norm(Ys_train_k-Yf_train_k)==0 & norm(Ys_test_k-Yf_test_k)==0

        if DSP==0
             Fold_k_TR=[PWM_Features_train_k    Ys_train_k];
             Fold_k_TS=[PWM_Features_test_k      Ys_test_k ];
        elseif DSP==1
            
                Fold_k_TR=[Other_features_train_k  Ys_train_k];
                Fold_k_TS=[Other_features_test_k   Ys_test_k ];
                
            elseif DSP==2
            
                Fold_k_TR=[PWM_Features_train_k  Other_features_train_k  Ys_train_k];
                Fold_k_TS=[PWM_Features_test_k   Other_features_test_k   Ys_test_k ];
                
        end


           
        [Mdl,accuracy0,sensitivity0,specificity0,precision0,gmean0,f1score0]=Test_Training_LR(Fold_k_TR,Fold_k_TS);

        %% Run the logitic regression 
        cnt0=cnt0+1;
        CV_results(cnt0,:)=[accuracy0,sensitivity0,specificity0,precision0,gmean0,f1score0];  

        if Acc_Max<accuracy0
            Mdl_optimal=Mdl;   Acc_Max=accuracy0;
            
           PWMp_Mier1_k_op=PWMp_Mier1_k;        PWMn_Mier1_k_op=PWMn_Mier1_k;
           PWMp_Mier2_k_op=PWMp_Mier2_k;        PWMn_Mier2_k_op=PWMn_Mier2_k;
           PWMp_Mier3_k_op=PWMp_Mier3_k;        PWMn_Mier3_k_op=PWMn_Mier3_k;

        end
        
    else
        disp('The features and sequences are not alligned. please recheck your input data :(:(')
        
        break;
        
    end
    
end
CV_Accuracy = sum(CV_results(:,1))/nb_folds;