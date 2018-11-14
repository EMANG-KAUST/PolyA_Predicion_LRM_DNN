function [X,Y,Z]=Shuffle_data(X,Y,Z)

%% Shuffle the data
[M,N]=size(X);



for i=1:7
 shuffle_p=randi(M,[1 M]);X=X(shuffle_p,:);
 end



Y=Y(shuffle_p,:);
Z=Z(shuffle_p,:);
 








