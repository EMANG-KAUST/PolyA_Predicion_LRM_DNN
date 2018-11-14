function  [idxA, idxC, idxG, idxT, Th_Seq]=Get_reduced_pattern_indexes( S_train, t_train,  Patern_Value,Th_Seq, Name_Seq,root_folder)
close all;

Idxp=find(t_train==1);Idxn=find(t_train==0);

Pos_Seq=S_train(Idxp,:);
Neg_Seq=S_train(Idxn,:);

 
%% Extrauct the diracs
   figr=1; 
for k=1:max(size(Patern_Value))
    
    [pos_pattern_all, neg_pattern_all]=build_dirac_patern(Pos_Seq, Neg_Seq,Patern_Value(k));

    %% Check the weigths of each dirac
    [Np,M]=size(pos_pattern_all);W_pos=100*sum(pos_pattern_all,1)/Np ;
    [Nn,M]=size(neg_pattern_all);W_neg=100*sum(neg_pattern_all,1)/Nn ;
    
    %% THE ERROR 
    W_err= abs(W_neg-W_pos);
    W_err_sm = smooth(1:M,W_err,0.1,'rloess');
    
    figr=figr+1;
    lgnd{1}=strcat('S^+_',Name_Seq{k});lgnd{2}=strcat('S^-_',Name_Seq{k});
    plot_pattern_error_PN(figr, W_pos, W_neg, W_err, W_err_sm, lgnd)

    %% Apply the thresolds
    th_max=max(W_err); th_min=min(W_err);
    Th_Seq(2,k)=th_max;
    eval([strcat('P_Dirac_features',Name_Seq{k},'=[pos_pattern_all ; neg_pattern_all];')]);

    %% Reduces futures Thresholds
    eval([strcat('idx',Name_Seq{k},'=find(W_err>=Th_Seq(1,k));')])
    
    %% Save Diracs errors
    Results_path=strcat(root_folder,'figures/');
    save_fig_pdf(strcat(Results_path,Name_Seq{k},'/'),figr,strcat('error_pattern')) 
end
   





