function [J1, J2, J3]=get_eigen_Spectrum(J)

[N M0]= size(J);
if M0==0
    J1=1;J2=1;J3=1;
    
elseif M0==1
    J1=J(1);J2=1;J3=1;
 
elseif M0==2
    J1=J(1);J2=J(2);J3=1;
    
elseif M0>=3
    J1=J(1);J2=J(2);J3=J(end);
    
end