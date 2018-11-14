function [EIIP_features, feature_table]= EIIP_feature_generator(TR_EIIP_pos,TR_EIIP_neg)

[Mp, Np]=size(TR_EIIP_pos); pos_target=ones([Mp,1]);[Mn, Nn]=size(TR_EIIP_neg); neg_target=zeros([Mn,1]);
Target_bit=[pos_target;neg_target];  %% To be added at the end of the EIIP_features features 

%% Add your features generation script
warning off;
feature_table = table();
current_EIIP = TR_EIIP_pos;
for i = 1:max(size(current_EIIP,1));
    % Calculate mean value feature for EIIP
    feature_table.Mean_EIIP(i,1) = mean(current_EIIP(i,:));
    
    % Calculate standard deviation feature for EIIP
    feature_table.Std_EIIP(i,1) = std(current_EIIP(i,:));
    
    % Calculate median feature for EIIP 
    feature_table.Median_EIIP(i,1) = median(current_EIIP(i,:));
    
    % Calculate mean absolute deviation featuer for EIIP
    feature_table.MAD_EIIP(i,1) = mad(current_EIIP(i,:));
    
    % Calculate signal 25th percentile for EIIP
    feature_table.Per25th_EIIP(i,1) = quantile(current_EIIP(i,:),0.25);
    
    % Calculate signal 75th percentile for EIIP
    feature_table.Per75th_EIIP(i,1) = quantile(current_EIIP(i,:),0.75);
    
    % Calculate signal inter quartile for EIIP 
    feature_table.SIQ_EIIP(i,1) = iqr(current_EIIP(i,:));
    
    % Calculate skewness of signal values for EIIP
    feature_table.Ske_EIIP(i,1) = skewness(current_EIIP(i,:));
    
    % Calculate kurtosis of signal values for EIIP
    feature_table.Kur_EIIP(i,1) = kurtosis(current_EIIP(i,:));
end

current_EIIP = TR_EIIP_neg;
for i = 1:max(size(current_EIIP,1));
    % Calculate mean value feature for EIIP
    feature_table.Mean_EIIP(i+Mp,1) = mean(current_EIIP(i,:));
    
    % Calculate standard deviation feature for EIIP
    feature_table.Std_EIIP(i+Mp,1) = std(current_EIIP(i,:));
    
    % Calculate median feature for EIIP 
    feature_table.Median_EIIP(i+Mp,1) = median(current_EIIP(i,:));
    
    % Calculate mean absolute deviation featuer for EIIP
    feature_table.MAD_EIIP(i+Mp,1) = mad(current_EIIP(i,:));
    
    % Calculate signal 25th percentile for EIIP
    feature_table.Per25th_EIIP(i+Mp,1) = quantile(current_EIIP(i,:),0.25);
    
    % Calculate signal 75th percentile for EIIP
    feature_table.Per75th_EIIP(i+Mp,1) = quantile(current_EIIP(i,:),0.75);
    
    % Calculate signal inter quartile for EIIP 
    feature_table.SIQ_EIIP(i+Mp,1) = iqr(current_EIIP(i,:));
    
    % Calculate skewness of signal values for EIIP
    feature_table.Ske_EIIP(i+Mp,1) = skewness(current_EIIP(i,:));
    
    % Calculate kurtosis of signal values for EIIP
    feature_table.Kur_EIIP(i+Mp,1) = kurtosis(current_EIIP(i,:));
end
feature_table.Target_bit = Target_bit;
EIIP_features = table2array(feature_table) ;
end