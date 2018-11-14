function  [PR_featuresA, PR_featuresC, PR_featuresG, PR_featuresT, P_features_TOP0, P_features_TOP100]=Apply_reduced_pattern( idxA, idxC, idxG, idxT, S_input, t_input, Patern_Value,Th_Seq, Name_Seq)
close all;

Idxp=find(t_input==1);Idxn=find(t_input==0);
Pos_Seq=S_input(Idxp,:);
Neg_Seq=S_input(Idxn,:);

%% Extrauct the diracs
   figr=1; 
for k=1:max(size(Patern_Value))
    
    [Pos_Pattern_all, Neg_Pattern_all]=build_dirac_patern(Pos_Seq, Neg_Seq,Patern_Value(k));

    %% Check the weigths of each dirac
    [Np,M]=size(Pos_Pattern_all);W_pos=100*sum(Pos_Pattern_all,1)/Np ;
    [Nn,M]=size(Neg_Pattern_all);W_neg=100*sum(Neg_Pattern_all,1)/Nn ;
    
    
    %% TOP 0
    eval([strcat('idx0',Name_Seq{k},'=find(W_neg==0 | W_pos==0 );')])
    eval([strcat('idx=idx0',Name_Seq{k},';')])
    Pos_0=Pos_Pattern_all(:,idx);
    Neg_0=Neg_Pattern_all(:,idx);
    eval([strcat('P_TOP0_features',Name_Seq{k},'=[Pos_0 ; Neg_0];')]);

    %% TOP 100
    eval([strcat('idx0',Name_Seq{k},'=find(W_neg==100 | W_pos==100 );')])
    eval([strcat('idx=idx0',Name_Seq{k},';')]);
    
    Pos_100=Pos_Pattern_all(:,idx);
    Neg_100=Neg_Pattern_all(:,idx);
    eval([strcat('P_TOP100_features',Name_Seq{k},'=[Pos_100 ; Neg_100];')]);

    %% THE ERROR 
    W_err= abs(W_neg-W_pos);
    W_err_sm = smooth(1:M,W_err,0.1,'rloess');
    
    %% Reduces futures Thresholds
    eval([strcat('idx=idx',Name_Seq{k},';')])
    Pos_Pattern_new=Pos_Pattern_all(:,idx);
    Neg_Pattern_new=Neg_Pattern_all(:,idx);
    eval([strcat('PR_features',Name_Seq{k},'=[Pos_Pattern_new ; Neg_Pattern_new];')]);
end

%% #################   Build the features    ########################
%% Top positions
P_features_TOP100=[P_TOP100_featuresA P_TOP100_featuresT P_TOP100_featuresC P_TOP100_featuresG  t_input];
P_features_TOP0=[P_TOP0_featuresA P_TOP0_featuresT P_TOP0_featuresC P_TOP0_featuresG  t_input];

%% Pattern Reduced features
PR_featuresA= [PR_featuresA t_input];
PR_featuresC= [PR_featuresC  t_input];
PR_featuresG= [PR_featuresG  t_input];
PR_featuresT= [PR_featuresT  t_input];







