function A=CF_T(B,half)
[M,N]=size(B);

Mh=M/2;
target=1;

if  half==0
    A=B(:,1:end-target);
    
    elseif half==1
        A=B(1:Mh,1:end-target); 
   
   
    elseif half==2
       A=B(Mh+1:end,1:end-target);
end