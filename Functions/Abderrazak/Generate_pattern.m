function  [ P_featuresA, P_featuresC, P_featuresG, P_featuresT]=Generate_pattern(pos_EIIP_Seq0, neg_EIIP_Seq0, Used_Mapping, Name_Seq)


[NN0,MM0]=size(pos_EIIP_Seq0);
%% Extrauct the diracs
   figr=1; 
for k=1:max(size(Used_Mapping))
    
    [pos_Dirac_Seq_all, neg_Dirac_Seq_all]=build_dirac_patern(pos_EIIP_Seq0, neg_EIIP_Seq0,Used_Mapping(k));

    %% Check the weigths of each dirac
    [N,M]=size(pos_Dirac_Seq_all);W_pos=100*sum(pos_Dirac_Seq_all,1)/N ;
    [N,M]=size(neg_Dirac_Seq_all);W_neg=100*sum(neg_Dirac_Seq_all,1)/N ;
    
    
        %% TOP 0
    eval([strcat('idx0',Name_Seq{k},'=find(W_neg==0 | W_pos==0 );')])
    eval([strcat('idx=idx0',Name_Seq{k},';')])
    pos_0=pos_Dirac_Seq_all(:,idx);
    neg_0=neg_Dirac_Seq_all(:,idx);
    eval([strcat('P_TOP0_features',Name_Seq{k},'=[pos_0 ; neg_0];')]);

    %% TOP 100
    eval([strcat('idx0',Name_Seq{k},'=find(W_neg==100 | W_pos==100 );')])
    eval([strcat('idx=idx0',Name_Seq{k},';')]);
    
    pos_100=pos_Dirac_Seq_all(:,idx);
    neg_100=neg_Dirac_Seq_all(:,idx);
    eval([strcat('P_TOP100_features',Name_Seq{k},'=[pos_100 ; neg_100];')]);

    %% THE ERROR 
    W_err= abs(W_neg-W_pos);
    W_err_sm = smooth(1:M,W_err,0.1,'rloess');
    
    
    figr=figr+1;
    lgnd{1}=strcat('S^+_',Name_Seq{k});lgnd{2}=strcat('S^-_',Name_Seq{k});
   
%     plot_pattern_error_PN(figr, W_pos, W_neg, W_err, W_err_sm, lgnd)

    %% Apply the thresolds
 
    eval([strcat('P_Dirac_features',Name_Seq{k},'=[pos_Dirac_Seq_all ; neg_Dirac_Seq_all];')]);

end


[Np,Mp]=size(pos_Dirac_Seq_all);
Target_p=ones(Np,1);
[Nn,Mn]=size(neg_Dirac_Seq_all);
Target_n=zeros(Nn,1);
Target_bit=[Target_p ;Target_n];


%% #################   Build the features    ########################
%% Top positions
P_features_TOP100=[P_TOP100_featuresA P_TOP100_featuresT P_TOP100_featuresC P_TOP100_featuresG  Target_bit];
P_features_TOP0=[P_TOP0_featuresA P_TOP0_featuresT P_TOP0_featuresC P_TOP0_featuresG  Target_bit];
P_features_TOP0_100=[P_features_TOP100(:,1:end-1)  P_features_TOP0];
%% Pattern diracs features
P_featuresA= [P_Dirac_featuresA Target_bit];
P_featuresT= [P_Dirac_featuresT Target_bit];
P_featuresC= [P_Dirac_featuresC Target_bit];
P_featuresG= [P_Dirac_featuresG Target_bit];

%%




