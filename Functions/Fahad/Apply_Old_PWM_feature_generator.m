function [features_PWR,PWRp, PWRn]=Apply_Old_PWM_feature_generator(S_data,PWRp, PWRn)
%% PWM Matrix normalization option 
[M, N]=size(S_data);M=M/2;
norm_rows=0;
PWRp=normalize_PWD_matrix(M,norm_rows, PWRp);
PWRn=normalize_PWD_matrix(M,norm_rows, PWRn);


%% Start feature generation 
pos_Data=S_data(1:M,:);
neg_Data=S_data(M+1:end,:);

[Mp, Np]=size(pos_Data); pos_target=ones([Mp,1]);[Mn, Nn]=size(neg_Data); neg_target=zeros([Mn,1]);
Target_bit=[pos_target;neg_target];  %% To be added at the end of the features_PWM features 

F_pos=Old_PWM_features_Generation(pos_Data, PWRp, PWRn);
F_neg=Old_PWM_features_Generation(neg_Data, PWRp, PWRn);

features_PWR=[F_pos;F_neg]; 



function F=Old_PWM_features_Generation(S_data, PWRp, PWRn)

[M, N]=size(S_data);

for k=1:M
    S=S_data(k,:);

 
    for i=1:N
        
        switch  S(i)
            
            case 1
                PWVp(i)=PWRp(1,i); PWVn(i)=PWRn(1,i);
                
            case 2
                PWVp(i)=PWRp(2,i); PWVn(i)=PWRn(2,i);
                
            case 3
                PWVp(i)=PWRp(3,i); PWVn(i)=PWRn(3,i);
                
            case 4
                PWVp(i)=PWRp(4,i); PWVn(i)=PWRn(4,i);
               
                
        end
        
        
        
        
    end
    
    
    PWR_vec=[PWVp;PWVn];
    
    
    F(k,:)=[sum(PWVp), sum(PWVn)];
    
end


d=1;

