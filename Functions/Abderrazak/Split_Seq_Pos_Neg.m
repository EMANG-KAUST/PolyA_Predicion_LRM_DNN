function [Pos_Seq,Neg_Seq,yp_train,yn_train]=Split_Seq_Pos_Neg(S_train, y_train)

Idxp=find(y_train==1);Idxn=find(y_train==0);

Pos_Seq=S_train(Idxp,:);yp_train=0*Idxp+1;
Neg_Seq=S_train(Idxn,:);yn_train=0*Idxn;
