function Y=Compute_Sliding_sum(xn, N ,step )
Y=0;
M = max(size(xn));
cnt=1;
for i=1:step:M-N+1
xni=xn(i:i+N-1);  
Y(cnt)=sum(xni);
cnt=cnt+1;
end
