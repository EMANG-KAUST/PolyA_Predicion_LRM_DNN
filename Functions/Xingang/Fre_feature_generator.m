function [Fre_features, feature_table]= Fre_feature_generator(TR_EIIP_pos,TR_EIIP_neg)

[Mp, N0]=size(TR_EIIP_pos); pos_target=ones([Mp,1]);[Mn, N0]=size(TR_EIIP_neg); neg_target=zeros([Mn,1]);
Target_bit=[pos_target;neg_target]; 

%% Generate feature table
warning off;
feature_table = table();
current_Seq = TR_EIIP_pos;
for i = 1:Mp
    
    [maxfre,maxval] = dominant_frequency_features(current_Seq(i,:));
    feature_table.maxfre(i,1) = maxfre;
    feature_table.maxval(i,1) = maxval;
    
end

current_Seq = TR_EIIP_neg;
for i = 1:Mn
    
    [maxfre,maxval] = dominant_frequency_features(current_Seq(i,:));
    feature_table.maxfre(i+Mp,1) = maxfre;
    feature_table.maxval(i+Mp,1) = maxval;
    
end
feature_table.Target_bit = Target_bit;
Fre_features = table2array(feature_table) ;
end


