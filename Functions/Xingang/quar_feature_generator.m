function [quar_features, feature_table]= quar_feature_generator(TR_quar_pos,TR_quar_neg)

[Mp, Np]=size(TR_quar_pos); pos_target=ones([Mp,1]);[Mn, Nn]=size(TR_quar_neg); neg_target=zeros([Mn,1]);
Target_bit=[pos_target;neg_target];  %% To be added at the end of the quar_features features 

%% Add your features generation script
warning off;
feature_table = table();
current_quar = TR_quar_pos;
for i = 1:max(size(current_quar));
    % Calculate mean value feature for quar
    feature_table.Mean_quar(i,1) = mean(current_quar(i,:));
    
    % Calculate standard deviation feature for quar
    feature_table.Std_quar(i,1) = std(current_quar(i,:));
    
    % Calculate median feature for quar 
    feature_table.Median_quar(i,1) = median(current_quar(i,:));
    
    % Calculate mean absolute deviation featuer for quar
    feature_table.MAD_quar(i,1) = mad(current_quar(i,:));
    
    % Calculate signal 25th percentile for quar
    feature_table.Per25th_quar(i,1) = quantile(current_quar(i,:),0.25);
    
    % Calculate signal 75th percentile for quar
    feature_table.Per75th_quar(i,1) = quantile(current_quar(i,:),0.75);
    
    % Calculate signal inter quartile for quar 
    feature_table.SIQ_quar(i,1) = iqr(current_quar(i,:));
    
    % Calculate skewness of signal values for quar
    feature_table.Ske_quar(i,1) = skewness(current_quar(i,:));
    
    % Calculate kurtosis of signal values for quar
    feature_table.Kur_quar(i,1) = kurtosis(current_quar(i,:));
end

current_quar = TR_quar_neg;
for i = 1:max(size(current_quar));
    % Calculate mean value feature for quar
    feature_table.Mean_quar(i+Mp,1) = mean(current_quar(i,:));
    
    % Calculate standard deviation feature for quar
    feature_table.Std_quar(i+Mp,1) = std(current_quar(i,:));
    
    % Calculate median feature for quar 
    feature_table.Median_quar(i+Mp,1) = median(current_quar(i,:));
    
    % Calculate mean absolute deviation featuer for quar
    feature_table.MAD_quar(i+Mp,1) = mad(current_quar(i,:));
    
    % Calculate signal 25th percentile for quar
    feature_table.Per25th_quar(i+Mp,1) = quantile(current_quar(i,:),0.25);
    
    % Calculate signal 75th percentile for quar
    feature_table.Per75th_quar(i+Mp,1) = quantile(current_quar(i,:),0.75);
    
    % Calculate signal inter quartile for quar 
    feature_table.SIQ_quar(i+Mp,1) = iqr(current_quar(i,:));
    
    % Calculate skewness of signal values for quar
    feature_table.Ske_quar(i+Mp,1) = skewness(current_quar(i,:));
    
    % Calculate kurtosis of signal values for quar
    feature_table.Kur_quar(i+Mp,1) = kurtosis(current_quar(i,:));
end
feature_table.Target_bit = Target_bit;
quar_features = table2array(feature_table) ;
end

