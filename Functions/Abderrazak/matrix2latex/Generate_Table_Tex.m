% save the matrix as "A", and the col labels as "col"
%load('example2.mat')
load('example_After_Eric1.mat')

num=1;                         % the table number in the Tex
row_col=1;
en_sort=0;sort_idx=15;info_idx=20; 
seled_indx=[1:5,9, 11:16]; %seled_indx=[1:2, 6:10, 12, 14:20];


filename=strcat('../table_test.tex');
if en_sort==1
B= sortrows(A,info_idx);
idx=find(B(:,info_idx)==0);
C=B(idx,:);
D= sortrows(C,sort_idx);

matrix= D(:,seled_indx);

else
   matrix=A(:,seled_indx); 
end
col_Labels= col(seled_indx);
rowLabels= col_Labels;
  
  
if row_col==1
%     matrix = A;
  matrix2latex(matrix, filename , 'columnLabels', col_Labels, 'alignment', 'c', 'format', '%-6.2f', 'size', 'tiny');
  
else
  matrix=A';
  matrix2latex(matrix', filename , 'rowLabels', rowLabels, 'alignment', 'c', 'format', '%d', 'size', 'tiny');
end
% 
%   columnLabels = {'col 1', 'col 2'};
%   rowLabels = {'row 1', 'row 2'};
%   matrix2latex(matrix, filename , 'rowLabels', rowLabels, 'columnLabels', columnLabels, 'alignment', 'c', 'format', '%-6.2f', 'size', 'tiny');
