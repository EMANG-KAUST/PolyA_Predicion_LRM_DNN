function [name_Miers, Miers_Seq_pos, Miers_Seq_neg]=Extract_Miers2(Patern_pos, Patern_neg)

Patern_pos0 = double(Patern_pos); Patern_neg0 = double(Patern_neg);

[M, N]=size(Patern_pos0);
k=0;
Necl{1}='A'; Necl{2}='C';Necl{3}='G';Necl{4}='T';


for N1=1:4
    for N2=1:4
        k=k+1; J_Miers=[N1,N2];
        name_Miers{k}=strcat(Necl{N1},Necl{N2});
        
        for i=1:M
            for j=1:N-1

                Mier=[Patern_pos0(i,j), Patern_pos0(i,j+1)];

                if norm(Mier-J_Miers)==0

                    Miers_Seq_pos(i,j,k)=1;

                else
                    Miers_Seq_pos(i,j,k)=0;
                end
                
                
                Mier=[Patern_neg0(i,j), Patern_neg0(i,j+1)];

                if norm(Mier-J_Miers)==0

                    Miers_Seq_neg(i,j,k)=1;

                else
                    Miers_Seq_neg(i,j,k)=0;
                end
                
                
            end 

        end
    end
end

