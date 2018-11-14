function [Pos_features,Neg_features,yp_train,yn_train]=Split_Features_Pos_Neg(F_train)

Idxp=find(F_train(:,end)==1);Idxn=find(F_train(:,end)==0);

Pos_features=F_train(Idxp,:);yp_train=0*Idxp+1;
Neg_features=F_train(Idxn,:);yn_train=0*Idxn;
