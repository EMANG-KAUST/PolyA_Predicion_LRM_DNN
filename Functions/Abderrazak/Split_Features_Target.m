function [Features,Target]=Split_Features_Target(D_features)
Features=D_features(:,1:end-1);Target=D_features(:,end);

