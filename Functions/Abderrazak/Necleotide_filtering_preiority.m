function [selected_features,IdxT,IdxA,IdxC,IdxG]=Necleotide_filtering_preiority(all_features,Target_bit, idxT,idxA,idxC,idxG)

[NN MM0]=size(all_features);
idx_DNA=[1:MM0]'

[IdxT] =unique(intersect(idxT,idx_DNA))
[idx_DNA] = setdiff(idx_DNA,IdxT);

[IdxA] =unique(intersect(idxA,idx_DNA))
[idx_DNA] = setdiff(idx_DNA,IdxA);


[IdxC] =unique(intersect(idxC,idx_DNA))
[idx_DNA] = setdiff(idx_DNA,IdxC);

[IdxG] =unique(intersect(idxG,idx_DNA))
[idx_DNA] = setdiff(idx_DNA,IdxG);

selected_features=[ all_features(:,IdxT) all_features(:,IdxA) all_features(:,IdxC) all_features(:,IdxG) Target_bit ];