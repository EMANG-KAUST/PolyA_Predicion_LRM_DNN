function B=vec(C)
[m0,n0]=size(C);
I=eye(m0);
B= kron(I,C')*I(:);
end