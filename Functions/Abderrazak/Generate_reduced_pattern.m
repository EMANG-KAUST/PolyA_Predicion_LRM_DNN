function  [PR_featuresA, PR_featuresC, PR_featuresG, PR_featuresT, P_features_TOP0, P_features_TOP100, idxA0, idxC0, idxG0, idxT0]=Generate_reduced_pattern(TR, pos_EIIP_Seq0, neg_EIIP_Seq0, Patern_Value,Th_Seq, Name_Seq)
close all;
global idxA idxC idxG idxT
if TR==1
    Results_path='../Reduced_features/figures/TR_';
else
    Results_path='../Reduced_features/figures/TS_';

end

[NN0,MM0]=size(pos_EIIP_Seq0);
%% Extrauct the diracs
   figr=1; 
for k=1:max(size(Patern_Value))
    
    [pos_Dirac_Seq_all, neg_Dirac_Seq_all]=build_dirac_patern(pos_EIIP_Seq0, neg_EIIP_Seq0,Patern_Value(k));

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
   
    plot_pattern_error_PN(figr, W_pos, W_neg, W_err, W_err_sm, lgnd)

    %% Apply the thresolds
    th_max=max(W_err); th_min=min(W_err)
    Th_Seq(2,k)=th_max;
    eval([strcat('P_Dirac_features',Name_Seq{k},'=[pos_Dirac_Seq_all ; neg_Dirac_Seq_all];')]);

    
    %% Reduces futures Thresholds
    if TR==1
        eval([strcat('idx',Name_Seq{k},'=find(W_err>=Th_Seq(1,k));')])
    end
    eval([strcat('idx=idx',Name_Seq{k},';')])
    pos_Dirac_Seq_new=pos_Dirac_Seq_all(:,idx);
    neg_Dirac_Seq_new=neg_Dirac_Seq_all(:,idx);
    eval([strcat('PR_Dirac_features',Name_Seq{k},'=[pos_Dirac_Seq_new ; neg_Dirac_Seq_new];')]);

    %% Save Diracs errors
    save_fig_pdf(strcat(Results_path,Name_Seq{k},'/'),figr,strcat('error_pattern')) 
    save(strcat(Results_path,Name_Seq{k},'/features_variables.mat'));

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

%%  P with top

P_featuresA_TOP0=[P_featuresA(:,1:end-1)  P_features_TOP0];



%%
P_features_AT=[P_Dirac_featuresA P_Dirac_featuresT   Target_bit];
% P_features_AC=[P_Dirac_featuresA  P_Dirac_featuresC  Target_bit];
% P_features_AG=[P_Dirac_featuresA   P_Dirac_featuresG Target_bit];
% P_features_TC=[P_Dirac_featuresT P_Dirac_featuresC  Target_bit];
% P_features_TG=[P_Dirac_featuresT  P_Dirac_featuresG Target_bit];
% P_features_CG=[P_Dirac_featuresC P_Dirac_featuresG Target_bit];
% P_features_ATC=[P_Dirac_featuresA P_Dirac_featuresT P_Dirac_featuresC  Target_bit];
% P_features_ATG=[P_Dirac_featuresA P_Dirac_featuresT  P_Dirac_featuresG Target_bit];
% P_features_ACG=[P_Dirac_featuresA  P_Dirac_featuresC P_Dirac_featuresG Target_bit];
% P_features_TCG=[P_Dirac_featuresT P_Dirac_featuresC P_Dirac_featuresG Target_bit];
% P_features_ATCG=[P_Dirac_featuresA P_Dirac_featuresT P_Dirac_featuresC P_Dirac_featuresG Target_bit];
% P_features_ATCG_TOP0_100=[P_features_ATCG(:,1:end-1)  P_features_TOP0_100];
% P_features_A_TOP0_100=[P_featuresA(:,1:end-1)  P_features_TOP0_100];
P_features_AT_TOP0_100=[P_features_AT(:,1:end-1)  P_features_TOP0_100];

%% Pattern Reduced features
PR_featuresA= [PR_Dirac_featuresA];PR_featuresA(:,MM0+1)=  Target_bit ;
PR_featuresC= [PR_Dirac_featuresC];PR_featuresC(:,MM0+1)=  Target_bit ;
PR_featuresG= [PR_Dirac_featuresG];PR_featuresG(:,MM0+1)=  Target_bit ;
PR_featuresT= [PR_Dirac_featuresT];PR_featuresT(:,MM0+1)=  Target_bit ;



idxA0=idxA; idxC0=idxC; idxG0=idxG; idxT0=idxT;
   





