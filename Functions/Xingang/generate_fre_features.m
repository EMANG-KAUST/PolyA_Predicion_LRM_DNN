%% creat the frequency-based feature table
function [fre_feature_pos,fre_feature_neg] = generate_fre_features(x,y)

% x --- the original mapped-data of positive sequence (8746)
% y --- the original mapped-data of negative sequence (11520)

% feature_table_pos --- a table (matrix) contains features generated from
% postive sequences
% feature_table_neg --- a table (matrix) contains features generated from
% negative sequences

warning off;

%% compute the features for positive sequences
feature_table_pos = table();
%% compute the features for positive sequences
current_Seq = x;
    % Daubechies wavelet 
for i = 1:max(size(current_Seq,1))
     % Calaculate the dominant frequency and the corresponding magnitude
     [maxfre,maxval] = dominant_frequency_features(current_Seq(i,:));
     feature_table_pos.maxfre(i,1) = maxfre;
     feature_table_pos.maxval(i,1) = maxval;
     % Calculate the mean frequency
     feature_table_pos.MeanFreq(i,1) = meanfreq(current_Seq(i,:));   
     % Calculate the median frequency
     feature_table_pos.MedFreq(i,1) = medfreq(current_Seq(i,:));
     % Calculate the Peak-magnitude-to-RMS ratio
     feature_table_pos.P2R(i,1) = peak2rms(current_Seq(i,:));      
     % Calculate the Root-Mean_Square
     feature_table_pos.rms(i,1) = rms(current_Seq(i,:));
     % Calculate the Root Sum of Squares Level
     feature_table_pos.rss(i,1) = rssq(current_Seq(i,:));
    
end
fre_feature_pos = [table2array(feature_table_pos) ones(max(size(x,1)),1)];

%% compute the features for negative sequences
feature_table_neg = table();
current_Seq = y;

for i = 1:max(size(current_Seq,1))
     % Calaculate the dominant frequency and the corresponding magnitude
    [maxfre,maxval] = dominant_frequency_features(current_Seq(i,:));
    feature_table_neg.maxfre(i,1) = maxfre;
    feature_table_neg.maxval(i,1) = maxval;
     % Calculate the mean frequency
     feature_table_neg.MeanFreq(i,1) = meanfreq(current_Seq(i,:));   
     % Calculate the median frequency
     feature_table_neg.MedFreq(i,1) = medfreq(current_Seq(i,:));
     % Calculate the Peak-magnitude-to-RMS ratio
     feature_table_neg.P2R(i,1) = peak2rms(current_Seq(i,:));      
     % Calculate the Root-Mean_Square
     feature_table_neg.rms(i,1) = rms(current_Seq(i,:));
     % Calculate the Root Sum of Squares Level
     feature_table_neg.rss(i,1) = rssq(current_Seq(i,:));
end
fre_feature_neg = [table2array(feature_table_neg) zeros(max(size(y,1)),1)];

end