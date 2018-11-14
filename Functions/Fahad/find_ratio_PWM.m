function idx=find_ratio_PWM(folder)

N1=find(folder=='_');
s=find(folder=='s');
idx=str2num(folder(s+1:N1(end)-1));




