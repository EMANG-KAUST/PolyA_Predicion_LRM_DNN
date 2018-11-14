%% this function projects the binary patternn or the positive and negative data stored in 
% ACGT_pattern [pos_data; neg_data] to reduced dimension features 2*Nb_Layers

function [PWKp,PWKn]=General_PWM_matrices_generatures3D(pos_pattern,neg_pattern)

global Ratio_PWM


[Ma, Na,Nb_Layers]=size(pos_pattern);
Mpwm=floor(Ma*Ratio_PWM);
slice_PWM=randi( Ma, [1 Mpwm]);

for k=1:Nb_Layers
    
    if k==Nb_Layers
        target=1;
    else
        target=0;
     end
    
    s=(k-1)*2 +1: k*2+target;
   
    featuresK_pos=pos_pattern(slice_PWM,:,k);
    featuresK_neg=neg_pattern(slice_PWM,:,k);
    [PWKp(k,:), PWKn(k,:)]=GPWM_matrix_generator(featuresK_pos,featuresK_neg);
end


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



