function [X_train, y_train, X_test, y_test,TR]=load_Prepare_DNA_Sequences(filename_p,filename_n,Type_mapping)
%% Load the DNA Mapping
% APPLY binary transformation ACGT
[Mapping_pattern_pos]=read_DNA_Sequences(filename_p,Type_mapping); [Mapping_pattern_neg]=read_DNA_Sequences(filename_n,Type_mapping);
[Mp, Np]=size(Mapping_pattern_pos);[Mn, Nn]=size(Mapping_pattern_neg);Mmin=min(Mp,Mn);TR=floor(0.8*Mmin);
%% Determine  the training  set
X_train_pos=Mapping_pattern_pos(1:TR,:);      X_train_neg=Mapping_pattern_neg(1:TR,:);
[Mp, Np]=size(X_train_pos);[Mn, Nn]=size(X_train_neg); Target_p=ones(Mp,1);Target_n=zeros(Mn,1);  
X_train=[X_train_pos;X_train_neg];  
y_train=[Target_p ;Target_n];

%% Determine the  testing set
X_test_pos=Mapping_pattern_pos(TR+1:Mmin,:);  X_test_neg=Mapping_pattern_neg(TR+1:Mmin,:);
[Mp, Np]=size(X_test_pos);[Mn, Nn]=size(X_test_neg); Target_p=ones(Mp,1);Target_n=zeros(Mn,1);  
X_test=[X_test_pos;X_test_neg];
y_test=[Target_p ;Target_n];

end
