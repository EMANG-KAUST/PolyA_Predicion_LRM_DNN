%% creat the wavelet feature table
function [wavelet_feature_pos,wavelet_feature_neg] = generate_wavelet_features(x,y)

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
for i = 1:size(current_Seq,1)
    wavelet_features = DBWaveletFeature(current_Seq(i,:));
    feature_table_pos.Eg1(i,1) = wavelet_features(1);
    feature_table_pos.Eg2(i,1) = wavelet_features(2);
    feature_table_pos.Eg3(i,1) = wavelet_features(3);
    feature_table_pos.Eg4(i,1) = wavelet_features(4);
    feature_table_pos.Eg5(i,1) = wavelet_features(5);
    feature_table_pos.Eg6(i,1) = wavelet_features(6);
    feature_table_pos.Eg7(i,1) = wavelet_features(7);
    feature_table_pos.Eg8(i,1) = wavelet_features(8);  
    
end

wavelet_feature_pos = [table2array(feature_table_pos) ones(size(x,1),1)];

%% compute the features for negative sequences
feature_table_neg = table();
current_Seq = y;

for i = 1:size(current_Seq,1)
    % Daubechies wavelet 
    wavelet_features = DBWaveletFeature(current_Seq(i,:));
    feature_table_neg.Eg1(i,1) = wavelet_features(1);
    feature_table_neg.Eg2(i,1) = wavelet_features(2);
    feature_table_neg.Eg3(i,1) = wavelet_features(3);
    feature_table_neg.Eg4(i,1) = wavelet_features(4);
    feature_table_neg.Eg5(i,1) = wavelet_features(5);
    feature_table_neg.Eg6(i,1) = wavelet_features(6);
    feature_table_neg.Eg7(i,1) = wavelet_features(7);
    feature_table_neg.Eg8(i,1) = wavelet_features(8);
end

wavelet_feature_neg = [table2array(feature_table_neg) zeros(size(y,1),1)];

end

