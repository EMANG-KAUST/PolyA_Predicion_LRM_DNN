% F_features: filtred input 
% S_features: the whole negative eigenvalues spectrum 
% B_features: two first and last eigenvalues 
% P_features: sum of all normalised eigen functions
% AF_features: Area under the filtred input 

function [F_features, S_features, B_features, P_features,AF_features]=SCSA_Transform_features(X_train,h0,gm,fs)
%% Split the data 
features=X_train(:,1:end-1);Target_bit=X_train(:,end);

%% Run the scsa
[h, yscsaA,Nh,Neg_lamda,ProbaS]= SCSA_transform(features,fs,h0,gm);
F_features=[yscsaA,Target_bit];
AF_features=[trapz(yscsaA')',Target_bit];
% Neg_lamda( ~any(Neg_lamda,2), : ) = [];  Neg_lamda( :, ~any(Neg_lamda,1) ) = [];  %remove zero rows and columns
% Neg_lamda( ~any(Neg_lamda,2), : ) = [];  Neg_lamda( :, ~any(Neg_lamda,1) ) = [];  %remove zero rows and columns
S_features=[Neg_lamda,Target_bit];
B_features=[Neg_lamda(:,1:4) ,Target_bit];
P_features=[ProbaS ,Target_bit];


