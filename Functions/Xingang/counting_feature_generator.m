function [counting_features, feature_table]= counting_feature_generator(TR_EIIP_pos,TR_EIIP_neg,start_p)
[Mp, Np]=size(TR_EIIP_pos); pos_target=ones([Mp,1]);[Mn, Nn]=size(TR_EIIP_neg); neg_target=zeros([Mn,1]);
Target_bit=[pos_target;neg_target];  %% To be added at the end of the counting_features features 
%% Add your features generation script
warning off;
feature_table = table();
current_EIIP = TR_EIIP_pos;
for i = 1:max(size(current_EIIP,1));
    % Calculate # of A,C,G features for EIIP 
    Count_ACG;
    feature_table.ConA_EIIP(i,1) = contP_A;
    feature_table.ConC_EIIP(i,1) = contP_C;
    feature_table.ConG_EIIP(i,1) = contP_G;
    % Calculate # of pair of nucleotides features for EIIP 
    Count_pairs;
    feature_table.ConAA_EIIP(i,1) = AA;
    feature_table.ConAT_EIIP(i,1) = AT;
    feature_table.ConCC_EIIP(i,1) = CC;
    feature_table.ConCG_EIIP(i,1) = CG;
    feature_table.ConCT_EIIP(i,1) = CT;
    feature_table.ConGC_EIIP(i,1) = GC;
    feature_table.ConGG_EIIP(i,1) = GG;
    feature_table.ConGT_EIIP(i,1) = GT;
    feature_table.ConTA_EIIP(i,1) = TA;
    feature_table.ConTG_EIIP(i,1) = TG;
end

current_EIIP = TR_EIIP_neg;
for i = 1:max(size(current_EIIP,1));
    % Calculate # of A,C,G features for EIIP 
    Count_ACG;
    feature_table.ConA_EIIP(i+Mp,1) = contP_A;
    feature_table.ConC_EIIP(i+Mp,1) = contP_C;
    feature_table.ConG_EIIP(i+Mp,1) = contP_G;
    % Calculate # of pair of nucleotides features for EIIP 
    Count_pairs;
    feature_table.ConAA_EIIP(i+Mp,1) = AA;
    feature_table.ConAT_EIIP(i+Mp,1) = AT;
    feature_table.ConCC_EIIP(i+Mp,1) = CC;
    feature_table.ConCG_EIIP(i+Mp,1) = CG;
    feature_table.ConCT_EIIP(i+Mp,1) = CT;
    feature_table.ConGC_EIIP(i+Mp,1) = GC;
    feature_table.ConGG_EIIP(i+Mp,1) = GG;
    feature_table.ConGT_EIIP(i+Mp,1) = GT;
    feature_table.ConTA_EIIP(i+Mp,1) = TA;
    feature_table.ConTG_EIIP(i+Mp,1) = TG;
end
feature_table.Target_bit = Target_bit;
counting_features = table2array(feature_table) ;
end