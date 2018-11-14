%% this function projects the binary patternn or the positive and negative data stored in 
% ACGT_pattern [pos_data; neg_data] to reduced dimension features 2*Dim_pattern

function [features_PWK,PWKp,PWKn]=Old_PWM_feature_generatures(ACGT_NO_pattern, ACGT_pattern,Dim_pattern)
[Ma, Na]=size(ACGT_pattern);
Step=Na/Dim_pattern;

for k=1:Dim_pattern
    
    if k==Dim_pattern
    target=1;
    else
        target=0;
    end
    
    J=(k-1)*Step +1: k*Step;
    s=(k-1)*2 +1: k*2+target;
   
    featuresK=ACGT_pattern(:,J);
    [M, N]=size(featuresK);M0=M/2;
    featuresK_pos=featuresK(1:M0,:);
    featuresK_neg=featuresK(M0+1:end,:);

    [features_PWK(:,s), PWKp(k,:), PWKn(k,:)]=GPWM_feature_generator(featuresK_pos,featuresK_neg,target);
   
    
end

%% PWM Matrix normalization option 
M=Ma/2;
norm_rows=0;
PWKp=normalize_PWD_matrix(M,norm_rows, PWKp);
PWKn=normalize_PWD_matrix(M,norm_rows, PWKn);

if norm_rows==0
clearvars features_PWK

[features_PWK]=Apply_Old_PWM_feature_generator(ACGT_NO_pattern,PWKp, PWKn, target);

end




function A_N=normalize_PWD_matrix(Mp, row, A)

[K,R]=size(A);

if row==1
    s_norm=sum(A');
    for i=1:K
    A_N(i,:)=A(i,:)./s_norm(i);
    end
else
    for i=1:K
    A_N(i,:)=A(i,:)./Mp;
    end
end

d=1;
