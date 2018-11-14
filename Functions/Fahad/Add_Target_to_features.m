function F=Add_Target_to_features(F_data,T)

[M,N]=size(F_data);
Target_bit=T*ones([M,1]);

F=[F_data Target_bit];



