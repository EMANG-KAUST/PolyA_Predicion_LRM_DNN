%% EIIP= Mapping=[0.126 0.134  0.0806 0.1335];

function [DNA_pattern, SEQ_Out1,SEQ_Out2]=read_DNA_Sequences(filename,Mapping1,Mapping2)

SEQ=fastaread(filename);


M=max(size(SEQ));

for k=1:M
    
    Xn(k,:)=nt2int(SEQ(k));
    
end


DNA_pattern=unique(Xn,'rows','stable');
[M N]=size(DNA_pattern);
Zn(1:M)=DNA_pattern(1:M);




for i=1:M
    
   for j=1:N
       x=DNA_pattern(i,j);
       
       switch x
           
           case 1
               SEQ_Out1(i,j)=Mapping1(1);
               SEQ_Out2(i,j)=Mapping2(1);
           case 2
               SEQ_Out1(i,j)=Mapping1(2);
               SEQ_Out2(i,j)=Mapping2(2);
           case 3
               SEQ_Out1(i,j)=Mapping1(3);
               SEQ_Out2(i,j)=Mapping2(3);
           case 4
               SEQ_Out1(i,j)=Mapping1(4);
               SEQ_Out2(i,j)=Mapping2(4);
           otherwise
               disp('error. non defined values ')
               x
       end
       
               
   end
   
end





