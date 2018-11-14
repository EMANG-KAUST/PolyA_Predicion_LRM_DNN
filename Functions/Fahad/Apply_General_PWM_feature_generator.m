%% the pos_pattern,neg_pattern should be binary patterns

function [features_GPWM]=Apply_General_PWM_feature_generator(pos_pattern,neg_pattern, PWRp, PWRn)
%% PWM Matrix normalization option 
[Mp, Np,Nb_Layers]=size(pos_pattern); pos_target=ones([Mp,1]);[Mn, Nn,Nb_Layers]=size(neg_pattern); neg_target=zeros([Mn,1]);

Target_bit=[pos_target; neg_target];


norm_rows=1;
PWRp=normalize_PWD_matrix(Mp,norm_rows, PWRp);
PWRn=normalize_PWD_matrix(Mn,norm_rows, PWRn);

%% Start feature generation 


for k=1:Nb_Layers

    s=(k-1)*2 +1: k*2;
    patternK_pos=pos_pattern(:,:,k);
    patternK_neg=neg_pattern(:,:,k);
    PWVp=PWRp(k,:);
    PWVn=PWRn(k,:);
    [features_PWK(:,s)]=GPWM_feature_generator(patternK_pos,patternK_neg,PWVp,PWVn);  

end

%% Add the target 
features_GPWM=[features_PWK, Target_bit];


function [features_PWK]=GPWM_feature_generator(patternK_pos,patternK_neg,PWRp,PWRn)
Pattern=[patternK_pos;patternK_neg];
PWM=[PWRp;PWRn];
features_PWK=Pattern*PWM';


