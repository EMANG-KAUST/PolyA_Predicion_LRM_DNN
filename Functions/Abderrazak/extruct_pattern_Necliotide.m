function DNA_seq=extruct_pattern_Necliotide(DNA_seq, A, A_new, En_wind)

    idxp=find(DNA_seq~=A ); 
    DNA_seq(idxp)=0; 
    DNA_seq=A_new.*(DNA_seq./max(max((DNA_seq))));
    
    if En_wind==1
    DNA_seq=windows_making(DNA_seq,A_new)
    end
    
    
function  DNA_seq=windows_making(DNA_seq,A_new)
N=max(size(DNA_seq));

for i=2:N
    
    if DNA_seq(i)==0 & DNA_seq(i-1)==A_new
        DNA_seq(i)=A_new;
    end
    
end