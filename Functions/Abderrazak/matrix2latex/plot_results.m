close all

N=size(C,1);
t=C(:,sort_idx);
figure
cntr=0;
for i=[6 18]
subplot(3,1,1);plot(t,((i-6)*100+1)*C(:,i));hold on
cntr=cntr+1;
seled_indx0(cntr)=i;
end
legend(col(seled_indx0))
xlim([min(t) max(t)])
%xlim([min(t) 6])


% subplot(3,1,1);plot(C(:,i) );hold on

cntr=0;
for i=[7 8]
subplot(3,1,2);plot(t,C(:,i));hold on
cntr=cntr+1;
seled_indx2(cntr)=i;
end
legend(col(seled_indx2))
xlim([min(t) max(t)])
%xlim([min(t) 6])

cntr=0;
for i=[9 10 16  19 20 ]
subplot(3,1,3);plot(t,C(:,i));hold on
cntr=cntr+1;
seled_indx3(cntr)=i;
end
legend(col(seled_indx3))
xlim([min(t) max(t)])
%xlim([min(t) 6])
