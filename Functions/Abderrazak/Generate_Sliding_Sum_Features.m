function  [ SS1_P_featuresA0,  SS1_P_featuresC0,  SS1_P_featuresG0,  SS1_P_featuresT0,SS1_P_TOP0_100_features]=Generate_Sliding_Sum_Features(TR, Nb ,step, pos_EIIP_Seq0, neg_EIIP_Seq0, Patern_Value,Th_Seq, Name_Seq)

close all

if TR==1
    Results_path='../Reduced_features/figures/full_SS1_TR_';
else
    Results_path='../Reduced_features/figures/full_SS1_TS_';

end

[NN0,MM0]=size(pos_EIIP_Seq0);
%% Extrauct the diracs
   figr=1; 
for k=1:max(size(Patern_Value))
    
    [pos_Dirac_Seq_all, neg_Dirac_Seq_all]=build_dirac_patern(pos_EIIP_Seq0, neg_EIIP_Seq0,Patern_Value(k));
    [pos_SS1_Seq_all]= Sliding_sum_transform(pos_Dirac_Seq_all, Nb ,step);
    [neg_SS1_Seq_all]= Sliding_sum_transform(neg_Dirac_Seq_all, Nb ,step);
    Dirac_pos=pos_Dirac_Seq_all(1,:); Dirac_neg=neg_Dirac_Seq_all(1,:); SS1_pos=pos_SS1_Seq_all(1,:); SS1_neg=neg_SS1_Seq_all(1,:);
    figr=figr+1;
    lgnd{1}=strcat('S^+_',Name_Seq{k});lgnd{2}=strcat('S^-_',Name_Seq{k});
    lgnd2=strcat('SS1: N_b=',num2str(Nb), ', Step==',num2str(step));
    plot_SS_signal_PN(figr, Dirac_pos, Dirac_neg, SS1_pos, SS1_neg, lgnd,lgnd2)

    
%     %% Save SS1 signals 
%     save_fig_pdf(strcat(Results_path,Name_Seq{k},'/'),figr,strcat('SS1_signals')) 
%     save(strcat(Results_path,Name_Seq{k},'/features_variables.mat'));
    %% Check the weigths of each dirac
    [N,M]=size(pos_Dirac_Seq_all);W_pos=100*sum(pos_SS1_Seq_all,1)/N ;
    [N,M]=size(neg_Dirac_Seq_all);W_neg=100*sum(neg_SS1_Seq_all,1)/N ;
    
    %% TOP 0
    eval([strcat('idx0',Name_Seq{k},'=find(W_neg==0 | W_pos==0 );')])
    eval([strcat('idx=idx0',Name_Seq{k},';')])
    pos_0=pos_Dirac_Seq_all(:,idx);
    neg_0=neg_Dirac_Seq_all(:,idx);
    eval([strcat('SS1_P_TOP0_features',Name_Seq{k},'=[pos_0 ; neg_0];')]);

    %% TOP 100
    eval([strcat('idx0',Name_Seq{k},'=find(W_neg==100 | W_pos==100 );')])
    eval([strcat('idx=idx0',Name_Seq{k},';')]);
    
    pos_100=pos_Dirac_Seq_all(:,idx);
    neg_100=neg_Dirac_Seq_all(:,idx);
    eval([strcat('SS1_P_TOP100_features',Name_Seq{k},'=[pos_100 ; neg_100];')]);

    
    %% Check the error difference 
    W_err= abs(W_neg-W_pos); ;
    M00=max(size(W_err));
    W_err_sm = smooth(1:M00,W_err,0.1,'rloess');
    
    %% Apply the thresolds
    th_max=max(W_err); th_min=min(W_err)
    Th_Seq(2,k)=th_max;
    eval([strcat(' SS1_P_features',Name_Seq{k},'=[pos_SS1_Seq_all ; neg_SS1_Seq_all];')]);
    
%     
%     figr=figr+1;plot_pattern_error_PN(figr, W_pos, W_neg, W_err, W_err_sm, lgnd)
% 
%     
%     %% Reduces futures Thresholds
%     eval([strcat('idx',Name_Seq{k},'=find(W_err>=Th_Seq(1,k));')])
%     eval([strcat('idx=idx',Name_Seq{k},';')])
%     pos_SS1_Seq_new=pos_SS1_Seq_all(:,idx);
%     neg_SS1_Seq_new=neg_SS1_Seq_all(:,idx);
%     
%     eval([strcat(' SS1_PR_features',Name_Seq{k},'=[pos_SS1_Seq_new ; neg_SS1_Seq_new];')]);
% 
%     %% Save Diracs errors
%     save_fig_pdf(strcat(Results_path,Name_Seq{k},'/'),figr,strcat('error_pattern')) 
%     save(strcat(Results_path,Name_Seq{k},'/features_variables.mat'));

end

[Np,Mp]=size(pos_SS1_Seq_all);
Target_p=ones(Np,1);
[Nn,Mn]=size(neg_SS1_Seq_all);
Target_n=zeros(Nn,1);
    
Target_bit=[Target_p ;Target_n];


%% #################   Build the features    ########################
%% Top positions
SS1_P_TOP0_100_features=[SS1_P_TOP100_featuresA SS1_P_TOP100_featuresT SS1_P_TOP100_featuresC SS1_P_TOP100_featuresG  SS1_P_TOP0_featuresA SS1_P_TOP0_featuresT SS1_P_TOP0_featuresC SS1_P_TOP0_featuresG Target_bit];
SS1_P_TOP0_100_features=[SS1_P_TOP100_featuresA SS1_P_TOP100_featuresT SS1_P_TOP100_featuresC SS1_P_TOP100_featuresG  SS1_P_TOP0_featuresA SS1_P_TOP0_featuresT SS1_P_TOP0_featuresC SS1_P_TOP0_featuresG Target_bit];


%% Pattern diracs features
SS1_P_featuresA0= [ SS1_P_featuresA Target_bit];
SS1_P_featuresT0= [ SS1_P_featuresT Target_bit];
SS1_P_featuresC0= [ SS1_P_featuresC Target_bit];
SS1_P_featuresG0= [ SS1_P_featuresG Target_bit];
% 
% %% Pattern Reduced features
% SS1_PR_featuresA0= [ SS1_PR_featuresA Target_bit];
% SS1_PR_featuresT0= [ SS1_PR_featuresT Target_bit];
% SS1_PR_featuresC0= [ SS1_PR_featuresC Target_bit];
% SS1_PR_featuresG0= [ SS1_PR_featuresG Target_bit];


% %% Filter diacs by preferences
% SS1_Seq_all=[pos_SS1_Seq_all;neg_SS1_Seq_all];
% SS1_P_features_TACG=Necleotide_filtering_preiority(SS1_Seq_all,Target_bit, idxT,idxA,idxC,idxG);
% SS1_P_features_ATCG=Necleotide_filtering_preiority(SS1_Seq_all,Target_bit, idxA,idxT,idxC,idxG);
% SS1_P_features_CGTA=Necleotide_filtering_preiority(SS1_Seq_all,Target_bit, idxC,idxG, idxT,idxA);
% SS1_P_features_GCAT=Necleotide_filtering_preiority(SS1_Seq_all,Target_bit, idxC,idxG, idxA,idxT);

