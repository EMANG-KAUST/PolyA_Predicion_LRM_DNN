%% this function projects the binary patternn or the positive and negative data stored in 
% ACGT_pattern [pos_data; neg_data] to reduced dimension features 2*Nb_Layers

function [PWKp,PWKn]=General_PWM_matrices_generatures2D(pos_pattern,neg_pattern,Layers_sizes)

[Ma, Na]=size(pos_pattern);

Nb_Layers=max(size(Layers_sizes));
J=0
for k=1:Nb_Layers
     J=J(end)+1: J(end)+Layers_sizes(k);
    J(end)
    featuresK_pos=pos_pattern(:,J);
    featuresK_neg=neg_pattern(:,J);
    [PWKp(k,:), PWKn(k,:)]=GPWM_matrix_generator(featuresK_pos,featuresK_neg);
end
d=1;

function [PWRp,PWRn]=GPWM_matrix_generator(pos_Data,neg_Data)

[Mp, Np]=size(pos_Data); pos_target=ones([Mp,1]);[Mn, Nn]=size(neg_Data); neg_target=zeros([Mn,1]);


[Mn,Nn]=size(pos_Data);
[Mp,Np]=size(neg_Data);

M=Mp+Mn;
%% reconstruct the Dp
 DP=pos_Data;
 DN=neg_Data;

%% Creat the PWM 
One_vec=ones([1 Mp]);
PWRp=One_vec*DP;
PWRn=One_vec*DN;



