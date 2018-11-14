function [Data_pos, Data_neg, y_pos,y_neg]=load_Pos_Neg_DNA_Sequences(filename_p,filename_n,Type_mapping)
%% Load the DNA Mapping
% APPLY binary transformation ACGT
[Data_pos]=read_DNA_Sequences(filename_p,Type_mapping); 
[Mp, Np]=size(Data_pos); y_pos=ones(Mp,1);

[Data_neg]=read_DNA_Sequences(filename_n,Type_mapping);
[Mn, Nn]=size(Data_neg); y_neg=zeros(Mn,1);  

end
