
function [SS1_Feature]= Sliding_sum_transform(X_train, Nb ,step)

%% Split the data 
Y=X_train(:,1:end-1);Target_bit=X_train(:,end);

T=Compute_Sliding_Summation(Y(1,:), Nb ,step );

[N M0]=size(Y);
[N0 M]=size(T);
Yn=zeros([N M]);
for i=1:N
    y=Y(i,:);
    Yn(i,:)=Compute_Sliding_sum(y, Nb ,step );  
end

SS1_Feature=[Yn, Target_bit];


function Y=Compute_Sliding_Summation(xn, N ,step )
Y=0;
M = max(size(xn));
cnt=1;
for i=1:step:M-N+1
xni=xn(i:i+N-1);  
Y(cnt)=sum(xni);
cnt=cnt+1;
end

