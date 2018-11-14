
function [hNh_features, FNh_features, SNh_features, PNh_features]=SCSA_Sperctum_features(features,Target_bit,Nh0,gm,fs)

[h0, Y,Nh,Eigen, ProbaS]= SCSA_transform_Sperctum(Nh0, features,fs,gm);
Eigen( ~any(Eigen,2), : ) = [];  Eigen( :, ~any(Eigen,1) ) = [];  %remove zero rows and columns
ProbaS( ~any(ProbaS,2), : ) = [];  ProbaS( :, ~any(ProbaS,1) ) = [];  %remove zero rows and columns

hNh_features=[h0',Target_bit];
FNh_features=[Y,Target_bit];
Nh_features=[Nh',Target_bit];
SNh_features=[Eigen,Target_bit];
PNh_features=[ProbaS,Target_bit];


